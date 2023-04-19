local json          =   require('json')
local watch         =   require('awful.widget.watch')
local awful         =   require('awful')
local gears         =   require('gears')
local wibox         =   require('wibox')
local beautiful     =   require('beautiful')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/weather/Dark/'
local clock_icon    =   os.getenv('HOME') .. '/.config/awesome/icons/clock/dark/'


local WEATHER_WIDGET = {}

local GET_WTHR_CMD  =   'curl -s "%s"'
local city_id       =   '7647007'
local lat           =   '-41.124877'
local lon           =   '-71.365303'
local api_key       =   '8cc75d17134e5ae1a723b5a39e7b6850'
local untis         =   'metric'
local lang          =   'es'
local timeout       =   900
local icons_ext     =   '.svg'
local API           =   'api.openweathermap.org/data/2.5/onecall?exclude=minutely,hourly,alerts'
                        .. '&lat='      .. lat
                        .. '&lon='      .. lon
                        .. '&appid='    .. api_key
                        .. '&id='       ..  city_id
                        .. '&units='    ..  untis
                        .. '&lang='     ..  lang
local screen_width      = awful.screen.focused().geometry.width
local screen_height     = awful.screen.focused().geometry.height
local big_wthr_corner   = function(cr,width,height)
    gears.shape.rounded_rect(cr,width,height,screen_width * 0.0033)end

WEATHER_WIDGET_DESC = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    {
        {
            {
                id = 'icon',
                forced_width = screen_width * 0.01,
                forced_height = screen_width * 0.01,
                resize = true,
                widget = wibox.widget.imagebox
            },
            margins = screen_width * 0.0005,
            widget = wibox.container.margin
        },
        align = 'center',
        widget = wibox.container.place
    },
    {
        id = 'desc',
        widget = wibox.widget.textbox
    },
    {
        id = 'deg',
        widget = wibox.widget.textbox
    },
}

WEATHER_WIDGET_BIG = wibox.widget {
    {
        {
                {
                    {
                        {
                            {
                                {
                                    id = 'icon',
                                    resize = true,
                                    widget = wibox.widget.imagebox
                                },
                                margins = screen_width * 0.002,
                                widget = wibox.container.margin,
                            },
                            valign = 'center',
                            halign = 'center',
                            widget = wibox.container.place,
                        },
                        shape = big_wthr_corner,
                        bg = beautiful.bg_empty,
                        forced_width = screen_width * 0.05,
                        widget = wibox.container.background,
                    },
                    {
                        {
                            {
                                id = 'Temperatures',
                                font = 'Red Hat Display Black 24',
                                align = 'center',
                                widget = wibox.widget.textbox
                            },
                                margins = screen_width * 0.0005,
                                widget = wibox.container.margin,
                        },
                        shape = big_wthr_corner,
                        bg = beautiful.bg_empty,
                        forced_width = screen_width * 0.05,
                        widget = wibox.container.background,
                    },
                    spacing = screen_width * 0.003,
                    layout = wibox.layout.flex.horizontal,
                },
                margins = screen_width * 0.001,
                widget = wibox.container.margin
        },
        align = 'center',
        widget = wibox.container.place
    },
    {
        {
            {
                {
                    {
                        id = 'desc',
                        font = 'Red Hat Display 14',
                        halign = 'left',
                        widget = wibox.widget.textbox
                    },
                    halign = 'left',
                    widget = wibox.container.place
                },
                {
                    {
                        id = 'wind_cond',
                        font = 'Red Hat Display 13',
                        halign = 'left',
                        widget = wibox.widget.textbox
                    },
                    halign = 'left',
                    widget = wibox.container.place
                },
                {
                    {
                        id = 'sunrise',
                        font = 'Red Hat Display 13',
                        halign = 'left',
                        widget = wibox.widget.textbox
                    },
                    halign = 'left',
                    widget = wibox.container.place
                },
                {
                    {
                        id = 'sunset',
                        font = 'Red Hat Display 13',
                        halign = 'left',
                        widget = wibox.widget.textbox
                    },
                    halign = 'left',
                    widget = wibox.container.place
                },
                layout = wibox.layout.flex.vertical
            },
            top = 4,
            bottom = 4,
            left = 6,
            widget = wibox.container.margin,
        }, 
        -- shape = big_wdt_shape,
        shape = function(cr,width,height)
            gears.shape.rounded_rect(cr,width,height,screen_width * 0.0025)
        end,
        bg = beautiful.bg_empty,
        widget = wibox.container.background
    },
    spacing = screen_height * 0.003,
    layout = wibox.layout.fixed.vertical
}

local function update_widget(widget,stdout)
    Result      =   json.decode(stdout)
    Desc        =   Result.current.weather[1].description
    Icon        =   Result.current.weather[1].icon
    sunrise_unix=   Result.daily[1].sunrise
    sunset_unix =   Result.daily[1].sunset
    Deg_now     =   Result.current.temp
    wind_spd    =   Result.current.wind_speed * 3.6
    Deg         =   math.floor(Deg_now)
    Win         =   math.floor(wind_spd)

    widget:get_children_by_id('icon')[1]:set_image(icons_dir .. Icon .. icons_ext)
    widget:get_children_by_id('desc')[1]:set_markup(' ' .. Desc)

    datewidget:get_children_by_id('icon')[1]:set_image(clock_icon .. os.date('%H') .. icons_ext)

    WEATHER_WIDGET_BIG:get_children_by_id('icon')[1]:set_image(         icons_dir .. Icon .. icons_ext)
    WEATHER_WIDGET_BIG:get_children_by_id('desc')[1]:set_markup(        'ℹ️\t' .. string.upper(Desc))
    WEATHER_WIDGET_BIG:get_children_by_id('wind_cond')[1]:set_markup(   '💨\tViento:\t\t'   ..  Win .. ' km/h')
    WEATHER_WIDGET_BIG:get_children_by_id('sunrise')[1]:set_markup(     '🌄\tAmanece:\t'    ..  os.date('%H:%M',sunrise_unix))
    WEATHER_WIDGET_BIG:get_children_by_id('sunset')[1]:set_markup(      '🌇\tAtardece:\t\t' ..  os.date('%H:%M',sunset_unix))

    if Deg <= 10 then
        widget:get_children_by_id('deg')[1]:set_markup( '<span fgcolor="' .. beautiful.temp_cold .. '"> ' .. Deg .. ' °C</span>')
        WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup( '<span fgcolor="' .. beautiful.temp_cold .. '">' .. Deg .. ' °C</span>')
    elseif Deg > 10 and Deg <= 24 then
        widget:get_children_by_id('deg')[1]:set_markup( '<span fgcolor="' .. beautiful.temp_norm .. '"> ' .. Deg .. ' °C</span>')
        WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup( '<span fgcolor="' .. beautiful.temp_norm .. '">' .. Deg .. ' °C</span>')
    else
        widget:get_children_by_id('deg')[1]:set_markup( '<span fgcolor="' .. beautiful.temp_hot .. '"> ' .. Deg .. ' °C</span>')
        WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup( '<span fgcolor="' .. beautiful.temp_hot .. '">' .. Deg .. ' °C</span>')
    end

end

awful.screen.connect_for_each_screen(function(s)
    if s.index == 1 then
    s.WEATHER_WIDGET = awful.wibar(
    {
        position    =   'left',
        screen      =   primary,
        width       =   screen_width * 0.085,
        height      =   screen_height * 0.15,
        bg          =   '#0000',
        --shape       =   bar_wdt_shape
    }
    )

    s.WEATHER_WIDGET:setup{
        {
            WEATHER_WIDGET_BIG,
            margins = screen_height * 0.003,
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        shape = big_wdt_shape,
        bg = beautiful.bg_normal
    }
    end
end)

watch(string.format(GET_WTHR_CMD,API),timeout,update_widget,WEATHER_WIDGET_DESC)
watch(string.format(GET_WTHR_CMD,API),timeout,update_widget,WEATHER_WIDGET_BIG)

return WEATHER_WIDGET
