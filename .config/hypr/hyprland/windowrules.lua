hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "center",
	match = { class = "^(nm-connection-editor|blueman-manager|jetbrains-toolbox|org.nmrs.ui)$" },
	float = true,
	center = true,
})

hl.layer_rule({
	name = "blur",
	match = { namespace = "^(swaync-notification-window|swaync-control-center|rofi|quickshell)$" },
	blur = true,
	ignore_alpha = 0.5,
})
