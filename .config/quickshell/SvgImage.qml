import QtQuick
import QtQuick.Effects

Image {
    sourceSize: Qt.size(16, 16)

    layer.enabled: true
    layer.effect: MultiEffect {
        colorization: 1.0
        colorizationColor: Config.accent
        // brightness: 0.5
    }
}
