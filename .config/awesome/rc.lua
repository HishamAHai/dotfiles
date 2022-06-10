-- Calls
pcall(require, 'luarocks.loader')
local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
require('awful.autofocus')
require('menubar')
require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')
local bling = require('modules.bling')

-- Theme
local config_dir = gears.filesystem.get_configuration_dir()
beautiful.init(config_dir .. "themes/theme.lua")

-- Keybindings
require('keys')

-- UI components
require('ui.tags')
require('ui.bottom_bar')
require('ui.Menu')
require('ui.notifications')
require('ui.rules')

-- Bling modules
require('bling.scratchpad')
require('bling.switcher')
require('bling.playerctl')

-- Default layouts (overwritten in tags module)
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
}

-- Reduce memory usage
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
