pragma Singleton
import QtQuick

QtObject {
    // Couleurs
    readonly property color bg: Qt.rgba(25 / 255, 25 / 255, 25 / 255, 0.95)
    readonly property color text: "#eeeeee"
    readonly property color empty: "#547254"
    readonly property color alt: "#3b9b47"
    readonly property color accent: "#2aa63e"

    // Typographie (Basée sur le Dynamic Island)
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 12
    readonly property int fontSizeSmall: 10

    // Dimensions
    readonly property int barHeight: 40
    readonly property int moduleHeight: 28
    readonly property int margin: 6
    readonly property int spacing: 10
    readonly property int sidePadding: 12
    readonly property int moduleRadius: 20
    
    // Animations (Fluides et organiques)
    readonly property int animDuration: 400
}
