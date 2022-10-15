local json          =   require('json')
local watch         =   require('awful.widget.watch')
local awful         =   require('awful')
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
                        id = 'icon',
                        forced_width = screen_width * 0.03,
                        forced_height = screen_width * 0.03,
                        resize = true,
                        widget = wibox.widget.imagebox
                    },
                    {
                        id = 'desc',
                        font = 'Inter 13',
                        align = 'center',
                        widget = wibox.widget.textbox
                    },
                    spacing = screen_width * 0.005,
                    layout = wibox.layout.fixed.horizontal,
                },
                margins = screen_width * 0.002,
                widget = wibox.container.margin
        },
        align = 'center',
        widget = wibox.container.place
    },
    {
        {
            {
                {
                    id = 'Temperatures',
                    font = 'Inter Bold 15',
                    widget = wibox.widget.textbox
                },
                align = 'center',
                widget = wibox.container.place
            },
            {
                {
                    id = 'wind_cond',
                    font = 'Inter 12',
                    widget = wibox.widget.textbox
                },
                align = 'center',
                widget = wibox.container.place
            },
            spacing = screen_height * 0.011,
            layout = wibox.layout.fixed.vertical
        },
        shape = big_wdt_shape,
        bg = beautiful.bg_empty,
        widget = wibox.container.background
    },
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
    widget:get_children_by_id('desc')[1]:set_markup(Desc)
    WEATHER_WIDGET_BIG:get_children_by_id('wind_cond')[1]:set_markup('viento: '.. Win .. 'km/h')
    WEATHER_WIDGET_BIG:get_children_by_id('desc')[1]:set_markup(Desc)
    if Deg <= 10 then
    widget:get_children_by_id('deg')[1]:set_markup('<span fgcolor="' .. beautiful.temp_cold .. '"> ' .. Deg .. ' °C' .. '</span>')
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup('<span font="8" fgcolor="' .. beautiful.temp_min .. '"> Min: ' ..
    Min .. ' °C </span> <span fgcolor="' .. beautiful.temp_cold .. '">' .. Deg .. ' °C' ..
    '</span>' .. '<span font="8" fgcolor="' .. beautiful.temp_max .. '"> Max: ' .. Max .. ' °C</span>')
    elseif Deg > 10 and Deg <= 24 then
    widget:get_children_by_id('deg')[1]:set_markup('<span fgcolor="' .. beautiful.temp_norm .. '"> ' .. Deg .. ' °C' .. '</span>')
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup('<span font="8" fgcolor="' .. beautiful.temp_min .. '"> Min: ' ..
    Min .. ' °C </span> <span fgcolor="' .. beautiful.temp_norm .. '">' .. Deg .. ' °C</span>' ..
    '<span font="8" fgcolor="' .. beautiful.temp_max .. '"> Max: ' .. Max .. ' °C</span>')
    else
    widget:get_children_by_id('deg')[1]:set_markup('<span fgcolor="' .. beautiful.temp_hot .. '"> ' .. Deg .. ' °C' .. '</span>')
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup('<span font="8" fgcolor="' .. beautiful.temp_min .. '"> Min: ' .. Min ..
    ' °C </span>' .. '<span fgcolor="' .. beautiful.temp_hot .. '"> ' .. Deg .. ' °C' ..
    '</span>' ..'<span font="8" fgcolor="' .. beautiful.temp_max .. '"> Max: ' .. Max .. ' °C</span>')
end
    widget:get_children_by_id('icon')[1]:set_image(icons_dir .. Icon .. icons_ext)
    WEATHER_WIDGET_BIG:get_children_by_id('icon')[1]:set_image(icons_dir .. Icon .. icons_ext)
    datewidget:get_children_by_id('icon')[1]:set_image(clock_icon .. os.date('%H') .. icons_ext)

end

awful.screen.connect_for_each_screen(function(s)
    s.WEATHER_WIDGET = awful.wibar(
    {
        position    =   'left',
        screen      =   s,
        width       =   screen_width * 0.078,
        height      =   screen_height * 0.11,
        bg          =   '#0000',
        shape       =   bar_wdt_shape
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
end)

watch(string.format(GET_WTHR_CMD,API),timeout,update_widget,WEATHER_WIDGET_DESC)
watch(string.format(GET_WTHR_CMD,API),timeout,update_widget,WEATHER_WIDGET_BIG)

return WEATHER_WIDGET
