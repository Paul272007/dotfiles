import QtQuick
import QtQuick.Layouts

Rectangle {
    id: moduleRoot

    property alias content: contentContainer.data
    property bool expanded: false
    
    property int collapsedWidth: 100
    property int expandedWidth: 200
    property int collapsedHeight: Config.moduleHeight
    property int expandedHeight: 150

    property bool containsMouse: mouseArea.containsMouse
    property bool isPressed: mouseArea.pressed

    signal clicked

    color: (containsMouse || expanded) ? Qt.rgba(45 / 255, 45 / 255, 45 / 255, 1.0) : Config.bg
    radius: expanded ? 16 : Config.moduleRadius
    scale: isPressed ? 0.96 : (containsMouse ? 1.05 : 1.0)
    z: (containsMouse || expanded) ? 100 : 1

    implicitWidth: expanded ? expandedWidth : collapsedWidth
    implicitHeight: expanded ? expandedHeight : Config.moduleHeight

    border.width: 1
    border.color: expanded ? Config.accent : (containsMouse ? Qt.rgba(1, 1, 1, 0.3) : Qt.rgba(1, 1, 1, 0.1))

    Behavior on implicitWidth { NumberAnimation { duration: Config.animDuration; easing.type: Easing.OutBack } }
    Behavior on implicitHeight { NumberAnimation { duration: Config.animDuration; easing.type: Easing.OutBack } }
    Behavior on radius { NumberAnimation { duration: 300 } }
    Behavior on color { ColorAnimation { duration: 200 } }
    Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

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
