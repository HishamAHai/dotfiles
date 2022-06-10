local beautiful = require('beautiful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Load_avg_widget = {}

UP_CMD = "awk '{print $1\";\"$2\";\"$3}' /proc/loadavg"
timeout = 10

Load_wdt = wibox.widget {
    {
        {
            id = 'load_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    --bg = Wdt_bg,
    fg = beautiful.fg_normal,
    shape = Wdt_shape,
    widget = wibox.container.background
}

function Update_up_widget(widget,stdout)
    local loads = {}
    for w in stdout:gmatch("([^;]*)") do table.insert(loads, w) end
    widget:get_children_by_id('load_wdt')[1]:set_markup('1️⃣' .. loads[1] .. '  5️⃣' .. loads[2] .. ' 🆙' .. loads[3])
end

watch(UP_CMD,timeout,Update_up_widget,Load_wdt)

return Load_avg_widget
