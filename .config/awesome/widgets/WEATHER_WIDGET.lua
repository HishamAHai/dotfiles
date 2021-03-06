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
local screen_width = awful.screen.focused().workarea.width
local screen_height = awful.screen.focused().workarea.height

WEATHER_WIDGET_DESC = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    {
        {
            {
                id = 'icon',
                resize = true,
                widget = wibox.widget.imagebox
            },
            margins = screen_width * 0.002,
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
                    forced_width = screen_width * 0.08,
                    forced_height = screen_width * 0.08,
                    resize = true,
                    widget = wibox.widget.imagebox
                },
                margins = screen_width * 0.0039,
                widget = wibox.container.margin
            },
            shape = Wdt_shape,
            bg = Wdt_bg,
            widget = wibox.container.background
        },
        align = 'center',
        widget = wibox.container.place
    },
    {
        {
            id = 'desc',
            font = 'FantasqueSansMono Nerd Font Bold Italic 16',
            widget = wibox.widget.textbox
        },
        align = 'center',
        widget = wibox.container.place
    },
    {
        {
            id = 'Temperatures',
            font = 'SF Pro Display Bold 12',
            widget = wibox.widget.textbox
        },
        align = 'center',
        widget = wibox.container.place
    },
    spacing = screen_height * 0.001,
    layout = wibox.layout.fixed.vertical
}

local function update_widget(widget,stdout)
    Result      =   json.decode(stdout)
    Desc        =   Result.current.weather[1].description
    Icon        =   Result.current.weather[1].icon
    Deg_now     =   Result.current.temp
    Deg_min     =   Result.daily[1].temp.min
    Deg_max     =   Result.daily[1].temp.max
    Deg         =   math.floor(Deg_now)
    Min         =   math.floor(Deg_min)
    Max         =   math.floor(Deg_max)
    widget:get_children_by_id('desc')[1]:set_markup(Desc)
    if Deg <= 10 then
    widget:get_children_by_id('deg')[1]:set_markup('<span fgcolor="' .. beautiful.temp_cold .. '"> ' .. Deg .. ' ??C' .. '</span>')
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup('<span font="8" fgcolor="' .. beautiful.temp_min .. '"> Min: ' ..
    Min .. ' ??C\t</span> <span fgcolor="' .. beautiful.temp_cold .. '">' .. Deg .. ' ??C' ..
    '</span>' .. '<span font="8" fgcolor="' .. beautiful.temp_max .. '"> \tMax: ' .. Max .. ' ??C</span>')
    elseif Deg > 10 and Deg <= 24 then
    widget:get_children_by_id('deg')[1]:set_markup('<span fgcolor="' .. beautiful.temp_norm .. '"> ' .. Deg .. ' ??C' .. '</span>')
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup('<span font="8" fgcolor="' .. beautiful.temp_min .. '"> Min: ' ..
    Min .. ' ??C\t</span> <span fgcolor="' .. beautiful.temp_norm .. '">' .. Deg .. ' ??C</span>' ..
    '<span font="8" fgcolor="' .. beautiful.temp_max .. '"> \tMax: ' .. Max .. ' ??C</span>')
    else
    widget:get_children_by_id('deg')[1]:set_markup('<span fgcolor="' .. beautiful.temp_hot .. '"> ' .. Deg .. ' ??C' .. '</span>')
    WEATHER_WIDGET_BIG:get_children_by_id('Temperatures')[1]:set_markup('<span font="8" fgcolor="' .. beautiful.temp_min .. '"> Min: ' .. Min ..
    ' ??C\t</span>' .. '<span fgcolor="' .. beautiful.temp_hot .. '"> ' .. Deg .. ' ??C' ..
    '</span>' ..'<span font="8" fgcolor="' .. beautiful.temp_max .. '"> \tMax: ' .. Max .. ' ??C</span>')
end
    widget:get_children_by_id('icon')[1]:set_image(icons_dir .. Icon .. icons_ext)
    WEATHER_WIDGET_BIG:get_children_by_id('icon')[1]:set_image(icons_dir .. Icon .. icons_ext)
    datewidget:get_children_by_id('icon')[1]:set_image(clock_icon .. os.date('%H') .. icons_ext)

end

awful.screen.connect_for_each_screen(function(s)
    s.WEATHER_WIDGET = awful.wibar(
    {
        position = 'left',
        width = screen_width * 0.13,
        height = screen_width * 0.13,
        shape = Wdt_shape,
    }
    )

    s.WEATHER_WIDGET:setup{
        WEATHER_WIDGET_BIG,
        margins = screen_height * 0.007,
        widget = wibox.container.margin
    }
end)

watch(string.format(GET_WTHR_CMD,API),timeout,update_widget,WEATHER_WIDGET_DESC)
watch(string.format(GET_WTHR_CMD,API),timeout,update_widget,WEATHER_WIDGET_BIG)

return WEATHER_WIDGET
