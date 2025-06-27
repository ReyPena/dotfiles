local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Debug (auto reload)
config.automatically_reload_config = true

config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = false

config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"

return config
