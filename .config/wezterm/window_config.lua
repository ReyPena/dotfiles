local wezterm = require('wezterm')
local defaults = require('defaults')
local utils = require('utils')

function segments_for_right_status()
    return {
        wezterm.nerdfonts.linux_archlinux,
        wezterm.strftime('%a %m/%d %H:%M'),
        wezterm.hostname(),
    }
end

function get_gradient_colors(bg, is_dark, segments)
    local gradient_to, gradient_from = bg
    gradient_from = is_dark and bg:lighten(0.2) or bg:darken(0.2)

    return wezterm.color.gradient(
            {
                orientation = 'Horizontal',
                colors = { gradient_from, gradient_to },
            },
            #segments -- only gives us as many colours as we have segments.
    )
end

wezterm.on('update-status', function(window)
    local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
    local segments = segments_for_right_status()

    local color_scheme = utils.get_scheme_palette()
    local bg = color_scheme.parsedBg
    local fg = color_scheme.foreground
    local bgRGBA = color_scheme.bgRGBA

    local gradient = get_gradient_colors(bg, utils.is_dark(), segments)

    local elements = {}

    for i, seg in ipairs(segments) do
        local is_first = i == 1

        if is_first then
            table.insert(elements, { Background = {
                Color = 'rgba(' .. bgRGBA.r .. ',' .. bgRGBA.g .. ',' .. bgRGBA.b .. ',' .. defaults.OPACITY .. ')'
            } })
        end
        table.insert(elements, { Foreground = { Color = gradient[i] } })
        table.insert(elements, { Text = SOLID_LEFT_ARROW })

        table.insert(elements, { Foreground = { Color = fg } })
        table.insert(elements, { Background = { Color = gradient[i] } })
        table.insert(elements, { Text = ' ' .. seg .. ' ' })
    end

    window:set_right_status(wezterm.format(elements))
end)
