local awful = require('awful')
local xresources = require('beautiful.xresources')
local beautiful =   require('beautiful')
local dpi = xresources.apply_dpi
local gears = require('gears')
local watch = require('awful.widget.watch')
local wibox = require('wibox')



local quotes = {}
local GET_QUOTES_CMD = 'shuf -n 1 /home/hisham/.local/share/quotes'
local timeout = 1800

quotes_widget = wibox.widget {
    {
        {
            id      =   'text',
            font    =   'Red Hat Display Medium 12',
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
    s.quotes= awful.wibar(
    {
        position = 'left',
        screen = s,
        width = screen_width * 0.085,
        height = screen_height * 0.11,
        bg = ('#0000'),
        opacity = 1,
        --shape = bar_wdt_shape
    }
    )

    s.quotes:setup{
        {
            quotes_widget,
            margins = screen_height * 0.003,
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        shape = big_wdt_shape,
        bg = beautiful.bg_normal
    }
    end
end)

watch(GET_QUOTES_CMD,timeout,update_widget,quotes_widget)
return quotes
