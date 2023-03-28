local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')

local Packages_widget = {}
local screen_width = awful.screen.focused().geometry.width

PKG_CMD = [[ bash -c 'packages.sh']]
timeout = 7200

pkg_widget = wibox.widget {
    {
        {
            id = 'pkg_wdt',
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    --bg = Wdt_bg,
    fg = beautiful.fg_urgent,
    forced_width = screen_width * 0.04,
    shape = Wdt_shape,
    widget = wibox.container.background
}
pkg_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e checkupdates')
    end
        end)

function Update_pkg_widget(widget,stdout)
    widget:get_children_by_id('pkg_wdt')[1]:set_text(stdout)
end

watch(PKG_CMD,timeout,Update_pkg_widget,pkg_widget)

return Packages_widget
