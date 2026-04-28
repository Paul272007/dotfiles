import QtQuick
import Quickshell.Io

QtObject {
    id: sysData

    property string time: ""
    property int cpuUsage: 0
    property var cpuCores: []
    property int memUsage: 0
    property int diskUsage: 0
    property string wifiName: "Déconnecté"
    property bool bluetoothOn: false
    property var weatherData: ({})

    property var lastCpuTotals: []
    property var lastCpuIdles: []

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

    property Timer mainTimer: Timer {
        interval: 2000; running: true; repeat: true; triggeredOnStart: true
        onTriggered: {
            sysData.cpuProc.running = true;
            sysData.memProc.running = true;
            let d = new Date();
            sysData.time = d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        }
    }

    property Timer slowTimer: Timer {
        interval: 60000; running: true; repeat: true; triggeredOnStart: true
        property int count: 15 // Force le premier passage
        onTriggered: {
            sysData.diskProc.running = true;
            sysData.wifiProc.running = true;
            sysData.btProc.running = true;
            if (++count >= 15) { sysData.weatherProc.running = true; count = 0; }
        }
    }
}
