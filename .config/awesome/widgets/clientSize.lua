local awful = require('awful')
local beautiful = require('beautiful')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/'
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local clientSize = {}
inc_right = wibox.widget {
    {
        {
            widget = wibox.widget.imagebox,
            image = icons_dir .. 'right_arrow.svg',
            resize = true
        },
        widget = wibox.container.margin(_,6,4,6,6,_,_)
    },
    shape = Wdt_shape,
    shape_border_width = dpi(1),
    shape_border_color = beautiful.fg_occupied,
    widget = wibox.container.background
}

inc_left = wibox.widget {
    {
        {
            widget = wibox.widget.imagebox,
            image = icons_dir .. 'left_arrow.svg',
            resize = true
        },
        widget = wibox.container.margin(_,4,6,6,6,_,_)
    },
    shape = Wdt_shape,
    shape_border_width = dpi(1),
    shape_border_color = beautiful.fg_occupied,
    widget = wibox.container.background
}

inc_right:connect_signal('button::press', function(_,_,_,button)
    if (button == 1) then awful.tag.incmwfact(0.05)
end 
end)

inc_left:connect_signal('button::press', function(_,_,_,button)
    if (button == 1) then awful.tag.incmwfact(-0.05)
end 
end)

return clientSize
