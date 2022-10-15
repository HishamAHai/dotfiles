local apps = require('apps')
local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup')
local icon_dir = '/usr/share/icons/Papirus/64x64/apps/'
local config_dir = gears.filesystem.get_configuration_dir()
local screen_width = awful.screen.focused().geometry.width

myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, icon_dir .. 'system-config-keyboard.svg' },
   { "restart", awesome.restart, icon_dir .. 'system-reboot.svg' },
   { "quit", function() awesome.quit() end, icon_dir .. 'system-log-out.svg'},
}

applications = {
   { "Browser", apps.browser, icon_dir .. 'qutebrowser.svg' },
   { "File Manager", function() awful.spawn.with_shell('pcmanfm') end, icon_dir .. 'system-file-manager.svg' },
   { "Editor", function() awful.spawn.with_shell('geany') end, icon_dir .. 'geany.svg' },
   { "Spotify", apps.mplayer, icon_dir .. 'spotify.svg' },
   { "Inkscape", function() awful.spawn.with_shell('inkscape') end, icon_dir .. 'inkscape.svg' },
   { "MPV", function() awful.spawn.with_shell('mpv') end, icon_dir .. 'mpv.svg' },
   { "Nitrogen", function() awful.spawn.with_shell('nitrogen') end, icon_dir .. 'nitrogen.svg' },
   { "Power Settings", function() awful.spawn.with_shell('xfce4-power-manager-settings') end, icon_dir .. 'xfce4-power-manager-settings.svg' },
}

mymainmenu = awful.menu(
{
    items = {
        { "Applications", applications, icon_dir .. 'app-launcher.svg' },
        { "Terminal Emulator", apps.terminal, icon_dir .. 'terminal.svg' },
        { "Awesome", myawesomemenu, config_dir .. 'icons/dove.svg' },
        { "Logout", function() awful.spawn.with_shell('killall Xorg') end, icon_dir .. 'system-log-out.svg' },
        { "Reboot", function() awful.spawn.with_shell('systemctl reboot') end, icon_dir .. 'system-reboot.svg' },
        { "Shutdown", function() awful.spawn.with_shell('shutdown -h now') end, icon_dir .. 'system-shutdown.svg' },
    }
}
)
mymainmenu.wibox.shape = function (cr, w, h)
    gears.shape.rounded_rect(cr, w, h, screen_width * 0.003)
end
mymainmenu.wibox.bg = beautiful.bg_normal

awful.menu.original_new = awful.menu.new
function awful.menu.new(...)
    local ret = awful.menu.original_new(...)
    ret.wibox.shape = function (cr, w, h)
        gears.shape.rounded_rect(cr, w, h, screen_width * 0.003)
    end
    ret.wibox.bg = beautiful.bg_normal
    return ret
end
