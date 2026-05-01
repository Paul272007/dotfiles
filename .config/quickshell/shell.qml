// pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }
    mask: Region {
        Region {
            item: barContainer
        }
        Region {
            item: dynamicIsland
        }
    }

    implicitHeight: 200
    exclusiveZone: Config.barHeight // + Config.margin * 2

    SystemData { id: sys }

    FullscreenOSD {
        sysData: sys
    }

    color: "transparent"

    // --- CENTRE ---
    DynamicIsland {
        id: dynamicIsland
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: Config.margin + (hasMedia ? 0 : Config.barHeight - Config.moduleHeight) / 2
        weatherData: sys.weatherData
        z: 100
    }

    Item {
        id: barContainer
        width: parent.width
        height: Config.barHeight + Config.margin * 2

        Item {
            anchors {
                fill: parent
                topMargin: Config.margin
                bottomMargin: Config.margin
                leftMargin: Config.sideMargin
                rightMargin: Config.sideMargin
            }

            // --- GAUCHE ---
            Row {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: Config.spacing

                BaseModule {
                    id: wsBase
                    implicitWidth: 190
                    content: Row {
                        anchors.centerIn: parent
                        spacing: Config.moduleSpacing
                        Repeater {
                            model: 9
                            delegate: Item {
                                readonly property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                                readonly property bool isFocused: Hyprland.focusedWorkspace?.id === (index + 1)
                                implicitWidth: isFocused ? 28 : (wsMouse.containsMouse ? 16 : 10)
                                implicitHeight: 10
                                Behavior on implicitWidth { NumberAnimation { duration: 300; easing.type: Easing.OutBack } }
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 5
                                    color: parent.isFocused ? Config.accent : (parent.ws ? Config.alt : Config.empty)
                                    opacity: parent.isFocused ? 1 : (parent.ws ? 0.8 : 0.2)
                                }
                                MouseArea { // FIX : buttons do not work
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
                        spacing: Config.moduleSpacing
                        SvgImage { source: "icons/disk.svg" }
                        ModuleText { text: sys.diskUsage + "%" }
                    }
                    onClicked: Hyprland.dispatch("exec kitty btop")
                }

                BaseModule {
                    content: Row {
                        anchors.centerIn: parent
                        spacing: Config.moduleSpacing
                        SvgImage { source: "icons/cpu.svg" }
                        ModuleText { text: sys.cpuUsage + "%" }
                    }
                    onClicked: Hyprland.dispatch("exec kitty btop")
                }

                BaseModule {
                    content: Row {
                        anchors.centerIn: parent
                        spacing: Config.moduleSpacing
                        SvgImage { source: "icons/ram.svg" }
                        ModuleText { text: sys.memUsage + "%" }
                    }
                    onClicked: Hyprland.dispatch("exec kitty btop")
                }
            }

            // --- DROITE ---
            Row {
                id: rightModules
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: Config.spacing

                BaseModule {
                    implicitWidth: (btLabel.text.length * 8) + 50
                    content: Row {
                        anchors.centerIn: parent
                        spacing: Config.moduleSpacing
                        SvgImage {
                            source: "icons/bluetooth.svg"
                            opacity: sys.bluetoothOn ? 1 : 0.3
                        }
                        ModuleText {
                            id: btLabel
                            text: !sys.bluetoothOn ? "OFF" : (sys.bluetoothDevice || "ON")
                        }
                    }
                    onClicked: Hyprland.dispatch("exec blueman-manager")
                }

                BaseModule {
                    implicitWidth: (sys.wifiName.length * 8) + 40
                    content: Row {
                        anchors.centerIn: parent
                        spacing: Config.moduleSpacing
                        SvgImage {
                            source: sys.isWired ? "icons/ethernet.svg" : "icons/wifi.svg"
                            opacity: sys.wifiName !== "Déconnecté" ? 1 : 0.3
                        }
                        ModuleText { text: sys.wifiName }
                    }
                    onClicked: Hyprland.dispatch("exec kitty nmtui")
                }

                BaseModule {
                    content: Row {
                        anchors.centerIn: parent
                        spacing: Config.moduleSpacing
                        SvgImage {
                            source: sys.batteryStatus === "Charging" ? "icons/battery-charging.svg" : "icons/battery.svg"
                        }
                        ModuleText { text: sys.batteryLevel + "%" }
                    }
                    onClicked: Hyprland.dispatch("exec xfce4-power-manager-settings")
                }

                BaseModule {
                    id: timeIsland
                    property bool showDate: false
                    implicitWidth: showDate ? 125 : 85
                    content: Row {
                        anchors.centerIn: parent
                        spacing: Config.moduleSpacing
                        SvgImage { source: "icons/clock.svg" }
                        ModuleText { text: timeIsland.showDate ? sys.shortDate : sys.time }
                    }
                    onClicked: showDate = !showDate
                }
            }
        }
    }
}
