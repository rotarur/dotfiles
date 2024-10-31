local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "wezT" }

config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 18

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.colors = {
    background = "#282828",
    foreground = "#dfbf8e",
    cursor_bg = "#47ff9c",
    cursor_border = "#47ff9c",
    cursor_fg = "#011423",
    selection_bg = "#033259",
    selection_fg = "#cbe0f0",
    ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
    brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.window_background_opacity = 100
config.macos_window_background_blur = 10

-- disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- config.disable_default_key_bindings = true

local act = wezterm.action

config.keys = {
    {
        key = ',',
        mods = 'CMD',
        action = act.SpawnCommandInNewTab {
            cwd = os.getenv('WEZTERM_CONFIG_DIR'),
            set_environment_variables = {
                TERM = 'screen-256color',
            },
            args = {
                'vi',
                os.getenv('WEZTERM_CONFIG_FILE'),
            },
        },
    },
    -- other keys
    -- { key = 'LeftArrow', mods = 'OPT', action = act.SendString '\033b', },
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    { key = 'LeftArrow',  mods = 'OPT',  action = act.SendString '\x1bb' },
    -- Make Option-Right equivalent to Alt-f; forward-word
    { key = 'RightArrow', mods = 'OPT',  action = act.SendString '\x1bf' },
    -- Make CMD + a to move to the beginig of the line
    { key = 'LeftArrow',  mods = 'CMD',  action = act.SendKey { key = 'a', mods = 'CTRL' } },
    -- Make CMD + a to move to the beginig of the line
    { key = 'RightArrow', mods = 'CMD',  action = act.SendKey { key = 'e', mods = 'CTRL' } },
    { key = 'm',          mods = 'CTRL', action = act.DisableDefaultAssignment, },
    -- Turn off the default CMD-m Hide action, allowing CMD-m to
    -- be potentially recognized and handled by the tab
    { key = 'm',          mods = 'CMD',  action = act.DisableDefaultAssignment, },
    -- { key = 'RightArrow', mods = 'SHIFT', action = act.ActivatePaneDirection 'Right' },
    -- { key = 'UpArrow',    mods = 'SHIFT', action = act.ActivatePaneDirection 'Up' },
    -- { key = 'DownArrow',  mods = 'SHIFT', action = act.ActivatePaneDirection 'Down' },
}

return config
