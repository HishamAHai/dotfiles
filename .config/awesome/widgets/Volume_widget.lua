local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')


local Volume_widget = {}

timeout = 1
VOL_CMD = [[ bash -c '

[ $(pamixer --get-mute) = true ] && echo 🔇 && exit

vol="$(pamixer --get-volume)"

if [ "$vol" -gt "70" ]; then
	icon="🔊"
elif [ "$vol" -lt "20" ]; then
	icon="🔈"
else
	icon="🔉"
fi

echo "$icon $vol%"
' ]]

volumewidget = wibox.widget {
    {
        {
            id = 'vol_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    bg = Wdt_bg,
    shape_clip = true,
    shape = wdt_shape,
    widget = wibox.container.background
}
volumewidget:connect_signal('button::press', function (_,_,_,button)
    if (button == 4) then  awful.spawn.with_shell ('volume.sh up')
	elseif (button == 5) then awful.spawn.with_shell ('volume.sh down')
	elseif (button == 1 ) then awful.spawn.with_shell ('alacritty --hold -e pulsemixer')
	end
end)

function Update_vol_widget(widget,stdout)
    widget:get_children_by_id('vol_wdt')[1]:set_text(stdout)
end

Vol_wdt_timer = watch(VOL_CMD,timeout,Update_vol_widget,volumewidget)

return Volume_widget
