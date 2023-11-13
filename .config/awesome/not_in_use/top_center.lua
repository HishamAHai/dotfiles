local awful = require('awful')
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

-- Calls
require('widgets.decoration')


local top_center = {}

awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.top_center = awful.wibar(
    {
        position = 'left',
        screen = s ,
        bg = '#21212100',
        height = dpi(20),
        width = awful.screen.focused().geometry.width * 0.13,
    }
    )

    -- Add widgets to the wibox
    s.top_center:setup {
        layout = wibox.layout.flex.horizontal,
		mytasklist
    }

end)
return top_center
