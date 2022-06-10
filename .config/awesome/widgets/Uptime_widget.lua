local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Uptime_widget = {}
local screen_width = awful.screen.focused().geometry.width

UP_CMD = [[ bash -c "awk '{print $1}' /proc/uptime" ]]
timeout = 60

uptime_wdt = wibox.widget {
    {
        {
            {
                id = 'icon',
                image = '/usr/share/icons/Papirus/64x64/apps/com.github.sgpthomas.hourglass.svg',
                widget = wibox.widget.imagebox,
                resize = true
            },
            left = screen_width * 0.001,
            top = screen_width * 0.001,
            bottom = screen_width * 0.001,
            widget = wibox.container.margin
        },
        {
            {
                {
                    id = 'up_wdt',
                    widget = wibox.widget.textbox
                },
                widget = wibox.container.margin(_,_,Wdt_rmgn,_,_,_,_),
            },
            valign = 'center',
            widget = wibox.container.place
        },
        layout = wibox.layout.align.horizontal,
    },
    --bg = Wdt_bg,
    fg = beautiful.color4,
    forced_width = screen_width * 0.05,
    shape = Wdt_shape,
    widget = wibox.container.background
}

function Update_up_widget(widget,stdout)
    Up_sec = math.floor(stdout)
    up_d = math.floor(Up_sec   / (3600 * 24))
    up_h = math.floor((Up_sec  % (3600 * 24)) / 3600)
    up_m = math.floor(((Up_sec % (3600 * 24)) % 3600) / 60)
    widget:get_children_by_id('up_wdt')[1]:set_text(string.format('%2d',up_d) ..
    'd:' .. string.format('%2d',up_h) .. 'h:' .. string.format('%2d',up_m) .. 'm')
end

watch(UP_CMD,timeout,Update_up_widget,uptime_wdt)

return Uptime_widget
