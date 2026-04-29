import QtQuick
import Quickshell.Io

QtObject {
    id: sysData

    property string time: ""
    property string fullDate: ""
    property string shortDate: ""
    property int cpuUsage: 0
    property var cpuCores: []
    property int memUsage: 0
    property int diskUsage: 0
    property string wifiName: "Déconnecté"
    property bool bluetoothOn: false
    property int batteryLevel: 0
    property string batteryStatus: ""
    property string batteryTime: ""
    property int volume: 0
    property bool volumeMuted: false
    property int micVolume: 0
    property bool micMuted: false
    property int brightness: 0
    property var weatherData: ({})
    property string mediaTitle: ""
    property string mediaArtist: ""
    property string mediaStatus: "Stopped"

    signal osdEvent(string type, int value, bool muted)

    property Process cpuProc: Process {
        command: ["sh", "-c", "grep '^cpu' /proc/stat"]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.trim().split("\n");
                let newCores = [];
                lines.forEach((line, index) => {
                    let p = line.trim().split(/\s+/);
                    let idle = parseInt(p[4]) + parseInt(p[5]);
                    let total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);
                    if (sysData.lastCpuTotals[index]) {
                        let diffTotal = total - sysData.lastCpuTotals[index];
                        let diffIdle = idle - sysData.lastCpuIdles[index];
                        let usage = Math.round(100 * (1 - diffIdle / diffTotal));
                        if (index === 0) sysData.cpuUsage = usage;
                        else newCores.push(usage);
                    }
                    sysData.lastCpuTotals[index] = total;
                    sysData.lastCpuIdles[index] = idle;
                });
                sysData.cpuCores = newCores;
            }
        }
    }
    property var lastCpuTotals: []
    property var lastCpuIdles: []

    property Process memProc: Process {
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                let parts = data.trim().split(/\s+/);
                sysData.memUsage = Math.round(100 * parseInt(parts[2]) / parseInt(parts[1]));
            }
        }
    }

    property Process diskProc: Process {
        command: ["sh", "-c", "df /home --output=pcent | tail -1"]
        stdout: SplitParser {
            onRead: data => sysData.diskUsage = parseInt(data.trim().replace("%", ""))
        }
    }

    property Process weatherProc: Process {
        command: ["/home/paul/.zc/bin/weather"]
        stdout: StdioCollector {
            onStreamFinished: {
                try { sysData.weatherData = JSON.parse(this.text); } catch(e) {}
            }
        }
    }

    property Process wifiProc: Process {
        command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^oui' | cut -d: -f2"]
        stdout: StdioCollector { onStreamFinished: sysData.wifiName = this.text.trim() || "Déconnecté" }
    }

    property Process btProc: Process {
        command: ["sh", "-c", "bluetoothctl show | grep 'Powered: yes'"]
        stdout: StdioCollector { onStreamFinished: sysData.bluetoothOn = this.text.includes("yes") }
    }

    property Process batteryProc: Process {
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/capacity; cat /sys/class/power_supply/BAT0/status; upower -i $(upower -e | grep 'BAT') | grep 'time to' | cut -d: -f2"]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.trim().split("\n");
                sysData.batteryLevel = parseInt(lines[0]) || 0;
                let status = (lines[1] || "").trim();
                sysData.batteryStatus = status;
                let time = (lines[2] || "").trim().replace("hours", "h").replace("hour", "h").replace("minutes", "min").replace("minute", "min");
                if (status === "Full" || status === "Fully charged") sysData.batteryTime = "Pleine";
                else if (status === "Charging" && !time) sysData.batteryTime = "Secteur";
                else if (status === "Charging") sysData.batteryTime = "Fin dans " + time;
                else if (!time) sysData.batteryTime = "Calcul...";
                else sysData.batteryTime = time + " restants";
            }
        }
    }

    property Process volProc: Process {
        command: ["sh", "-c", "pamixer --get-volume; pamixer --get-mute"]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.trim().split("\n");
                let v = parseInt(lines[0]);
                let m = lines[1] === "true";
                if (v !== sysData.volume || m !== sysData.volumeMuted) {
                    sysData.volume = v;
                    sysData.volumeMuted = m;
                    sysData.osdEvent("volume", v, m);
                }
            }
        }
    }

    property Process micProc: Process {
        command: ["sh", "-c", "pamixer --default-source --get-volume; pamixer --default-source --get-mute"]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.trim().split("\n");
                let v = parseInt(lines[0]);
                let m = lines[1] === "true";
                if (v !== sysData.micVolume || m !== sysData.micMuted) {
                    sysData.micVolume = v;
                    sysData.micMuted = m;
                    sysData.osdEvent("mic", v, m);
                }
            }
        }
    }

    property Process brightProc: Process {
        command: ["sh", "-c", "brightnessctl -m | cut -d, -f4 | tr -d '%'"]
        stdout: SplitParser {
            onRead: data => {
                let b = parseInt(data.trim());
                if (b !== sysData.brightness) {
                    sysData.brightness = b;
                    sysData.osdEvent("brightness", b, false);
                }
            }
        }
    }

    property Process mediaProc: Process {
        command: ["sh", "-c", "playerctl metadata --format '{{title}}||{{artist}}||{{status}}' 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: {
                let parts = this.text.trim().split("||");
                if (parts.length >= 3) {
                    sysData.mediaTitle = parts[0];
                    sysData.mediaArtist = parts[1];
                    sysData.mediaStatus = parts[2];
                } else {
                    sysData.mediaStatus = "Stopped";
                }
            }
        }
    }

    property Timer mainTimer: Timer {
        interval: 2000; running: true; repeat: true; triggeredOnStart: true
        onTriggered: {
            sysData.cpuProc.running = true;
            sysData.memProc.running = true;
            let d = new Date();
            sysData.time = d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            sysData.fullDate = d.toLocaleDateString(undefined, { weekday: 'long', day: 'numeric', month: 'long' });
            sysData.shortDate = d.toLocaleDateString(undefined, { day: 'numeric', month: 'short' }).replace(".", "");
            sysData.fullDate = sysData.fullDate.charAt(0).toUpperCase() + sysData.fullDate.slice(1);
        }
    }

    // Timer ultra-rapide pour l'OSD (Volume/Luminosité)
    property Timer osdFastTimer: Timer {
        interval: 100; running: true; repeat: true; triggeredOnStart: true
        onTriggered: {
            sysData.volProc.running = true;
            sysData.micProc.running = true;
            sysData.brightProc.running = true;
            sysData.mediaProc.running = true;
        }
    }

    property Timer slowTimer: Timer {
        interval: 60000; running: true; repeat: true; triggeredOnStart: true
        property int count: 15
        onTriggered: {
            sysData.diskProc.running = true;
            sysData.wifiProc.running = true;
            sysData.btProc.running = true;
            sysData.batteryProc.running = true;
            if (++count >= 15) { sysData.weatherProc.running = true; count = 0; }
        }
    }
}
