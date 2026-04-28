// pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    exclusiveZone: Config.barHeight + Config.margin
    SystemData { id: sys }
    anchors { top: true; left: true; right: true }
    margins { top: Config.margin; left: Config.margin * 2; right: Config.margin * 2 }
    implicitHeight: 350
    color: "transparent"

    Item {
        width: parent.width; height: Config.barHeight
        anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
        readonly property int commonTop: (Config.barHeight - Config.moduleHeight) / 2

        // --- GAUCHE ---
        Row {
            anchors.left: parent.left; anchors.top: parent.top; anchors.topMargin: parent.commonTop
            spacing: 12

            BaseModule {
                collapsedWidth: 200 // Fixe pour les workspaces
                content: Row {
                    anchors.centerIn: parent; spacing: 8
                    Repeater {
                        model: 9
                        delegate: Item {
                            readonly property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                            readonly property bool isFocused: Hyprland.focusedWorkspace?.id === (index + 1)
                            implicitWidth: isFocused ? 28 : 10; implicitHeight: 10
                            anchors.verticalCenter: parent.verticalCenter
                            Rectangle {
                                anchors.fill: parent; radius: 5
                                color: parent.isFocused ? Config.accent : (parent.ws ? Config.alt : Config.empty)
                                opacity: parent.isFocused ? 1 : (parent.ws ? 0.8 : 0.2)
                            }
                            MouseArea { anchors.fill: parent; onClicked: Hyprland.dispatch("workspace " + (index+1)) }
                        }
                    }
                }
            }

            BaseModule {
                collapsedWidth: 70
                content: Row {
                    anchors.centerIn: parent; spacing: 8
                    Image { source: "icons/disk.svg"; sourceSize: Qt.size(16, 16) }
                    Text { text: sys.diskUsage + "%"; color: Config.text; font.bold: true; font.pixelSize: Config.fontSize; font.family: Config.fontFamily }
                }
            }

            // CPU (Expansion au centre, sans pousser les autres)
            Item {
                width: 75; height: Config.moduleHeight; z: cpuIsland.expanded ? 100 : 1
                BaseModule {
                    id: cpuIsland
                    anchors.horizontalCenter: parent.horizontalCenter
                    collapsedWidth: 75; expandedWidth: 150; expandedHeight: 90
                    
                    content: Item {
                        anchors.fill: parent
                        // Réduit
                        Row {
                            anchors.centerIn: parent; spacing: 6; opacity: cpuIsland.expanded ? 0 : 1
                            Behavior on opacity { NumberAnimation { duration: 200 } }
                            Image { source: "icons/cpu.svg"; sourceSize: Qt.size(16, 16) }
                            Text { text: sys.cpuUsage + "%"; color: Config.text; font.bold: true; font.pixelSize: Config.fontSize }
                        }
                        // Étendu
                        ColumnLayout {
                            anchors.fill: parent; anchors.margins: 10; visible: cpuIsland.expanded; opacity: visible ? 1 : 0
                            spacing: 8
                            Text { text: "COEURS"; color: Config.accent; font.pixelSize: 9; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                            Row {
                                spacing: 3; Layout.alignment: Qt.AlignHCenter
                                Repeater {
                                    model: sys.cpuCores
                                    Rectangle {
                                        implicitWidth: 5; implicitHeight: 25; color: Config.empty; radius: 2
                                        Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: Math.max(2, (modelData / 100) * parent.height); color: modelData > 80 ? "#ff5555" : Config.accent; radius: 2 }
                                    }
                                }
                            }
                        }
                    }
                    MouseArea { anchors.fill: parent; hoverEnabled: true; onEntered: cpuIsland.expanded = true; onExited: cpuIsland.expanded = false; onClicked: Hyprland.dispatch("exec kitty btop") }
                }
            }

            BaseModule {
                collapsedWidth: 75
                content: Row {
                    anchors.centerIn: parent; spacing: 8
                    Image { source: "icons/ram.svg"; sourceSize: Qt.size(16, 16) }
                    Text { text: sys.memUsage + "%"; color: Config.text; font.bold: true; font.pixelSize: Config.fontSize; font.family: Config.fontFamily }
                }
            }
        }

        // --- CENTRE ---
        WeatherModule {
            id: weatherIsland
            anchors.horizontalCenter: parent.horizontalCenter; anchors.top: parent.top; anchors.topMargin: parent.commonTop
            weatherData: sys.weatherData; z: 50
        }

        // --- DROITE ---
        Row {
            anchors.right: parent.right; anchors.top: parent.top; anchors.topMargin: parent.commonTop; anchors.rightMargin: 10
            spacing: 12

            BaseModule {
                collapsedWidth: 70
                content: Row {
                    anchors.centerIn: parent; spacing: 10
                    Image { source: "icons/wifi.svg"; sourceSize: Qt.size(16, 16); opacity: sys.wifiName !== "Déconnecté" ? 1 : 0.3 }
                    Image { source: "icons/bluetooth.svg"; sourceSize: Qt.size(16, 16); opacity: sys.bluetoothOn ? 1 : 0.3 }
                }
                onClicked: Hyprland.dispatch("exec kitty nmtui")
            }

            // Horloge (Expansion à gauche, sans pousser)
            Item {
                width: 80; height: Config.moduleHeight; z: timeIsland.expanded ? 100 : 1
                BaseModule {
                    id: timeIsland
                    anchors.right: parent.right
                    collapsedWidth: 80; expandedWidth: 160; expandedHeight: 180
                    
                    content: Item {
                        anchors.fill: parent
                        // Réduit
                        Row {
                            anchors.centerIn: parent; spacing: 8; opacity: timeIsland.expanded ? 0 : 1
                            Behavior on opacity { NumberAnimation { duration: 200 } }
                            Image { source: "icons/clock.svg"; sourceSize: Qt.size(16, 16) }
                            Text { text: sys.time; color: Config.text; font.bold: true; font.pixelSize: Config.fontSize }
                        }
                        // Étendu
                        ColumnLayout {
                            anchors.fill: parent; anchors.margins: 10; visible: timeIsland.expanded; opacity: visible ? 1 : 0
                            spacing: 12
                            Text { text: sys.time; color: Config.accent; font.pixelSize: 18; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                            Grid {
                                columns: 7; rowSpacing: 2; columnSpacing: 4; Layout.alignment: Qt.AlignHCenter
                                Repeater {
                                    model: 31
                                    Text { text: index + 1; color: (index + 1) === new Date().getDate() ? Config.accent : Config.text; font.pixelSize: 10; font.bold: (index + 1) === new Date().getDate(); opacity: (index + 1) === new Date().getDate() ? 1 : 0.6 }
                                }
                            }
                        }
                    }
                    MouseArea { anchors.fill: parent; hoverEnabled: true; onEntered: timeIsland.expanded = true; onExited: timeIsland.expanded = false }
                }
            }
        }
    }
}
