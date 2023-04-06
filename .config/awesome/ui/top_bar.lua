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
--local brightness_widget = require("widgets.brightness-widget.brightness")
--require('widgets.Volume_widget')
--require('widgets.Net_widget')


local top_bar = {}
local screen_width = awful.screen.focused().geometry.width

awful.screen.connect_for_each_screen(function(s)
    if s.index == 2 then
        s.top_bar = awful.wibar(
        {
            position = 'top',
            visible = false,
            screen = s,
            height = awful.screen.focused().geometry.height * 0.015,
            width = awful.screen.focused().geometry.width * 0.15,
            bg  =   '#0000',
        }
        )
    s.top_bar:setup {
        {
            {
                layout = wibox.layout.align.horizontal,
                { -- Left widgets
                    {
                        layout = wibox.layout.fixed.horizontal,
                        separator, logo, separator,
                        s.hortaglist, separator,
                    },
                    widget = wibox.container.background,
                    shape = Wdt_shape,
                    bg = Wdt_bg
                },
                { -- Middle widgets
                layout = wibox.layout.fixed.horizontal,
                },
                { -- Right widgets
                    {
                        layout = wibox.layout.fixed.horizontal,
                        datewidget, separator,
                    },
                    widget = wibox.container.background,
                    shape = Wdt_shape,
                    bg = Wdt_bg
                },
            },
            margins = screen_width * 0.001,
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        shape = bar_wdt_shape,
        bg = beautiful.bg_normal
    }
elseif s.index == 3 then
        s.top_bar = awful.wibar(
        {
            position    =   'left',
            visible     =   true,
            screen      =   s,
            height      =   awful.screen.focused().geometry.height * 0.8,
            width       =   awful.screen.focused().geometry.width * 0.0135,
            bg          =   '#0000',
        }
        )
    s.top_bar:setup {
        {
            {
                layout = wibox.layout.align.vertical,
                { -- Left widgets
                    {
                        layout = wibox.layout.fixed.vertical,
                        forced_height = awful.screen.focused().geometry.height * 0.25,
                        --separator, logo, separator,
                        s.vertaglist,
                    },
                    widget  =   wibox.container.background,
                    shape   =   Wdt_shape,
                    bg      =   Wdt_bg
                },
                { -- Middle widgets
                layout = wibox.layout.fixed.vertical,
                },
                {
                    {
                        {
                            layout = wibox.layout.fixed.vertical,
                            awful.widget.layoutbox(),
                        },
                        fill_horizontal = true,
                        widget = wibox.container.place,
                    },
                    bg = Wdt_bg,
                    shape = Wdt_shape,
                    widget = wibox.container.background,
                },
            },
            top     =   screen_width * 0.14,
            bottom  =   screen_width * 0.001,
            right   =   screen_width * 0.001,
            left    =   screen_width * 0.001,
            widget  =   wibox.container.margin
        },
        widget = wibox.container.background,
        shape = function(cr,width,height)
            gears.shape.partially_rounded_rect(cr,width,height,false,true,true,false,screen_width * 0.0031)
        end,
        bg = beautiful.bg_normal
    }
    else
    -- Create the wibox
    s.top_bar = awful.wibar(
    {
        position = 'top',
        screen = s ,
        height = awful.screen.focused().geometry.height * 0.02,
        width = awful.screen.focused().geometry.width * 1.0,
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
                    s.hortaglist, separator,
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
--                    {
--                        brightness_widget{
--                            type = 'icon_and_text',
--                            program= 'ybacklight',
--                            path_to_icon = '/usr/share/icons/Papirus/48x48/status/notification-display-brightness-high.svg',
--                            step = 10
--                            },
--                            left = screen_width * 0.002,
--                            right = screen_width * 0.002,
--                            widget = wibox.container.margin
--                    },
--                    separator,
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
            right = screen_width * 0.002,
            left = screen_width * 0.002,
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        --shape = bar_wdt_shape,
        bg = beautiful.bg_normal
    }

    end
end)
return top_bar
