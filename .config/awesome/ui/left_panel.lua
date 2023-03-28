local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

-- Calls
require('widgets.decoration')


local left_panel = {}
local screen_width = awful.screen.focused().geometry.width

awful.screen.connect_for_each_screen(function(s)
    s.left_panel = awful.wibar(
    {
        position = 'left',
        screen = s ,
        height = awful.screen.focused().geometry.height * 0.34,
        width = awful.screen.focused().geometry.width * 0.02,
        bg  =   '#0000',
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, screen_width * 0.004) end
    }
    )

    s.left_panel:setup {
        {
            {
                {
                    layout = wibox.layout.align.horizontal,
                    {
                        {
                            layout = wibox.layout.fixed.horizontal,
                            separator, logo, separator,
                            s.mytaglist, separator,
                        },
                        widget = wibox.container.background,
                        shape = Wdt_shape,
                        bg = Wdt_bg
                    },
                    {
                    layout = wibox.layout.fixed.horizontal,
                    },
                    {
                        {
                            layout = wibox.layout.fixed.horizontal,
                        },
                        widget = wibox.container.background,
                        shape = Wdt_shape,
                        bg = Wdt_bg
                    },
                },
                top = screen_width * 0.001,
                bottom = screen_width * 0.001,
                right = screen_width * 0.001,
                left = screen_width * 0.001,
                widget = wibox.container.margin
            },
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, screen_width * 0.0043) end,

            bg = beautiful.bg_normal
        },
        widget = wibox.container.rotate,
        direction = "east",
    }

end)
return left_panel
