local wezterm = require('wezterm')
local defaults = require('defaults')

local config = wezterm.config_builder()

-- Debug (auto reload)
config.automatically_reload_config = true

-- Window
window_decorations = 'RESIZE'
---- Tabs
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- Colors & background
local utils = require('utils')
local bgRGBA = utils.get_scheme_palette().bgRGBA

config.color_scheme = defaults.SCHEME
config.window_background_opacity = defaults.OPACITY
config.colors = {
	tab_bar = {
		background = 'rgba(' .. bgRGBA.r .. ',' .. bgRGBA.g .. ',' .. bgRGBA.b .. ',' .. defaults.OPACITY .. ')'
	}
}

return config
