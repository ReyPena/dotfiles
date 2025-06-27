local wezterm = require('wezterm')
local utils = require('utils')

local scheme = utils.get_scheme_palette()

local C_HL_1 = scheme.ansi[5]
local C_HL_2 = scheme.ansi[4]
local C_INACTIVE_FG = scheme.ansi[8]

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    if tab.is_active then
        return {
            { Foreground = { Color = C_HL_1 } },
            { Text = " " .. tab.tab_index + 1 },
            { Foreground = { Color = C_HL_2 } },
            { Text = ": " },
            { Foreground = { Color = C_HL_1 } },
            { Text = tab.active_pane.title .. " " },
        }
    end
    return {
        { Foreground = { Color = C_HL_1 } },
        { Text = " " .. tab.tab_index + 1 },
        { Foreground = { Color = C_HL_2 } },
        { Text = ": " },
        { Foreground = { Color = C_INACTIVE_FG } },
        { Text = tab.active_pane.title .. " " },
    }
end)
