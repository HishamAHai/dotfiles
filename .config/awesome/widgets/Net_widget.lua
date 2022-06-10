local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')


local Net_widget = {}

NET_CMD = [[ bash -c 'net.sh']]

net_widget = wibox.widget {
    {
        {
            id = 'net_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    bg = Wdt_bg,
    shape = Wdt_shape,
    widget = wibox.container.background
}
net_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e bmon -p eno2')
    end
end)

function Update_net_widget(widget,stdout)
    widget:get_children_by_id('net_wdt')[1]:set_text(stdout)
end

watch(NET_CMD,1,Update_net_widget,net_widget)

return Net_widget
