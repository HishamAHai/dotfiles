local gears = require('gears')
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local bling = require('modules.bling')
local playerctl = bling.signal.playerctl.lib()

local art = wibox.widget {
   --image = 'default_image.png',
   resize = true,
   forced_height = dpi(80),
   forced_width = dpi(80),
   widget = wibox.widget.imagebox
}

local name_widget = wibox.widget {
   markup = 'No Player',
   align = 'center',
   valign = 'center',
   widget = wibox.widget.textbox
}

local title_widget = wibox.widget {
   markup = 'Nothing Playing',
   align = 'center',
   valign = 'center',
   widget = wibox.widget.textbox
}

local artist_widget = wibox.widget {
   markup = 'Nothing Playing',
   align = 'center',
   valign = 'center',
   widget = wibox.widget.textbox
}

playerctl:connect_signal("metada",
			 function(_, title, artist, album_path, album, new, player_name)
			    art: set_image(gears.surface.load_uncached(album_path))
			    name_widget:set_markup_silently(player_name)
			    title_widget:set_markup_silently(title)
			    artist_widget:set_markup_silently(artist)
			    end)
