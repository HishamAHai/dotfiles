local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
--local watch = require('awful.widget.watch')
--local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/clock/'

local Date_widget = {}
--local icons_ext = '.svg'
local screen_width = awful.screen.focused().geometry.width

datewidget = wibox.widget {
    {
        {
            {
                {
                    id = 'icon',
                    resize = true,
                    widget = wibox.widget.imagebox
                },
                margins = screen_width * 0.0013,
                widget = wibox.container.margin
            },
            {
                format = "(%a %d/%m)%H:%M",
                widget = wibox.widget.textclock
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    --bg = Wdt_bg,
    fg = beautiful.color13,
    shape = Wdt_shape,
    widget = wibox.container.background
}

--function Update_icon()
--    datewidget:get_children_by_id('icon')[1]:set_image(icons_dir .. os.date('%H') .. icons_ext)
--end
--watch('bash -c "date +%H"',60,Update_icon,datewidget)

return Date_widget
