pragma Singleton
import QtQuick

QtObject {
  // Global
  readonly property int animDuration: 400
  readonly property color accent: "#8faa74"
  readonly property color red: Qt.rgba(60 / 255, 20 / 255, 20 / 255, 0.7)
  readonly property color redBorder: "#ff5555"

  // Font
  readonly property string fontFamily: "Geist"
  readonly property string iconFont: "JetBrainsMono Nerd Font"
  readonly property int fontSize: 13
  readonly property color textColor: "#eeeeee"

  // TaskBar
  readonly property int barHeight: 35
  readonly property int barSidePadding: 10
  readonly property int barPadding: 7
  readonly property int barSpacing: 8

  // TaskBar Modules
  readonly property int moduleHeight: 28
  readonly property int moduleWidth: 80
  readonly property int moduleRadius: 20

  readonly property int modulePadding: 8
  readonly property int moduleBorderWidth: 0
  readonly property color moduleBg: Qt.rgba(20 / 255, 20 / 255, 20 / 255, 0.6)
  readonly property color moduleHoverBg: Qt.rgba(35 / 255, 35 / 255, 35 / 255, 0.7)
  readonly property color moduleBorderColor: Qt.rgba(1, 1, 1, 0.1)
  readonly property color moduleBorderHover: Qt.rgba(1, 1, 1, 0.3)

  // Dynamic Island
  readonly property int islandHeight: barHeight
  readonly property int islandWidth: 150
  readonly property int islandRadius: moduleRadius
  readonly property int islandPaddingX: 13
  readonly property int islandPaddingY: 4

  readonly property int islandExpandedHeight: 120
  readonly property int islandExpandedWidth: 300
  readonly property int islandExpandedRadius: 37
  readonly property int islandExpandedPaddingX: 20
  readonly property int islandExpandedPaddingY: 16

  // Notifications
  readonly property int notifMaxWidth: 550

  // Timers
  readonly property int notifTime: 5000
  readonly property int osdTime: 2000
  readonly property int workspaceTime: 1200

  // Wallpaper
  readonly property string wallpaperPath: "/home/paul/.config/hypr/themes/Forest/wall.png"
}
