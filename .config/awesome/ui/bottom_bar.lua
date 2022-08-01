local awful         =   require("awful")
local beautiful     =   require('beautiful')
local gears         =   require('gears')
local wibox         =   require("wibox")
local xresources    =   require('beautiful.xresources')
local dpi           =   xresources.apply_dpi
--require('top_right')
--require('top_left')
require('ui.top_bar')
require('widgets.Prayers_widget')
require('widgets.Media_widget')
require('widgets.Date_widget')
require('widgets.Kernel_widget')
require('widgets.Weather_widget')
require('widgets.Cpu_temp_widget')
require('widgets.Gpu_temp_widget')
require('widgets.quotes')
require('widgets.clientSize')

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
    s.top_bar.y               =   screen_height * 0.00208
    --screen[1].top_right.x       =   screen_width * 0.606
    ----screen[2].top_right.x       =   screen_width * 1.554
    --s.top_right.y               =   screen_height * 0.00208
    --screen[1].top_left.x        =   screen_width * 0.0015
    ----screen[2].top_left.x        =   screen_width * 1.0025
    --s.top_left.y                =   screen_height * 0.00208
    ----s.top_left.y                =   screen_height * 0.00
    screen[1].Prayers_widget.x  =   screen_width * 0.92
    --screen[2].Prayers_widget.x  =   screen_width * 1.867
    s.Prayers_widget.y          =   screen_height * 0.275
    screen[1].WEATHER_WIDGET.x  =   screen_width * 0.92
    --screen[2].WEATHER_WIDGET.x  =   screen_width * 1.867
    s.WEATHER_WIDGET.y          =   screen_height * 0.5186
    screen[1].quotes.x                  =   screen_width * 0.92
    --screen[2].quotes.x                  =   screen_width * 1.887
    s.quotes.y                  =   screen_height * 0.6318
    s.bottom_bar.y              =   screen_height * 0.978

    s.bottom_bar:setup {
        {
            {
                layout = wibox.layout.align.horizontal,
                {
                    layout = wibox.layout.fixed.horizontal,
                    {
                        {
                            {
                                layout = wibox.layout.fixed.horizontal,
                                {
                                    text = 'Now Playing >>> ',
                                    widget = wibox.widget.textbox
                                },
                                {
                                    Media_wdt,
                                    fg = beautiful.color3,
                                    widget = wibox.container.background
                                },
                                {
                                    text = ' <<<',
                                    widget = wibox.widget.textbox
                                }
                            },
                            widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_)
                        },
                        bg = Wdt_bg,
                        shape = Wdt_shape,
                        widget = wibox.container.background
                    }, separator
                },
                {
                    layout = wibox.layout.fixed.horizontal,
                    mytasklist
                },
                {
                    {
                        layout = wibox.layout.fixed.horizontal,
                        separator, inc_left, separator, inc_right,
                        {
                            {
                                Pryr_wdt,
                                widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_)
                            },
                            --bg = Wdt_bg,
                            shape = Wdt_shape,
                            widget = wibox.container.background
                        },
                        separator,
                        {
                            {
                                WEATHER_WIDGET_DESC,
                                widget = wibox.container.margin(_,2,Wdt_rmgn,_,_,_,_)
                            },
                            --bg = Wdt_bg,
                            shape = Wdt_shape,
                            widget = wibox.container.background,
                        },
                        separator,
                        gpu_temp_widget, separator,
                        cpu_temp_widget, separator,
                        kernel_wdt, separator,
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
