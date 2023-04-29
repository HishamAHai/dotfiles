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
    elseif s.index == 2 then
    awful.tag({ "VOYAGER", "CASE", "BB-8", "T-800" }, s, awful.layout.suit.tile)
    else
    awful.tag.add('',{
            name                = 'VISION',
            id                  = '1',
            screen              = s,
			layout              = awful.layout.suit.tile,
			gap_single_client	= true,
			gap                 = 0,
			selected		    = true
			}
		)
    awful.tag.add('',{
            name                = 'R2D2',
            id                  = '1',
            screen              = s,
			layout              = awful.layout.suit.tile,
			gap_single_client	= true,
			gap                 = 0,
			}
		)
    end
    mytasklist = awful.widget.tasklist {
    screen     = screen.primary,
    filter     = awful.widget.tasklist.filter.allscreen,
    buttons    = awful.button({ }, 1, function(c)
        if   c == client.focus then
             c.minimized = true
        else
            c:emit_signal(
            'request::activate',
            'mytasklist',
            {
                raise = true,
                switchtotag = true,
                selected = true
            }
            )
        end
    end),
    style    = {
        shape       =   Wdt_shape,
        align       =  'center'
    },
    layout   = {
        spacing = 5,
        max_widget_size = awful.screen.focused().geometry.width * 0.07,
        layout  = wibox.layout.flex.horizontal
    },
widget_template = {
    {
        {
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                valgin = 'center',
                haligh = 'center',
                widget  = wibox.container.place,
            },
            {
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                left = 5,
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        margins = 5,
        widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background,
    create_callback = function(self, c)
        self:get_children_by_id('clienticon')[1].client = c
    end,
},
}
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end)))
    -- Create a taglist widget
        s.hortaglist = awful.widget.taglist {
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

        s.vertaglist = awful.widget.taglist {
        screen  = s,
        style = {
            shape		= Wdt_shape,
        },
            layout	= {
                layout = wibox.layout.flex.vertical,
                spacing = 5,
            },
            filter  = awful.widget.taglist.filter.all,
            buttons = awful.button({ }, 1, function(t) t:view_only() end),
            widget_template = {
                {
                    {
                        {
                            {
                                id = 'text_role',
                                widget = wibox.widget.textbox
                            },
                            direction = 'east',
                            widget = wibox.container.rotate
                        },
                        fill_horizontal = true,
                        fill_vertical = true,
                        widget = wibox.container.place,
                    },
                    layout = wibox.layout.fixed.vertical,
                },
                id = 'background_role',
                widget = wibox.container.background
            },
    }

end)
return tags
