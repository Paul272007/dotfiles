import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    property var sysData: null

    WlrLayershell.layer: WlrLayer.Overlay

    anchors.bottom: true
    WlrLayershell.margins.bottom: 100

    property string osdType: ""
    property int osdValue: 0
    property bool osdMuted: false
    property bool showing: false

    readonly property bool isFullscreen: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.hasFullscreen : false

    visible: showing && isFullscreen

    width: 270
    height: 60

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: root.osdMuted ? Config.redBg : Config.bg
        radius: 30
        border.width: Config.borderWidth
        border.color: root.osdMuted ? Config.redBorder : Config.borderColor

        RowLayout {
            anchors.centerIn: parent
            anchors.leftMargin: Config.sideMargin
            spacing: 20
            width: parent.width - 50

            Text {
                text: root.osdType === "volume" ? (root.osdMuted ? "󰝟" : "󰕾") : (root.osdType === "mic" ? (root.osdMuted ? "󰍭" : "󰍬") : "󰃠")
                color: root.osdMuted ? Config.redBorder : Config.accent
                font.pixelSize: 18
            }

            Rectangle {
                Layout.fillWidth: true
                height: 6
                radius: 3
                color: Config.borderColor
                Rectangle {
                    width: parent.width * (root.osdValue / 100)
                    height: parent.height
                    radius: parent.radius
                    color: root.osdMuted ? Config.redBorder : Config.accent
                    Behavior on width {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }

            Text {
                text: root.osdMuted ? "OFF" : root.osdValue + "%"
                color: root.osdMuted ? Config.redBorder : Config.text
                font {
                    family: Config.fontFamily
                    pixelSize: 12
                    bold: true
                }
            }
        }
    }

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: root.showing = false
    }

    Connections {
        target: sysData
        function onOsdEvent(type, value, muted) {
            root.osdType = type;
            root.osdValue = value;
            root.osdMuted = muted;
            root.showing = true;
            hideTimer.restart();
        }
    }
}
