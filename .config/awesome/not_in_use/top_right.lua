local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

require('widgets.decoration')
require('widgets.Date_widget')
require('widgets.Packages_widget')
require('widgets.Disk_widget')
require('widgets.Memory_widget')
require('widgets.Cpu_widget')
require('widgets.Load_avg_widget')
require('widgets.Uptime_widget')
local brightness_widget = require("widgets.brightness-widget.brightness")
local volume_widget = require("widgets.volume-widget.volume")
local volume_widget_widget = volume_widget({display_notification = true})


local top_right = {}
local screen_width = awful.screen.focused().geometry.width

awful.screen.connect_for_each_screen(function(s)
    s.top_right = awful.wibar(
    {
        position = 'top',
        screen  =   s,
        height = awful.screen.focused().geometry.height * 0.018,
        width = screen_width * 0.392,
        bg  =   '#0000',
        shape = Wdt_shape,
    }
    )

    s.top_right:setup {
        {
            {
                layout = wibox.layout.align.horizontal,
                {
                    layout = wibox.layout.fixed.horizontal,
                },
                {
                    layout = wibox.layout.fixed.horizontal,
                },
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
                        {brightness_widget{
                            type = 'icon_and_text',
                            program= 'ybacklight',
                            path_to_icon = '/usr/share/icons/Papirus/48x48/status/notification-display-brightness-high.svg',
                            step = 10},
                            left = screen_width * 0.002,
                            right = screen_width * 0.002,
                            widget = wibox.container.margin
                        },
                        shape = Wdt_shape,
                        bg = Wdt_bg,
                        fg = beautiful.color9,
                        widget = wibox.container.background
                    },
                    separator,
                    datewidget, separator,
                    {
                        volume_widget_widget,
                        shape = Wdt_shape,
                        bg = Wdt_bg,
                        fg = beautiful.color3,
                        widget = wibox.container.background
                    },
                    separator,
                    kbd_widget,
                }
            },
            top = screen_width * 0.0004,
            bottom = screen_width * 0.0004,
            right = screen_width * 0.001,
            left = screen_width * 0.001,
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        shape = bar_wdt_shape,
        bg = beautiful.bg_normal
    }

end)
return top_right
