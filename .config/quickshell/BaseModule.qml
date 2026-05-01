import QtQuick
import QtQuick.Layouts

Rectangle {
    id: moduleRoot

    property alias content: contentContainer.data

    property bool containsMouse: mouseArea.containsMouse
    property bool isPressed: mouseArea.pressed

    signal clicked

    color: containsMouse ? Config.hover : Config.bg
    radius: Config.moduleRadius
    scale: isPressed ? 0.96 : (containsMouse ? 1.05 : 1.0)
    z: 1

    implicitWidth: Config.moduleWidth
    implicitHeight: Config.moduleHeight

    border.width: Config.borderWidth
    border.color: containsMouse ? Config.borderHover : Config.borderColor

    Behavior on implicitWidth {
        NumberAnimation {
            duration: Config.animDuration
            easing.type: Easing.OutBack
        }
    }
    Behavior on implicitHeight {
        NumberAnimation {
            duration: Config.animDuration
            easing.type: Easing.OutBack
        }
    }
    Behavior on radius {
        NumberAnimation {
            duration: 300
        }
    }
    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
    Behavior on scale {
        NumberAnimation {
            duration: 150
            easing.type: Easing.OutCubic
        }
    }

    Item {
        id: contentContainer
        anchors.fill: parent
        clip: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: moduleRoot.clicked()
        cursorShape: Qt.PointingHandCursor
    }
}
