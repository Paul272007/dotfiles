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
    implicitHeight: 300
    color: "transparent"

    mask: Region {
        Region { item: leftModules }
        Region { item: weatherIsland } // Ce masque suit dynamiquement la taille de l'îlot (Météo/OSD/Média)
        Region { item: rightModules }
    }

    Item {
        id: barContainer
        width: parent.width; height: Config.barHeight
        anchors.top: parent.top; anchors.topMargin: Config.margin
        anchors.left: parent.left; anchors.right: parent.right
        anchors.leftMargin: Config.margin * 2; anchors.rightMargin: Config.margin * 2

        readonly property int commonTop: (Config.barHeight - Config.moduleHeight) / 2

        // --- GAUCHE ---
        Row {
            id: leftModules
            anchors.left: parent.left; anchors.top: parent.top; anchors.topMargin: parent.commonTop
            spacing: 12

            BaseModule {
                id: wsBase
                collapsedWidth: 190
                content: Row {
                    anchors.centerIn: parent; spacing: 8
                    Repeater {
                        model: 9
                        delegate: Item {
                            readonly property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                            readonly property bool isFocused: Hyprland.focusedWorkspace?.id === (index + 1)
                            implicitWidth: isFocused ? 28 : (wsMouse.containsMouse ? 16 : 10)
                            implicitHeight: 10
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on implicitWidth { NumberAnimation { duration: 300; easing.type: Easing.OutBack } }
                            Rectangle {
                                anchors.fill: parent; radius: 5
                                color: parent.isFocused ? Config.accent : (parent.ws ? Config.alt : Config.empty)
                                opacity: parent.isFocused ? 1 : (parent.ws ? 0.8 : 0.2)
                            }
                            MouseArea { id: wsMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: Hyprland.dispatch("workspace " + (index+1)) }
                        }
                    }
                }
            }

            BaseModule {
                collapsedWidth: 70
                content: Row {
                    anchors.centerIn: parent; spacing: 8
                    Image { source: "icons/disk.svg"; sourceSize: Qt.size(16, 16) }
                    Text { text: sys.diskUsage + "%"; color: Config.text; font.bold: true; font.pixelSize: Config.fontSize }
                }
            }

            Item {
                width: 75; height: Config.moduleHeight
                BaseModule {
                    id: cpuIsland; anchors.horizontalCenter: parent.horizontalCenter
                    collapsedWidth: 75
                    containsMouse: cpuMouse.containsMouse; isPressed: cpuMouse.pressed
                    content: Item {
                        anchors.fill: parent
                        Row {
                            anchors.centerIn: parent; spacing: 6
                            Image { source: "icons/cpu.svg"; sourceSize: Qt.size(16, 16) }
                            Text { text: sys.cpuUsage + "%"; color: Config.text; font.bold: true; font.pixelSize: Config.fontSize }
                        }
                    }
                    MouseArea { id: cpuMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: Hyprland.dispatch("exec kitty btop") }
                }
            }

            BaseModule {
                collapsedWidth: 75
                content: Row {
                    anchors.centerIn: parent; spacing: 8
                    Image { source: "icons/ram.svg"; sourceSize: Qt.size(16, 16) }
                    Text { text: sys.memUsage + "%"; color: Config.text; font.bold: true; font.pixelSize: Config.fontSize }
                }
            }
        }

        // --- CENTRE ---
        WeatherModule {
            id: weatherIsland
            width: implicitWidth; height: implicitHeight
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.commonTop - (hasMedia && !expanded ? 4 : 0)
            weatherData: sys.weatherData; z: 50
        }

        // --- DROITE ---
        Row {
            id: rightModules
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

            Item {
                width: 75; height: Config.moduleHeight
                BaseModule {
                    id: batIsland; anchors.horizontalCenter: parent.horizontalCenter
                    collapsedWidth: 75
                    containsMouse: batMouse.containsMouse; isPressed: batMouse.pressed
                    content: Item {
                        anchors.fill: parent
                        Row {
                            anchors.centerIn: parent; spacing: 6
                            Image { source: "icons/battery.svg"; sourceSize: Qt.size(16, 16) }
                            Text { text: sys.batteryLevel + "%"; color: Config.text; font.bold: true; font.pixelSize: Config.fontSize }
                        }
                    }
                    MouseArea { id: batMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor }
                }
            }

            Item {
                width: timeIsland.collapsedWidth; height: Config.moduleHeight
                BaseModule {
                    id: timeIsland; anchors.horizontalCenter: parent.horizontalCenter
                    property bool showDate: false
                    collapsedWidth: showDate ? 120 : 80
                    containsMouse: timeMouse.containsMouse; isPressed: timeMouse.pressed
                    content: Item {
                        anchors.fill: parent
                        Row {
                            anchors.centerIn: parent; spacing: 8
                            Image { source: "icons/clock.svg"; sourceSize: Qt.size(16, 16) }
                            Text { 
                                text: timeIsland.showDate ? sys.shortDate : sys.time
                                color: Config.text; font.bold: true; font.pixelSize: Config.fontSize 
                            }
                        }
                    }
                    MouseArea { 
                        id: timeMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                        onClicked: timeIsland.showDate = !timeIsland.showDate
                    }
                }
            }

            Item {
                width: 40; height: Config.moduleHeight
                BaseModule {
                    id: powerIsland; anchors.right: parent.right
                    collapsedWidth: 40
                    containsMouse: powerMouse.containsMouse; isPressed: powerMouse.pressed
                    content: Item {
                        anchors.fill: parent
                        Image {
                            anchors.centerIn: parent
                            source: "icons/power.svg"; sourceSize: Qt.size(14, 14)
                        }
                    }
                    MouseArea { 
                        id: powerMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                        onClicked: Hyprland.dispatch("exec wlogout")
                    }
                }
            }
        }
    }
}
