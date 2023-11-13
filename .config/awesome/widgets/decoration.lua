--[[
  ╔════════════════════════════════════════╗
 ╔╝                                        ╚╗
 ║ Riced and crafted by  Hisham Abdul Hai  ║
 ║       ...Founder of Nofarah Tech...      ║
 ╚╗                                        ╔╝ 
  ╚════════════════════════════════════════╝
--]]

-- Initialization
local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local config_dir = gears.filesystem.get_configuration_dir()

local decoration = {}
local screen_width = awful.screen.focused().geometry.width

-- Global widgets settings
Wdt_bg      =   beautiful.bg_empty
Wdt_shape   =   function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, screen_width * 0.0022) end
big_wdt_shape   =   function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, screen_width * 0.004) end
bar_wdt_shape   =   function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, screen_width * 0.0031) end
Wdt_rmgn    =   screen_width * 0.002
Wdt_lmgn    =   screen_width * 0.002

-- the systray has its own internal background because of X11 limitations
round_systry = wibox.widget {
    {
        wibox.widget.systray(),
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    --bg         = Wdt_bg,
    shape      = Wdt_shape,
    widget     = wibox.container.background,
}

kbd_widget = wibox.widget {
    {
        {
            widget = awful.widget.keyboardlayout()
        },
        margins = screen_width * 0.001,
        widget = wibox.container.margin
    },
    --bg = Wdt_bg,
    shape = Wdt_shape,
    widget = wibox.container.background
}

logo = wibox.widget {
    {
        {
            id = 'icon',
            image = config_dir ..'/icons/logo_2023.svg',
            resize = true,
            opacity = 1.0,
            widget = wibox.widget.imagebox
        },
        --left = screen_width * 0.001,
        --top = screen_width * 0.0008,
        --bottom = screen_width * 0.0008,
        --margins = screen_width * 0.0003,
        widget = wibox.container.margin
    },
    shape = Wdt_shape,
    widget = wibox.container.background
}
logo:connect_signal('button::press',function(_,_,_,button)
    if (button == 1) then
        mymainmenu:toggle()
        logo:set_bg(beautiful.taglist_fg_empty)
        logo:get_children_by_id('icon')[1]:set_opacity(0.1)
    end
end)
logo:connect_signal('button::release',function(_,_,_,button)
    if (button == 1) then
        logo:set_bg(Wdt_bg)
        logo:get_children_by_id('icon')[1]:set_opacity(1)
    end
end)

separator = {

                forced_width    = screen_width * 0.001,
                opacity         = 0,
                widget          = wibox.widget.separator
            }

return decration
