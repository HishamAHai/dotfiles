local awful = require('awful')
local xresources = require('beautiful.xresources')
local beautiful =   require('beautiful')
local dpi = xresources.apply_dpi
local gears = require('gears')
local watch = require('awful.widget.watch')
local wibox = require('wibox')



local allah_names = {}
local GET_QUOTES_CMD = [[bash -c 'echo -e $(</home/hisham/.local/share/allah_names.json)']]
local timeout = 1800

allah_names_widget = wibox.widget {
    {
        {
            id      =   'text',
            font    =   'Open Sans 11',
            align   =   'center',
            valign  =   'center',
            widget  =   wibox.widget.textbox
        },
        margins =   screen_width * 0.0015,
        widget  =   wibox.container.margin
    },
    bg = beautiful.bg_empty,
    shape = big_wdt_shape,
    widget = wibox.container.background,
}

local function update_widget(widget,stdout)
    widget:get_children_by_id('text')[1]:set_text(stdout)
end

awful.screen.connect_for_each_screen(function(s)
    if s.index == 1 then
    s.allah_names= awful.wibar(
    {
        position = 'left',
        screen = s,
        width = screen_width * 0.078,
        height = screen_height * 0.11,
        bg = ('#0000'),
        opacity = 1,
        --shape = bar_wdt_shape
    }
    )

    s.allah_names:setup{
        {
            allah_names_widget,
            margins = screen_height * 0.003,
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        shape = big_wdt_shape,
        bg = beautiful.bg_normal
    }
    end
end)

watch(GET_QUOTES_CMD,timeout,update_widget,allah_names_widget)
return allah_names
