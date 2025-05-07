local wezterm = require('wezterm')
local defaults = require('defaults')

local module = {}

function module.is_dark()
    if wezterm.gui then
        return wezterm.gui.get_appearance():find('Dark')
    end
    return true
end

function module.get_scheme_palette(custom_scheme)
    local color_scheme = wezterm.get_builtin_color_schemes()[custom_scheme or defaults.SCHEME]
    local parsedBg = wezterm.color.parse(color_scheme.background)
    local bgR, bgG, bgB, bgA = parsedBg:srgba_u8()

    return {
        background = color_scheme.background,
        parsedBg = parsedBg,
        bgRGBA = {
            r = bgR,
            g = bgG,
            b = bgB,
            a = bgA,
        },
        foreground = color_scheme.foreground,
        ansi = color_scheme.ansi,
        brights = color_scheme.brights,
    }
end

return module
