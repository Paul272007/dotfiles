pragma Singleton
import QtQuick
import Quickshell

QtObject {
  // Global
  readonly property int animDuration: 400
  readonly property color accent: "#89b4fa"
  readonly property color red: Qt.rgba(60 / 255, 20 / 255, 20 / 255, 0.7)
  readonly property color redBorder: "#ff5555"

  // Font
  readonly property string fontFamily: "Geist"
  readonly property string iconFont: "JetBrainsMono Nerd Font"
  readonly property int fontSize: 13
  readonly property color textColor: "#eeeeee"

  // TaskBar
  readonly property int barHeight: 35
  readonly property int barSidePadding: 15
  readonly property int barPadding: 3
  readonly property int barSpacing: 8

  // TaskBar Modules
  readonly property int moduleHeight: 28
  readonly property int moduleWidth: 70
  readonly property int moduleRadius: 20

  readonly property int modulePadding: 6
  readonly property int moduleBorderWidth: 0
  readonly property color moduleBg: Qt.rgba(20 / 255, 20 / 255, 20 / 255, 0.75)
  readonly property color moduleHoverBg: Qt.rgba(35 / 255, 35 / 255, 35 / 255, 0.8)
  readonly property color moduleBorderColor: "#7287fd"
  readonly property color moduleBorderHover: "#6277ed"

  // Dynamic Island
  readonly property int islandHeight: barHeight
  readonly property int islandWidth: 150
  readonly property int islandRadius: moduleRadius
  readonly property int islandPaddingX: 13
  readonly property int islandPaddingY: 4

  readonly property int islandExpandedHeight: 160
  readonly property int islandExpandedWidth: 360
  readonly property int islandExpandedRadius: 35
  readonly property int islandExpandedPaddingX: 20
  readonly property int islandExpandedPaddingY: 16

  // Notifications
  readonly property int notifMaxWidth: 550

  // Timers
  readonly property int notifTime: 5000
  readonly property int osdTime: 2000
  readonly property int workspaceTime: 1200

  // Wallpaper
  readonly property string wallpaperPath: Quickshell.env("HOME") + "/.cache/current_wallpaper.png"
}
