local config = require("hyprland.config")
local mainMod = config.mainMod

-- System
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { desc = "Lock screen" })
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"), { desc = "Color picker" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"), { desc = "Show notifications center" })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("killall quickshell; quickshell"), { desc = "Reload quickshell" })
hl.bind(mainMod .. " + Delete", hl.dsp.exit(), { desc = "Exit hyprland and close session" })

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(config.clipboard), { desc = "Clipboard manager" })
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(config.keybinds), { desc = "Show keybindings" })
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(config.apps), { desc = "Apps launcher" })
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(config.powermenu), { desc = "Power menu" })
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(config.menu), { desc = "Global search menu" })
hl.bind(mainMod .. " + asterisk", hl.dsp.exec_cmd(config.windows), { desc = "Windows" })

-- Themes
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(config.themes), { desc = "Theme switcher" })

-- Apps
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(config.notes), { desc = "Open notes app" })
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(config.music), { desc = "Open music app" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(config.browser), { desc = "Open web browser" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(config.fileManager), { desc = "Open file manager" })
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(config.terminal), { desc = "Open terminal" })

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(config.bluetooth), { desc = "Open bluetooth manager" })

-- Windows
hl.bind(mainMod .. " + Q", hl.dsp.window.float({ action = "toggle" }), { desc = "Toggle float" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(), { desc = "Fullscreen mode" })
hl.bind(mainMod .. " + W", hl.dsp.window.close(), { desc = "Close window" })
hl.bind(mainMod .. " + K", hl.dsp.window.kill(), { desc = "Kill window" })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { desc = "Toggle pseudo tiling" })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { desc = "Toggle split mode" })

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, desc = "Drag window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, desc = "Resize window" })

-- Focus
hl.bind("ALT + tab", hl.dsp.focus({ direction = "right" }), { desc = "Move window focus" })
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }), { desc = "Move focus to the left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { desc = "Move focus to the right" })
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }), { desc = "Move focus upwards" })
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }), { desc = "Move focus downwards" })

-- TODO : add description flags

-- Workspaces
local workspaces = {
	["ampersand"] = 1,
	["eacute"] = 2,
	["quotedbl"] = 3,
	["apostrophe"] = 4,
	["code:14"] = 5,
	["minus"] = 6,
	["egrave"] = 7,
	["underscore"] = 8,
	["ccedilla"] = 9,
	["agrave"] = 10,
}

for key, ws in pairs(workspaces) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = ws }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

-- Scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "e-1" }))

-- Multimedia
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshots
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		'grim -g "$(slurp)" "$HOME/Pictures/Screenshots/Screenshot-$(date +%F_%T).png" && wl-copy < "$HOME/Pictures/Screenshots/Screenshot-$(date +%F_%T).png" && notify-send "Capture d\'écran" "Région enregistrée et copiée !" -a Hyprland'
	)
)
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd(
		'grim "$HOME/Pictures/Screenshots/Screenshot-$(date +%F_%T).png" && wl-copy < "$HOME/Pictures/Screenshots/Screenshot-$(date +%F_%T).png" && notify-send "Capture d\'écran" "Ecran enregistré et copié !" -a Hyprland'
	)
)
