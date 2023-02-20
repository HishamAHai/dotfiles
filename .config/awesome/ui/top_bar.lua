local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

-- Calls
require('widgets.decoration')
require('widgets.Date_widget')
require('widgets.Packages_widget')
require('widgets.Disk_widget')
require('widgets.Memory_widget')
require('widgets.Cpu_widget')
require('widgets.Load_avg_widget')
require('widgets.Uptime_widget')
local volume_widget = require("widgets.volume-widget.volume")
local volume_widget_widget = volume_widget({display_notification = true})
local brightness_widget = require("widgets.brightness-widget.brightness")
--require('widgets.Volume_widget')
--require('widgets.Net_widget')


local top_bar = {}
local screen_width = awful.screen.focused().geometry.width

awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.top_bar = awful.wibar(
    {
        position = 'top',
        screen = s ,
        height = awful.screen.focused().geometry.height * 0.02,
        width = awful.screen.focused().geometry.width * 0.995,
        bg  =   '#0000',
        --shape = function(cr, width, height)
        --    gears.shape.rounded_rect(cr, width, height, screen_width * 0.003) end
    }
    )

    -- Add widgets to the wibox
    s.top_bar:setup {
        {
            {
                layout = wibox.layout.align.horizontal,
                { -- Left widgets
                {
                    layout = wibox.layout.fixed.horizontal,
                    separator, logo, separator,
                    s.mytaglist, separator,
                },
                widget = wibox.container.background,
                shape = Wdt_shape,
                bg = Wdt_bg
            },
            { -- Middle widgets
            layout = wibox.layout.fixed.horizontal,
        },
        {
            {
                    layout = wibox.layout.fixed.horizontal,
                    net_widget, separator,
                    pkg_widget, separator,
                    disk_widget, separator,
                    mem_widget, separator,
                    cpu_widget, separator,
                    Load_wdt, separator,
                    uptime_wdt, separator,
                    {
                        brightness_widget{
                            type = 'icon_and_text',
                            program= 'ybacklight',
                            path_to_icon = '/usr/share/icons/Papirus/48x48/status/notification-display-brightness-high.svg',
                            step = 10
                            },
                            left = screen_width * 0.002,
                            right = screen_width * 0.002,
                            widget = wibox.container.margin
                    },
                    separator,
                    datewidget, separator,
                    volume_widget_widget,
                    separator, kbd_widget,
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
        shape = bar_wdt_shape,
        bg = beautiful.bg_normal
    }

end)
return top_bar
