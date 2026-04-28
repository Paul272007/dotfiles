import QtQuick
import QtQuick.Layouts

Rectangle {
    id: island
    
    property bool expanded: false
    property var weatherData: ({}) // Reçu depuis shell.qml
    
    color: mouseArea.containsMouse || expanded ? Qt.rgba(40 / 255, 40 / 255, 40 / 255, 0.95) : Config.bg
    radius: expanded ? 16 : 20
    scale: mouseArea.pressed ? 0.96 : (mouseArea.containsMouse ? 1.02 : 1.0)
    
    implicitWidth: expanded ? 320 : Math.max(120, collapsedLayout.implicitWidth + 30)
    implicitHeight: expanded ? 140 : 28
    
    border.width: 1
    border.color: expanded ? Config.accent : (mouseArea.containsMouse ? Qt.rgba(1, 1, 1, 0.3) : Qt.rgba(1, 1, 1, 0.1))

    // Animations fluides
    Behavior on implicitWidth { NumberAnimation { duration: 400; easing.type: Easing.OutBack } }
    Behavior on implicitHeight { NumberAnimation { duration: 400; easing.type: Easing.OutBack } }
    Behavior on radius { NumberAnimation { duration: 300 } }
    Behavior on color { ColorAnimation { duration: 200 } }
    Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

    // État réduit
    RowLayout {
        id: collapsedLayout
        anchors.centerIn: parent
        visible: island.implicitHeight < 60
        opacity: visible ? 1 : 0
        spacing: 10
        
        Behavior on opacity { NumberAnimation { duration: 200 } }

        Image {
            source: "icons/weather.svg"
            sourceSize: Qt.size(16, 16)
            opacity: 0.9
        }

        Text {
            text: weatherData.main ? Math.round(weatherData.main.temp) + "°" : "--°"
            color: Config.text
            font { family: Config.fontFamily; pixelSize: 12; bold: true }
        }
        
        Rectangle { width: 1; height: 10; color: Qt.rgba(1,1,1,0.2) }

        Text {
            text: weatherData.weather ? weatherData.weather[0].description : "Météo..."
            color: Config.text
            font { family: Config.fontFamily; pixelSize: 11 }
            opacity: 0.7
        }
    }

    // État étendu
    ColumnLayout {
        id: expandedLayout
        anchors.fill: parent
        anchors.margins: 20
        visible: island.implicitHeight > 100
        opacity: visible ? 1 : 0
        spacing: 15

        Behavior on opacity { NumberAnimation { duration: 300 } }

        RowLayout {
            Layout.fillWidth: true
            ColumnLayout {
                spacing: 2
                Text {
                    text: weatherData.name || "Ma Position"
                    color: Config.accent
                    font { family: Config.fontFamily; pixelSize: 18; bold: true }
                }
                Text {
                    text: weatherData.weather ? weatherData.weather[0].description.toUpperCase() : ""
                    color: Config.text
                    font { family: Config.fontFamily; pixelSize: 10; letterSpacing: 1 }
                    opacity: 0.6
                }
            }
            Item { Layout.fillWidth: true }
            Text {
                text: weatherData.main ? Math.round(weatherData.main.temp) + "°" : ""
                color: Config.text
                font { family: Config.fontFamily; pixelSize: 36; bold: true }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Qt.rgba(1,1,1,0.1)
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 25
            
            ColumnLayout {
                Text { text: "RESSENTI"; color: Config.empty; font.pixelSize: 8; font.bold: true }
                Text { text: weatherData.main ? Math.round(weatherData.main.feels_like) + "°" : "--"; color: Config.text; font.pixelSize: 13; font.bold: true }
            }
            ColumnLayout {
                Text { text: "HUMIDITÉ"; color: Config.empty; font.pixelSize: 8; font.bold: true }
                Text { text: weatherData.main ? weatherData.main.humidity + "%" : "--"; color: Config.text; font.pixelSize: 13; font.bold: true }
            }
            ColumnLayout {
                Text { text: "VENT"; color: Config.empty; font.pixelSize: 8; font.bold: true }
                Text { text: weatherData.wind ? Math.round(weatherData.wind.speed * 3.6) + " km/h" : "--"; color: Config.text; font.pixelSize: 13; font.bold: true }
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: island.expanded = true
        onExited: island.expanded = false
        cursorShape: Qt.PointingHandCursor
    }
}
