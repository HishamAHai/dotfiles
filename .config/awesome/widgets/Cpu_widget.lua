local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Cpu_widget = {}
local screen_width = awful.screen.focused().geometry.width

timeout = 10
CPU_CMD = 'cpu.sh'

cpu_widget = wibox.widget {
    {
        {
            id = 'cpu_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    --bg = Wdt_bg,
    fg = beautiful.color14,
    forced_width = screen_width * 0.058,
    shape = Wdt_shape,
    widget = wibox.container.background
}
cpu_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e htop')
    end
        end)

function Update_cpu_widget(widget,stdout)
    widget:get_children_by_id('cpu_wdt')[1]:set_text(stdout)
end

watch(CPU_CMD,timeout,Update_cpu_widget,cpu_widget)

return Cpu_widget
