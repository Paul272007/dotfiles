pragma Singleton
import QtQuick

QtObject {
  // Global
  readonly property int animDuration: 350
  readonly property color accent: "#F87C63"
  readonly property color red: Qt.rgba(255 / 255, 69 / 255, 58 / 255, 0.7)
  readonly property color redBorder: "#ff453a"

  // Font
  readonly property string fontFamily: "Geist"
  readonly property string iconFont: "GeistMono Nerd Font"
  readonly property int fontSize: 12
  readonly property color textColor: "#F5F5F7"
  readonly property color textSecondary: Qt.rgba(1, 1, 1, 0.55)
  readonly property color iconColor: Qt.rgba(1, 1, 1, 0.85)
  readonly property color iconColorMuted: Qt.rgba(1, 1, 1, 0.45)

  // TaskBar
  readonly property int barHeight: 34
  readonly property int barSidePadding: 12
  readonly property int barPadding: 6
  readonly property int barSpacing: 8

  // TaskBar Modules
  readonly property int moduleHeight: 28
  readonly property int moduleWidth: 80
  readonly property int moduleRadius: 16

  readonly property int modulePadding: 8
  readonly property int moduleBorderWidth: 1
  readonly property color moduleBg: Qt.rgba(0.12, 0.12, 0.14, 0.72)
  readonly property color moduleHoverBg: Qt.rgba(0.22, 0.22, 0.26, 0.80)
  readonly property color moduleBorderColor: Qt.rgba(1, 1, 1, 0.10)
  readonly property color moduleBorderHover: Qt.rgba(1, 1, 1, 0.25)

  // Dynamic Island
  readonly property int islandHeight: barHeight
  readonly property int islandWidth: 150
  readonly property int islandRadius: 18
  readonly property color islandBg: Qt.rgba(0.04, 0.04, 0.05, 0.95)
  readonly property color islandBorderColor: Qt.rgba(1, 1, 1, 0.12)
  readonly property int islandBorderWidth: 1
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
  readonly property string wallpaperPath: "/home/paul/.config/hypr/themes/Mountain/wall.jpg"
}
