// pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayershell.Top

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 200 // Assez grand pour l'expansion du Dynamic Island
    exclusiveZone: Config.barHeight + Config.margin * 2

    SystemData {
        id: sys
    }

    color: "transparent"

    // Le masque permet de cliquer à travers les zones transparentes de la fenêtre
    mask: Region {
        Region {
            item: barContainer
        }
        Region {
            item: islandItem
        }
    }

    Item {
        id: barContainer
        width: parent.width
        height: Config.barHeight + Config.margin * 2

        Item {
            anchors.fill: parent
            anchors.topMargin: Config.margin
            anchors.leftMargin: Config.sideMargin
            anchors.rightMargin: Config.sideMargin

            readonly property int commonTop: (Config.barHeight - Config.moduleHeight) / 2

            // --- GAUCHE ---
            Row {
                id: leftModules
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: parent.commonTop
                spacing: Config.spacing

                BaseModule {
                    id: wsBase
                    moduleWidth: 190
                    content: Row {
                        anchors.centerIn: parent
                        spacing: 8
                        Repeater {
                            model: 9
                            delegate: Item {
                                readonly property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                                readonly property bool isFocused: Hyprland.focusedWorkspace?.id === (index + 1)
                                implicitWidth: isFocused ? 28 : (wsMouse.containsMouse ? 16 : 10)
                                implicitHeight: 10
                                anchors.verticalCenter: parent.verticalCenter
                                Behavior on implicitWidth {
                                    NumberAnimation {
                                        duration: 300
                                        easing.type: Easing.OutBack
                                    }
                                }
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 5
                                    color: parent.isFocused ? Config.accent : (parent.ws ? Config.alt : Config.empty)
                                    opacity: parent.isFocused ? 1 : (parent.ws ? 0.8 : 0.2)
                                }
                                MouseArea {
                                    id: wsMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                                }
                            }
                        }
                    }
                }

                BaseModule {
                    content: Row {
                        anchors.centerIn: parent
                        spacing: 8
                        Image {
                            source: "icons/disk.svg"
                            sourceSize: Qt.size(16, 16)
                        }
                        Text {
                            text: sys.diskUsage + "%"
                            color: Config.text
                            font.bold: true
                            font.pixelSize: Config.fontSize
                            font.family: Config.fontFamily
                            height: 16
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    onClicked: Hyprland.dispatch("exec kitty btop")
                }

                BaseModule {
                    content: Row {
                        anchors.centerIn: parent
                        spacing: 8
                        Image {
                            source: "icons/cpu.svg"
                            sourceSize: Qt.size(16, 16)
                        }
                        Text {
                            text: sys.cpuUsage + "%"
                            color: Config.text
                            font.bold: true
                            font.pixelSize: Config.fontSize
                            font.family: Config.fontFamily
                            height: 16
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    onClicked: Hyprland.dispatch("exec kitty btop")
                }

                BaseModule {
                    content: Row {
                        anchors.centerIn: parent
                        spacing: 8
                        Image {
                            source: "icons/ram.svg"
                            sourceSize: Qt.size(16, 16)
                        }
                        Text {
                            text: sys.memUsage + "%"
                            color: Config.text
                            font.bold: true
                            font.pixelSize: Config.fontSize
                            font.family: Config.fontFamily
                            height: 16
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    onClicked: Hyprland.dispatch("exec kitty btop")
                }
            }

            // --- CENTRE ---
            DynamicIsland {
                id: islandItem
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: parent.commonTop
                weatherData: sys.weatherData
                z: 100
            }

            // --- DROITE ---
            Row {
                id: rightModules
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: parent.commonTop
                spacing: Config.spacing

                BaseModule {
                    moduleWidth: (btLabel.text.length * 8) + 43
                    content: Row {
                        anchors.centerIn: parent
                        spacing: 8
                        Image {
                            source: "icons/bluetooth.svg"
                            sourceSize: Qt.size(16, 16)
                            opacity: sys.bluetoothOn ? 1 : 0.3
                        }
                        Text {
                            id: btLabel
                            text: !sys.bluetoothOn ? "off" : (sys.bluetoothDevice || "on")
                            color: Config.text
                            font.bold: true
                            font.pixelSize: Config.fontSize
                            font.family: Config.fontFamily
                            height: 16
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    onClicked: Hyprland.dispatch("exec blueman-manager")
                }

                BaseModule {
                    moduleWidth: (sys.wifiName.length * 8) + 40
                    content: Row {
                        anchors.centerIn: parent
                        spacing: 8
                        // Icône : Image pour WiFi, Texte (Nerd Font) pour Ethernet
                        Image {
                            visible: !sys.isWired
                            source: "icons/wifi.svg"
                            sourceSize: Qt.size(16, 16)
                            opacity: sys.wifiName !== "Déconnecté" ? 1 : 0.3
                        }
                        Text {
                            visible: sys.isWired
                            text: "󰈀" // Icône Ethernet Nerd Font
                            color: Config.accent
                            font.pixelSize: 18
                            font.family: Config.fontFamily
                            height: 16
                            verticalAlignment: Text.AlignVCenter
                        }
                        Text {
                            text: sys.wifiName
                            color: Config.text
                            font.bold: true
                            font.pixelSize: Config.fontSize
                            font.family: Config.fontFamily
                            height: 16
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    onClicked: Hyprland.dispatch("exec kitty nmtui")
                }

                BaseModule {
                    content: Row {
                        anchors.centerIn: parent
                        spacing: 8
                        Image {
                          source: sys.batteryStatus === "Charging" ? "icons/battery-charging.svg" : "icons/battery.svg"
                          sourceSize: Qt.size(16, 16)
                        }
                        Text {
                            text: sys.batteryLevel + "%"
                            color: Config.text
                            font.bold: true
                            font.pixelSize: Config.fontSize
                            font.family: Config.fontFamily
                            height: 16
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    onClicked: Hyprland.dispatch("exec xfce4-power-manager-settings")
                }

                Item {
                    width: timeIsland.moduleWidth
                    height: Config.moduleHeight
                    BaseModule {
                        property bool showDate: false
                        id: timeIsland
                        anchors.horizontalCenter: parent.horizontalCenter
                        moduleWidth: showDate ? 144 : 84
                        containsMouse: timeMouse.containsMouse
                        isPressed: timeMouse.pressed
                        content: Item {
                            anchors.fill: parent
                            Row {
                                anchors.centerIn: parent
                                spacing: 8
                                Image {
                                    source: "icons/clock.svg"
                                    sourceSize: Qt.size(16, 16)
                                }
                                Text {
                                    text: timeIsland.showDate ? sys.shortDate : sys.time
                                    color: Config.text
                                    font.bold: true
                                    font.pixelSize: Config.fontSize
                                    font.family: Config.fontFamily
                                    height: 16
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                        MouseArea {
                            id: timeMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: timeIsland.showDate = !timeIsland.showDate
                        }
                    }
                }

                BaseModule {
                    moduleWidth: 36
                    content: Item {
                        anchors.fill: parent
                        Image {
                            anchors.centerIn: parent
                            source: "icons/power.svg"
                            sourceSize: Qt.size(16, 16)
                        }
                    }
                    onClicked: Hyprland.dispatch("exec ~/.local/bin/power")
                }
            }
        }
    }
}
