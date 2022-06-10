local watch = require('awful.widget.watch')
local beautiful = require('beautiful')
local wibox = require('wibox')
local awful = require('awful')

local Media_widget = {}


MEDIA_CMD = 'playerctl metadata --format "%s"'
elapsed =   '{{emoji(status)}} ' ..
        '{{duration(position)}}' ..
        '({{duration(mpris:length)}})'
info = '[{{default(xesam:artist,playerName)}}]' ..
        '[{{xesam:title}}]'

Media_wdt = wibox.widget {
    {
       layout = wibox.layout.fixed.horizontal,
       {
	  {
	     id = 'elapsed',
	     widget = wibox.widget.textbox,
	  },
	  right = awful.screen.focused().geometry.width * 0.002,
	  widget = wibox.container.margin
       },
       {
	  {
	     id = 'info',
	     widget = wibox.widget.textbox,
	  },
	  layout = wibox.container.scroll.horizontal,
	  max_size = awful.screen.focused().geometry.width * 0.15,
	  step_function = wibox.container.scroll.step_functions.linear_increase,
	  fps = 60,
	  speed = 15,
	  extra_space = 5
       },
       valign = 'center',
       widget = wibox.container.place
    },
    margins = awful.screen.focused().geometry.width * 0.0005,
    widget = wibox.container.margin
}
Media_wdt:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e vis')
        elseif (button == 3) then awful.spawn.with_shell('alacritty --hold -e spt')
    end
        end)

function Update_elapsed_widget(widget,stdout)
    widget:get_children_by_id('elapsed')[1]:set_markup('<span fgcolor="' .. beautiful.color4 .. '">' .. stdout .. '</span>')
end
function Update_info_widget(widget,stdout)
    widget:get_children_by_id('info')[1]:set_text(stdout)
end

watch(string.format(MEDIA_CMD,elapsed),10,Update_elapsed_widget,Media_wdt)
watch(string.format(MEDIA_CMD,info),10,Update_info_widget,Media_wdt)

return Media_widget
