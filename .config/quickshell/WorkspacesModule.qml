import QtQuick
import Quickshell.Hyprland

BaseModule {
    id: wsModule
    spacing: 2

    content: Repeater {
        model: 9

        delegate: Item {
            // Recherche du workspace de manière sécurisée
            readonly property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            readonly property bool isFocused: Hyprland.focusedWorkspace?.id === (index + 1)
            readonly property int nb: index + 1
            implicitWidth: 22
            implicitHeight: 22

            Text {
                anchors.centerIn: parent
                text: parent.nb
                color: parent.isFocused ? Config.accent : (parent.ws ? Config.alt : Config.empty)
                font {
                    family: Config.fontFamily
                    pixelSize: Config.fontSize
                    bold: true
                }
            }

            Rectangle {
                anchors.fill: parent
                radius: Config.radius
                color: parent.isFocused ? Qt.rgba(23 / 255, 130 / 255, 54 / 255, 0.15) : "transparent"
                border.width: parent.isFocused ? 1 : 0
                border.color: Config.accent
                z: -1
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + parent.nb)
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}
