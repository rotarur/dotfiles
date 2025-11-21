local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 18

config.color_scheme = "s3r0 modified (terminal.sexy)"

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.enable_csi_u_key_encoding = true

-- config.colors = {
-- 	background = "#282828",
-- 	foreground = "#dfbf8e",
-- 	cursor_bg = "#47ff9c",
-- 	cursor_border = "#47ff9c",
-- 	cursor_fg = "#011423",
-- 	selection_bg = "#033259",
-- 	selection_fg = "#cbe0f0",
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

config.window_background_opacity = 100
config.macos_window_background_blur = 10

-- disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- config.disable_default_key_bindings = true

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 200000000

local act = wezterm.action

config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Middle" } },
		mods = "NONE",
		action = act({ PasteFrom = "Clipboard" }),
	},
	{
		event = { Down = { streak = 2, button = "Right" } },
		mods = "NONE",
		action = act({ CopyTo = "Clipboard" }),
	},
}

-- config.mouse_bindings = {
-- 	-- Double-click to select and copy
-- 	{
-- 		event = { Down = { streak = 2, button = "Left" } },
-- 		mods = "NONE",
-- 		action = wezterm.action.SelectTextAtMouseCursor("Word"),
-- 	},
-- }

config.keys = {
	{
		key = ",",
		mods = "CMD",
		action = act.SpawnCommandInNewTab({
			cwd = os.getenv("WEZTERM_CONFIG_DIR"),
			set_environment_variables = {
				TERM = "screen-256color",
			},
			args = {
				"vi",
				os.getenv("WEZTERM_CONFIG_FILE"),
			},
		}),
	},
	-- other keys
	-- { key = 'LeftArrow', mods = 'OPT', action = act.SendString '\033b', },
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = act.SendString("\x1bb") },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = act.SendString("\x1bf") },
	-- Make CMD + a to move to the beginig of the line
	{ key = "LeftArrow", mods = "CMD", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	-- Make CMD + a to move to the beginig of the line
	{ key = "RightArrow", mods = "CMD", action = act.SendKey({ key = "e", mods = "CTRL" }) },
	{ key = "m", mods = "CTRL", action = act.DisableDefaultAssignment },
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{ key = "m", mods = "CMD", action = act.DisableDefaultAssignment },
	-- {
	-- 	key = "-",
	-- 	mods = "CTRL|CMD",
	-- 	action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	key = "/",
	-- 	mods = "CTRL|CMD",
	-- 	action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	key = "h",
	-- 	mods = "CTRL",
	-- 	action = act.ActivatePaneDirection("Left"),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "CTRL",
	-- 	action = act.ActivatePaneDirection("Right"),
	-- },
	-- {
	-- 	key = "k",
	-- 	mods = "CTRL",
	-- 	action = act.ActivatePaneDirection("Up"),
	-- },
	-- {
	-- 	key = "j",
	-- 	mods = "CTRL",
	-- 	action = act.ActivatePaneDirection("Down"),
	-- },
}

config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act({ CopyTo = "Clipboard" }),
	},
}
-- { key = 'UpArrow',    mods = 'SHIFT', action = act.ActivatePaneDirection 'Up' },
-- { key = 'DownArrow',  mods = 'SHIFT', action = act.ActivatePaneDirection 'Down' },

-- -- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
--
-- -- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
--
-- config.tab_bar_style = {
-- 	active_tab_left = wezterm.format({
-- 		{ Background = { Color = "#0b0022" } },
-- 		{ Foreground = { Color = "#2b2042" } },
-- 		{ Text = SOLID_LEFT_ARROW },
-- 	}),
-- 	active_tab_right = wezterm.format({
-- 		{ Background = { Color = "#0b0022" } },
-- 		{ Foreground = { Color = "#2b2042" } },
-- 		{ Text = SOLID_RIGHT_ARROW },
-- 	}),
-- 	inactive_tab_left = wezterm.format({
-- 		{ Background = { Color = "#0b0022" } },
-- 		{ Foreground = { Color = "#1b1032" } },
-- 		{ Text = SOLID_LEFT_ARROW },
-- 	}),
-- 	inactive_tab_right = wezterm.format({
-- 		{ Background = { Color = "#0b0022" } },
-- 		{ Foreground = { Color = "#1b1032" } },
-- 		{ Text = SOLID_RIGHT_ARROW },
-- 	}),
-- }

return config
