local awful         =   require("awful")
local beautiful     =   require('beautiful')
local gears         =   require('gears')
local wibox         =   require("wibox")
local xresources    =   require('beautiful.xresources')
local dpi           =   xresources.apply_dpi


require('ui.left_panel')
require('widgets.Prayers_widget')
require('widgets.Date_widget')
require('widgets.Kernel_widget')
require('widgets.Weather_widget')
require('widgets.Cpu_temp_widget')
require('widgets.Gpu_temp_widget')
require('widgets.quotes')
require('widgets.Packages_widget')
require('widgets.Disk_widget')
require('widgets.Memory_widget')
require('widgets.Cpu_widget')
require('widgets.Load_avg_widget')
require('widgets.Uptime_widget')
local volume_widget = require("widgets.volume-widget.volume")
local volume_widget_widget = volume_widget({display_notification = true})
local brightness_widget = require("widgets.brightness-widget.brightness")

local bottom_bar = {}

local screen_width  =   awful.screen.focused().geometry.width
local screen_height =   awful.screen.focused().geometry.height

layoutbox = wibox.widget {
    {
        awful.widget.layoutbox(),
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    --bg = Wdt_bg,
    shape   =   Wdt_shape,
    widget  =   wibox.container.background
}

awful.screen.connect_for_each_screen(function(s)

    s.bottom_bar = awful.wibar(
    {
        position    =   'bottom',
        screen      =   s,
        height      =   awful.screen.focused().geometry.height * 0.02,
        width       =   awful.screen.focused().geometry.width * 0.99,
        bg          =   '#0000',
        shape       =   function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, screen_width * 0.003) end

    }
    )
-- ========================= Widgets and bars placement =======================
    s.Prayers_widget.y          =   screen_height * 0.275
    s.Prayers_widget.x          =   screen_width * 0.92
    s.WEATHER_WIDGET.y          =   screen_height * 0.5186
    s.WEATHER_WIDGET.x          =   screen_width * 0.92
    s.quotes.y                  =   screen_height * 0.6318
    s.quotes.x                  =   screen_width * 0.92
    s.bottom_bar.y              =   screen_height * 0.978
    s.left_panel.x              =   screen_width * 0.001
    s.left_panel.y              =   screen_height * 0.384

    s.bottom_bar:setup {
        {
            {
                layout = wibox.layout.align.horizontal,
                {
                    layout = wibox.layout.fixed.horizontal,
                },
                {
                    layout = wibox.layout.fixed.horizontal,
                    mytasklist
                },
                {
                    {
                        layout = wibox.layout.fixed.horizontal,
                        {
                            {
                                Pryr_wdt,
                                widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_)
                            },
                            shape = Wdt_shape,
                            widget = wibox.container.background
                        },
                        separator,
                        {
                            {
                                WEATHER_WIDGET_DESC,
                                widget = wibox.container.margin(_,2,Wdt_rmgn,_,_,_,_)
                            },
                            shape = Wdt_shape,
                            widget = wibox.container.background,
                        },
                        kernel_wdt, separator,
                        pkg_widget, separator,
                        gpu_temp_widget, separator,
                        cpu_temp_widget, separator,
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
                        volume_widget_widget,
                        datewidget, separator,
                        kbd_widget, separator,
                        layoutbox, separator,
                        round_systry,
                    },
                    shape = Wdt_shape,
                    bg = Wdt_bg,
                    widget = wibox.container.background,
                },
            },
            margins = screen_width * 0.001,
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        shape = bar_wdt_shape,
        bg = beautiful.bg_normal,
    }
end)

return bottom_bar
