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
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

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
                                margins = screen_width * 0.001,
                                widget = wibox.container.margin,
                            },
                            valign = 'center',
                            halign = 'center',
                            widget = wibox.container.place,
                        },
                        shape = function(cr,width,height)
                            gears.shape.rounded_rect(cr,width,height,screen_width * 0.0033) end,
                        bg = beautiful.bg_empty,
                        forced_width = screen_width * 0.05,
                        widget = wibox.container.background,
                    },
                    {
                        {
                            {
                                id = 'Temperatures',
                                font = 'Red Hat Display Bold 24',
                                align = 'center',
                                widget = wibox.widget.textbox
                            },
                                margins = screen_width * 0.0005,
                                widget = wibox.container.margin,
                        },
                        shape = function(cr,width,height)
                            gears.shape.rounded_rect(cr,width,height,screen_width * 0.0033) end,
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
                    id = 'desc',
                    font = 'Red Hat Display 14',
                    widget = wibox.widget.textbox
                },
                align = 'center',
                widget = wibox.container.place
            },
            {
                {
                    id = 'wind_cond',
                    font = 'Red Hat Display 14',
                    widget = wibox.widget.textbox
                },
                align = 'center',
                widget = wibox.container.place
            },
            layout = wibox.layout.flex.vertical
        },
        shape = big_wdt_shape,
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
    Deg_now     =   Result.current.temp
    Deg_min     =   Result.daily[1].temp.night
    Deg_max     =   Result.daily[1].temp.day
    wind_spd    =   Result.current.wind_speed * 3.6
    Deg         =   math.floor(Deg_now)
    Min         =   math.floor(Deg_min)
    Max         =   math.floor(Deg_max)
    Win         =   math.floor(wind_spd)

    widget:get_children_by_id('icon')[1]:set_image(icons_dir .. Icon .. icons_ext)
    widget:get_children_by_id('desc')[1]:set_markup(' ' .. Desc)
    widget:get_children_by_id('deg')[1]:set_markup( ' ' .. Deg .. ' °C')

    datewidget:get_children_by_id('icon')[1]:set_image(clock_icon .. os.date('%H') .. icons_ext)

    WEATHER_WIDGET_BIG:get_children_by_id('icon')[1]:set_image(icons_dir .. Icon .. icons_ext)
    WEATHER_WIDGET_BIG:get_children_by_id('desc')[1]:set_markup(Desc)
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup( Deg .. ' °C')
    WEATHER_WIDGET_BIG:get_children_by_id('wind_cond')[1]:set_markup('viento: '.. Win .. 'km/h')

end

awful.screen.connect_for_each_screen(function(s)
    if s.index == 1 then
    s.WEATHER_WIDGET = awful.wibar(
    {
        position    =   'left',
        screen      =   primary,
        width       =   screen_width * 0.085,
        height      =   screen_height * 0.12,
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
