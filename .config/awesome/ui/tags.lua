local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
require('widgets.decoration')
local beautiful = require('beautiful')
local bling = require('modules.bling')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/tags/dark/'


local tags = {}
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
}
awful.screen.connect_for_each_screen(function(s)
    if s.index == 1 then
    awful.tag.add('',{ -- '⠚⠁⠧⠗⠊⠎',
            name                = 'J.A.R.V.I.S',
            id                  = '1',
            screen              = s,
			layout              = awful.layout.suit.tile,
			gap_single_client	= true,
			gap                 = 6,
			selected		    = true
			}
		)
    awful.tag.add('',{      -- '⠞⠁⠗⠎',
            name                = 'TARS',
            id                  = '2',
            screen              = s,
			layout              = awful.layout.suit.tile,
            master_width_factor =   0.6,
			gap_single_client	= true,
			gap			        = 6,
			}
		)
    awful.tag.add('',{    -- '⠍⠕⠞⠓⠑⠗',
            name                = 'MOTHER',
            id                  = '3',
            screen              = s,
			layout			    = awful.layout.suit.tile,
			gap_single_client	= true,
			gap			        = 6,
			}
		)
    awful.tag.add('',{       -- '⠓⠁⠇',
            name                = 'HAL',
            id                  = '4',
            screen              = s,
			layout			    = awful.layout.suit.tile,
			gap_single_client	= true,
			gap			        = 6,
			}
		)
    awful.tag.add('',{    -- '⠎⠅⠽⠝⠑⠞',
            name                = 'SKYNET',
            id                  = '5',
            screen              = s,
			layout			    = awful.layout.suit.tile,
			gap_single_client	= true,
			gap			        = 6,
			}
		)
    awful.tag.add('',{    -- '⠋⠗⠊⠙⠁⠽',
            name                = 'F.R.I.D.A.Y',
            id                  = '6',
            screen              = s,
			layout			    = awful.layout.suit.tile,
            master_width_factor =   0.75,
			gap_single_client	= true,
			gap			        = 6,
			}
		)
    else
    awful.tag({ "VOYAGER", "CASE", "BB-8", "T-800" }, s, awful.layout.tile)
    end
    mytasklist = awful.widget.tasklist {
    screen   = screen.primary,
    filter   = awful.widget.tasklist.filter.focused,
    style    = {
        shape       =   Wdt_shape,
        bg_focus    =   Wdt_bg,
        align       =  'center'
    },
    layout   = {
        spacing = 5,
        max_widget_size = awful.screen.focused().geometry.width * 0.13,
        layout  = wibox.layout.flex.horizontal
    },
    widget_template = {
        {
            {
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 10,
            right = 10,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
    },
}
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end)))
    -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
        screen  = s,
        style = {
            shape		= Wdt_shape,
        },
            layout	= {
                layout = wibox.layout.fixed.horizontal,
                spacing = 5,
            },
            filter  = awful.widget.taglist.filter.all,
            buttons = awful.button({ }, 1, function(t) t:view_only() end)
    }

end)
return tags
