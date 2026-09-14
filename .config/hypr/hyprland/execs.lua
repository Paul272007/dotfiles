-- local config = require("hyprland.config")

hl.on("hyprland.start", function()
	-- hl.exec_cmd("~/.config/hypr/scripts/themeswitch.sh " .. config.theme)
	hl.exec_cmd("~/shell/run.sh")
	-- hl.exec_cmd("hypridle") -- TODO : replace with quickshell
	hl.exec_cmd("hyprshade auto") -- TODO : replace with quickshell
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("hyprctl setcursor macOS 26") -- TODO : s'occuper de ça dans le theme switcher
	hl.exec_cmd("tmux new-session -d -s main")
end)

-- TODO : mettre ce qui reste dans le theme switcher
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'")
