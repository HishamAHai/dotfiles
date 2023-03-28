local awful         =   require('awful')
local beautiful     =   require('beautiful')
local gears         =   require('gears')
local config_dir    =   gears.filesystem.get_configuration_dir()
local wibox         =   require('wibox')
local xresources    =   require('beautiful.xresources')
local dpi           =   xresources.apply_dpi

local watermark = {}
watermark_widget = wibox.widget {
    {
        {
            image = config_dir .. '/icons/drawing.svg',
            resize = true,
            opacity = 0.4,
            widget = wibox.widget.imagebox
        },
        margins = 0,
        widget = wibox.container.margin
    },
    widget = wibox.container.background
}

awful.screen.connect_for_each_screen(function(s)
    s.watermark = awful.wibar(
    {
    position = 'right',
    screen = s,
    width = 398.5,
    height = 109.75,
    type = 'desktop',
    bg = '#0000',
}
    )
    s.watermark:setup{
        watermark_widget,
        widget = wibox.container.background,
        bg = '#0000',
    }
end)

return watermark
