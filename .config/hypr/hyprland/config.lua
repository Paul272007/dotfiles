local M = {}
local controller =
"dbus-send --session --type=method_call --dest=org.myshell.Controller /Controller org.myshell.Controller."

M.theme = "Default"
M.mainMod = "SUPER"
M.terminal = "kitty"
M.browser = "zen-browser"
M.music = "spotify"
M.notes = "obsidian"
M.fileManager = "nautilus"

M.themes = controller .. "toggleThemes"
M.menu = controller .. "toggleGlobal"
M.powermenu = controller .. "togglePower"
M.apps = controller .. "toggleApps"
M.keybinds = controller .. "toggleBinds"
M.clipboard = controller .. "toggleClip"
M.windows = controller .. "toggleWindows"

return M
