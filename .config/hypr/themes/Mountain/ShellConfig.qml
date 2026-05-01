pragma Singleton
import QtQuick

QtObject {
    // Couleurs
    readonly property color bg: Qt.rgba(20 / 255, 20 / 255, 20 / 255, 0.75)
    readonly property color hover: Qt.rgba(35 / 255, 35 / 255, 35 / 255, 0.8)
    readonly property color redBg: Qt.rgba(60 / 255, 20 / 255, 20 / 255, 0.7)
    readonly property color text: "#eeeeee"
    readonly property color empty: "#313244"
    readonly property color alt: "#E86C53"
    readonly property color accent: "#F87C63"
    readonly property color redBorder: "#ff5555"
    readonly property color borderColor: Qt.rgba(1, 1, 1, 0.1)
    readonly property color borderHover: Qt.rgba(1, 1, 1, 0.3)

    // Typographie
    readonly property string fontFamily: "Geist Mono Nerd Font"
    readonly property int fontSize: 12
    readonly property int fontSizeSmall: 10

    // Dimensions
    readonly property int borderWidth: 1

    readonly property int margin: 3
    readonly property int sideMargin: 15
    readonly property int moduleSpacing: 8
    readonly property int spacing: 10

    readonly property int barHeight: 35
    readonly property int moduleHeight: 28
    readonly property int moduleWidth: 75
    readonly property int expandedModuleHeight: 160
    readonly property int expandedModuleWidth: 360

    readonly property int moduleRadius: 20
    readonly property int expandedModuleRadius: 35

    // Animations
    readonly property int animDuration: 400
}
