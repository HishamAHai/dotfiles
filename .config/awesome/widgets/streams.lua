local awful = require('awful')
local xresources = require('beautiful.xresources')
local beautiful =   require('beautiful')
local dpi = xresources.apply_dpi
local gears = require('gears')
local watch = require('awful.widget.watch')
local wibox = require('wibox')

local streams = {}
local GET_STREAMS_CMD = 'cat /mnt/nasbkup/models'
local timeout = 120

streams_widget = wibox.widget {
    id      =   'text',
    font    =   'FantasqueSansM Nerd Font Propo 15',
    opacity =   0.85,
    align   =   'left',
    valign  =   'bottom',
    widget  =   wibox.widget.textbox
}

local function update_widget(widget,stdout)
    widget:get_children_by_id('text')[1]:set_text(stdout)
end

awful.screen.connect_for_each_screen(function(s)
    if s.index == 1 then
        s.streams= awful.wibar(
        {
            screen = s,
            width = screen_width * 0.13,
            height = screen_height * 1,
            --type = 'desktop',
            bg = '#0000',
        }
        )

        s.streams:setup{
            streams_widget,
            widget = wibox.container.background,
            bg = '#0000',
        }
    end
end)

watch(GET_STREAMS_CMD,timeout,update_widget,streams_widget)
return streams
