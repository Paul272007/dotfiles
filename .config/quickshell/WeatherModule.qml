import QtQuick
import QtQuick.Layouts

Rectangle {
    id: island
    
    property bool expanded: false
    property var weatherData: ({})
    
    // Propriétés pour l'OSD (Volume/Luminosité/Micro)
    property string osdType: ""
    property int osdValue: 0
    property bool osdMuted: false
    property bool showingOSD: false
    
    readonly property bool hasMedia: sys.mediaStatus === "Playing"

    color: osdMuted && showingOSD ? Qt.rgba(60 / 255, 20 / 255, 20 / 255, 0.95) : (mouseArea.containsMouse || expanded ? Qt.rgba(40 / 255, 40 / 255, 40 / 255, 0.95) : Config.bg)
    radius: expanded ? 16 : 20
    scale: mouseArea.pressed ? 0.96 : (mouseArea.containsMouse ? 1.02 : 1.0)
    
    implicitWidth: expanded ? 320 : (showingOSD ? 160 : (hasMedia ? 260 : Math.max(120, collapsedLayout.implicitWidth + 30)))
    implicitHeight: expanded ? 140 : (hasMedia ? 36 : 28)
    
    // Ajout d'animations sur les valeurs de l'OSD pour la fluidité
    Behavior on osdValue { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
    
    border.width: 1
    border.color: osdMuted && showingOSD ? "#ff5555" : (expanded ? Config.accent : (mouseArea.containsMouse ? Qt.rgba(1, 1, 1, 0.3) : Qt.rgba(1, 1, 1, 0.1)))

    // Animations
    Behavior on implicitWidth { NumberAnimation { duration: island.showingOSD ? 200 : 300; easing.type: Easing.OutBack } }
    Behavior on implicitHeight { NumberAnimation { duration: 400; easing.type: Easing.OutBack } }
    Behavior on radius { NumberAnimation { duration: 300 } }
    Behavior on color { ColorAnimation { duration: 200 } }
    Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

    // --- MODE OSD (Volume / Brightness) ---
    RowLayout {
        anchors.centerIn: parent
        visible: island.showingOSD && !island.expanded
        opacity: visible ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 150 } }
        spacing: 12
        width: parent.width - 30

        Text {
            text: island.osdType === "volume" ? (island.osdMuted ? "󰝟" : "󰕾") : (island.osdType === "mic" ? (island.osdMuted ? "󰍭" : "󰍬") : "󰃠")
            color: island.osdMuted ? "#ff5555" : Config.accent
            font.pixelSize: 16
        }

        Rectangle {
            Layout.fillWidth: true
            height: 4
            radius: 2
            color: Qt.rgba(1, 1, 1, 0.1)
            Rectangle {
                width: parent.width * (island.osdValue / 100)
                height: parent.height
                radius: parent.radius
                color: island.osdMuted ? "#ff5555" : Config.accent
            }
        }

        Text {
            text: island.osdMuted ? "OFF" : island.osdValue + "%"
            color: island.osdMuted ? "#ff5555" : Config.text
            font { family: Config.fontFamily; pixelSize: 11; bold: true }
        }
    }

    // --- MODE MULTIMÉDIA ---
    RowLayout {
        anchors.centerIn: parent
        visible: island.hasMedia && !island.showingOSD && !island.expanded
        opacity: visible ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
        spacing: 10
        width: parent.width - 20

        Text {
            text: "󰎆"
            color: Config.accent
            font.pixelSize: 14
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 0
            Text {
                text: sys.mediaTitle || "Inconnu"
                color: Config.text
                font { family: Config.fontFamily; pixelSize: 11; bold: true }
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
            Text {
                text: sys.mediaArtist || "Artiste inconnu"
                color: Config.text
                opacity: 0.6
                font { family: Config.fontFamily; pixelSize: 10 }
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }
    }

    // --- MODE RÉDUIT (Météo) ---
    RowLayout {
        id: collapsedLayout
        anchors.centerIn: parent
        visible: island.implicitHeight < 50 && !island.showingOSD && !island.hasMedia
        opacity: visible ? 1 : 0
        spacing: 10
        Behavior on opacity { NumberAnimation { duration: 200 } }

        Image { source: "icons/weather.svg"; sourceSize: Qt.size(16, 16); opacity: 0.9 }
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

    // --- MODE ÉTENDU ---
    ColumnLayout {
        id: expandedLayout
        anchors.fill: parent; anchors.margins: 20
        visible: island.implicitHeight > 100
        opacity: visible ? 1 : 0
        spacing: 15
        Behavior on opacity { NumberAnimation { duration: 300 } }

        RowLayout {
            Layout.fillWidth: true
            ColumnLayout {
                spacing: 2
                Text { text: weatherData.name || "Ma Position"; color: Config.accent; font { family: Config.fontFamily; pixelSize: 18; bold: true } }
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

        Rectangle { Layout.fillWidth: true; height: 1; color: Qt.rgba(1,1,1,0.1) }

        RowLayout {
            Layout.fillWidth: true; spacing: 25
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

    // Timer pour fermer l'OSD
    Timer {
        id: osdTimer
        interval: 2000
        onTriggered: island.showingOSD = false
    }

    // Connexion au signal de SystemData
    Connections {
        target: sys
        function onOsdEvent(type, value, muted) {
            island.osdType = type;
            island.osdValue = value;
            island.osdMuted = muted;
            island.showingOSD = true;
            osdTimer.restart();
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
