local wezterm = require("wezterm")

local function isViProcess(pane)
	local proc = pane:get_foreground_process_name()
	if proc then
		return proc:find("n?vim") ~= nil
	end
	return false
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(wezterm.action.SendKey({ key = vim_direction, mods = "CTRL" }), pane)
	else
		window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditionalActivatePane(window, pane, "Down", "j")
end)

return {
	default_prog = { "/opt/homebrew/bin/fish" },
	enable_scroll_bar = true,
	check_for_updates = false,
	hide_tab_bar_if_only_one_tab = true,
	initial_rows = 51,
	initial_cols = 186,
	color_scheme = "kanagawabones",
	font = wezterm.font({
		family = "SauceCodePro Nerd Font",
		weight = "Regular",
		harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "calt", "dlig" },
	}),
	font_size = 18.5,
	font_rules = {
		--
		-- Italic (comments)
		--
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "Monaspace Radon",
				weight = "ExtraLight",
				stretch = "Normal",
				style = "Normal",
				harfbuzz_features = {
					"calt",
					"liga",
					"dlig",
					"ss01",
					"ss02",
					"ss03",
					"ss04",
					"ss05",
					"ss06",
					"ss07",
					"ss08",
				},
			}),
		},
	},
	exit_behavior = "Close",
	leader = { key = "a", mods = "CTRL" },
	set_environment_variables = {
		TERM = "wezterm",
	},
	keys = {
		{ key = "Enter", mods = "SHIFT", action = wezterm.action { SendString = "\x1b\r" } },
		{ key = "r",     mods = "SUPER", action = "ReloadConfiguration" },
		-- Pane Creation
		{
			key = "\\",
			mods = "SUPER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "'", mods = "SUPER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{
			key = "|",
			mods = "LEADER|SHIFT",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = '"',
			mods = "LEADER|SHIFT",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "x", mods = "SUPER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
		-- Pane Navigation
		{ key = "z", mods = "SUPER", action = "TogglePaneZoomState" },
		-- { key = "h", mods = "SUPER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		-- { key = "j", mods = "SUPER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		-- { key = "k", mods = "SUPER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		-- { key = "l", mods = "SUPER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		-- { key = "h", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		-- { key = "j", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		-- { key = "k", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		-- { key = "l", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		{ key = "h", mods = "CTRL",  action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
		{ key = "j", mods = "CTRL",  action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
		{ key = "k", mods = "CTRL",  action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
		{ key = "l", mods = "CTRL",  action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },
		{ key = "h", mods = "SUPER", action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
		{ key = "j", mods = "SUPER", action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
		{ key = "k", mods = "SUPER", action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
		{ key = "l", mods = "SUPER", action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },
		-- Pane Sizing
		{ key = "h", mods = "META",  action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
		{ key = "j", mods = "META",  action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },
		{ key = "k", mods = "META",  action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
		{ key = "l", mods = "META",  action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
		-- Tab Navigation
		{ key = "1", mods = "SUPER", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "SUPER", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "SUPER", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "SUPER", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "SUPER", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "SUPER", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "SUPER", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "SUPER", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "SUPER", action = wezterm.action({ ActivateTab = 8 }) },
		{
			key = "P",
			mods = "SUPER",
			action = wezterm.action.PaneSelect({
				mode = "SwapWithActive",
			}),
		},
		{ key = "F11", action = wezterm.action.ToggleFullScreen },
		{ key = "e",   mods = "SUPER",                          action = wezterm.action.SendKey({ key = "e", mods = "CTRL" }) },

		{ key = "o",   mods = "SUPER",                          action = wezterm.action.ShowLauncher },
	},
	window_decorations = "RESIZE",
	window_background_opacity = 0.7,
	text_background_opacity = 0.7,
	hyperlink_rules = {
		{
			regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},
		{
			regex = "\\bMA-(\\d+)\\b",
			format = "https://known.atlassian.net/browse/MA-$1",
		},
	},
	inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.3,
	},
	macos_window_background_blur = 10,

	ssh_domains = {
		{
			name = "docker",
			remote_address = "192.168.86.8",
			username = "dan",
		},
		{
			name = "dev",
			remote_address = "192.168.86.9",
			username = "dan",
		},
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	max_fps = 120,
}
