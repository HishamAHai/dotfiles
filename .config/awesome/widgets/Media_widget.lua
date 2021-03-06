local watch = require('awful.widget.watch')
local wibox = require('wibox')
local awful = require('awful')

local Media_widget = {}


MEDIA_CMD = 'playerctl metadata --format "%s"'
ARG =   '{{emoji(status)}} ' ..
        '{{duration(position)}}' ..
        '({{duration(mpris:length)}})'..
        '[{{default(xesam:artist,playerName)}}]' ..
        '[{{xesam:title}}]'

Media_wdt = wibox.widget {
    {
        {
            id = 'current_song',
            widget = wibox.widget.textbox
        },
        layout = wibox.container.scroll.horizontal,
        max_size = awful.screen.focused().workarea.width * 0.25,
        step_function = wibox.container.scroll.step_functions.linear_increase,
        fps = 75,
        speed = 60,
        extra_space = 5
    },
    margins = awful.screen.focused().workarea.width * 0.002,
    widget = wibox.container.margin
}
Media_wdt:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e vis')
        elseif (button == 3) then awful.spawn.with_shell('alacritty --hold -e spt')
    end
        end)

function Update_media_widget(widget,stdout)
    widget:get_children_by_id('current_song')[1]:set_text(stdout)
end

watch(string.format(MEDIA_CMD,ARG),3,Update_media_widget,Media_wdt)

return Media_widget
