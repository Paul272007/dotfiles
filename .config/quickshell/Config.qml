pragma Singleton
import QtQuick

QtObject {
    // Couleurs
    readonly property color bg: Qt.rgba(25 / 255, 25 / 255, 25 / 255, 0.75)
    readonly property color hover: Qt.rgba(35 / 255, 35 / 255, 35 / 255, 0.8)
    readonly property color text: "#eeeeee"
    readonly property color empty: "#547254"
    readonly property color alt: "#3b8b47"
    readonly property color accent: "#2a963e"

    // Typographie (Basée sur le Dynamic Island)
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 12
    readonly property int fontSizeSmall: 10

    // Dimensions
    readonly property int barHeight: 35
    readonly property int moduleHeight: 28
    readonly property int margin: 3
    readonly property int moduleRadius: 20

    // Animations (Fluides et organiques)
    readonly property int animDuration: 400
}
