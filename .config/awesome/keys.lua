-- Standard awesome library
local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local apps = require('apps')
local xrandr=require('xrandr')
local volume_widget = require("widgets.volume-widget.volume")
local brightness_widget = require("widgets.brightness-widget.brightness")
local bling=require('modules.bling')

modkey = 'Mod4'
altkey = 'Mod1'
raltkey = 'Mod5'

local keys = {}


-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
   if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
      if direction == "up" then
         c:relative_move(0, 0, 0, -floating_resize_amount)
      elseif direction == "down" then
         c:relative_move(0, 0, 0, floating_resize_amount)
      elseif direction == "left" then
         c:relative_move(0, 0, -floating_resize_amount, 0)
      elseif direction == "right" then
         c:relative_move(0, 0, floating_resize_amount, 0)
      end
   else
      if direction == "up" then
         awful.client.incwfact(-tiling_resize_factor)
      elseif direction == "down" then
         awful.client.incwfact(tiling_resize_factor)
      elseif direction == "left" then
         awful.tag.incmwfact(-tiling_resize_factor)
      elseif direction == "right" then
         awful.tag.incmwfact(tiling_resize_factor)
      end
   end
end

globalkeys = gears.table.join(
    -- ================= General awesome keybindings ===========================
    awful.key({ modkey,           }, 's',      hotkeys_popup.show_help,
              {description='show help', group='awesome'}),

    awful.key({ modkey, 'Shift' }, 'r', awesome.restart,
              {description = 'reload awesome', group = 'awesome'}),

    awful.key({ modkey, 'Shift'   }, 'q', awesome.quit,
              {description = 'quit awesome', group = 'awesome'}),

    -- ================= Switching between tags ===========================
    awful.key({ modkey,           }, 'Left',   awful.tag.viewprev,
              {description = 'view previous', group = 'tag'}),

    awful.key({ modkey,           }, 'Right',  awful.tag.viewnext,
              {description = 'view next', group = 'tag'}),

    -- ================= Switching between clients ===========================
    awful.key({ modkey,           }, 'j', function ()
            awful.client.focus.byidx( 1) end,
        {description = 'focus next by index', group = 'client'}),
    awful.key({ modkey,           }, 'k', function ()
            awful.client.focus.byidx(-1) end,
        {description = 'focus previous by index', group = 'client'}),
        
    -- ================= Switching between screens ===========================
    awful.key({ modkey, altkey }, 'j', function ()
            awful.screen.focus_bydirection('left') end,
        {description = 'focus screen to the left', group = 'screen'}),
    awful.key({ modkey, altkey }, 'k', function ()
            awful.screen.focus_bydirection('right') end,
        {description = 'focus screen to the right', group = 'screen'}),

    -- ================= Layout control keybindings ===========================
    awful.key({ modkey, 'Shift'  }, 'j',        function () awful.client.swap.global_bydirection(  'left')    end,
              {description = 'swap with next client by index',          group = 'layout'}),

    awful.key({ modkey, 'Shift'  }, 'k',        function () awful.client.swap.global_bydirection( 'right')    end,
              {description = 'swap with previous client by index',      group = 'layout'}),

   awful.key({ modkey, 'Shift'   }, 'h',        function () awful.tag.incnmaster( 1, nil, true) end,
              {description = 'increase the number of master clients',   group = 'layout'}),

    awful.key({ modkey, 'Shift'  }, 'l',        function () awful.tag.incnmaster(-1, nil, true) end,
              {description = 'decrease the number of master clients',   group = 'layout'}),

    awful.key({ modkey, 'Control'}, 'Left',     function () awful.tag.incncol( 1, nil, true)    end,
              {description = 'increase the number of columns',          group = 'layout'}),

    awful.key({ modkey, 'Control'}, 'Right',    function () awful.tag.incncol(-1, nil, true)    end,
              {description = 'decrease the number of columns',          group = 'layout'}),

    awful.key({ modkey,          }, 'space',    function () awful.layout.inc( 1)                end,
              {description = 'select next',                             group = 'layout'}),

    awful.key({ modkey, 'Shift'  }, 'space',    function () awful.layout.inc(-1)                end,
              {description = 'select previous',                         group = 'layout'}),

-- Move/Resize a flaoting client in a given direction
    awful.key({ modkey, 'Control' }, 'j', function() client.focus:relative_move(0,10,0,0) end,
              {description = 'Move the window upwards ', group = 'client'}),
    awful.key({ modkey, 'Control' }, 'k', function() client.focus:relative_move(0,-10,0,0) end,
              {description = 'Move the window downwards ', group = 'client'}),
    awful.key({ modkey, 'Control' }, 'h', function() client.focus:relative_move(-10,0,0,0) end,
              {description = 'Move the window to the left ', group = 'client'}),
    awful.key({ modkey, 'Control' }, 'l', function() client.focus:relative_move(10,0,0,0) end,
              {description = 'Move the window to the right ', group = 'client'}),
    awful.key({ modkey, 'Control', 'Shift' }, 'l', function() client.focus:relative_move(0,0,10,0) end,
              {description = 'Increase window width ', group = 'client'}),
    awful.key({ modkey, 'Control', 'Shift' }, 'h', function() client.focus:relative_move(0,0,-10,0) end,
              {description = 'Decrease window width ', group = 'client'}),
    awful.key({ modkey, 'Control', 'Shift' }, 'k', function() client.focus:relative_move(0,0,0,-10) end,
              {description = 'Decrease window height ', group = 'client'}),
    awful.key({ modkey, 'Control', 'Shift' }, 'j', function() client.focus:relative_move(0,0,0,10) end,
              {description = 'Increase window height ', group = 'client'}),
    awful.key({ modkey           }, 'y',        awful.placement.centered ,
              {description = 'centering client',        group = 'layout'}),

    -- Resize client keybindings
    awful.key({ modkey,           }, 'l',     function () awful.tag.incmwfact( 0.05)          end,
              {description = 'increase master width factor', group = 'layout'}),

    awful.key({ modkey,           }, 'h',     function () awful.tag.incmwfact(-0.05)          end,
              {description = 'decrease master width factor', group = 'layout'}),

    -- Gap resizing keybindings
	awful.key({ altkey }, '.',
	function ()
		awful.tag.incgap(2,null)
	end,
	{description = 'Increase gap size', group = 'layout'}),

	awful.key({ altkey }, ',',
	function ()
		awful.tag.incgap(-2,null)
	end,
	{description = 'Decrease gap size', group = 'layout'}),

    -- ================= Programs launching keybindings ===========================
    awful.key({ modkey,           }, 'Return', function () awful.spawn(apps.terminal) end,
              {description = 'open a terminal', group = 'launcher'}),

    awful.key({ modkey , altkey}, 'o', function () awful.spawn.with_shell('QT_SCALE_FACTOR=0.75 QT_AUTO_SCREEN_SCALE_FACTOR=0 com.obsproject.Studio') end,
              {description = 'Launch obs studio', group = 'productivity'}),

    awful.key({ modkey , 'Shift'}, 'd', function () awful.spawn('resolve') end,
              {description = 'Launch Davinci Resolve', group = 'productivity'}),

    awful.key({ modkey , }, 'v', function () awful.spawn('virt-manager') end,
              {description = 'Launch virt-manager', group = 'productivity'}),

    awful.key({ modkey , raltkey}, 'g', function () awful.spawn('org.gimp.GIMP') end,
              {description = 'Launch Gimp', group = 'productivity'}),

    awful.key({ modkey, altkey}, 'i', function () awful.spawn('org.inkscape.Inkscape') end,
              {description = 'Launch inkscape', group = 'productivity'}),

    awful.key({ modkey, altkey}, 'p', function () awesome.emit_signal("scratch::pulse") end,
              {description = 'Launch pulsemixer', group = 'hotkeys'}),
    --awful.key({ modkey            }, 'f',     function () awesome.emit_signal("scratch::lf") end,
    --          {description = 'open lf with previews', group = 'launcher'}),
    awful.key({ modkey            }, 'f',     function () awful.spawn(apps.fmanager) end,
              {description = 'open file manager', group = 'launcher'}),

    awful.key({modkey,     'Shift'}, 'a',function () awful.spawn('alacritty') end,
              {description = 'open alacritty terminal', group = 'launcher'}),

    awful.key({ modkey,           }, 'e', function () awful.spawn('emacsclient -c') end,
              {description = 'Run a new instance of emacs client', group = 'launcher'}),

    awful.key({ modkey,           }, 'c', function () awful.spawn('firefox.sh') end,
              {description = 'Navigate the web with chromium', group = 'launcher'}),

    awful.key({ modkey,           }, 'q', function () awful.spawn('qutebrowser') end,
              {description = 'spawn qutebrowser', group = 'launcher'}),

    awful.key({                   }, 'XF86Search',     function () awful.spawn(apps.launcher) end,
              {description = 'spawn the launcher', group = 'launcher'}),

    awful.key({ modkey            }, 'p',     function () awful.spawn(apps.launcher) end,
              {description = 'spawn the launcher', group = 'launcher'}),

    awful.key({ modkey            }, 'r',     function () awful.spawn(apps.rofi) end,
              {description = 'spawn the launcher', group = 'launcher'}),

    awful.key({ modkey, 'Shift'   }, 'f',     function () awful.spawn.with_shell('dmenufm') end,
              {description = 'Open dmenufm', group = 'launcher'}),

    awful.key({ modkey            }, 'n',     function () awful.spawn.with_shell(apps.wallpaper) end,
              {description = 'Change the wallpaper', group = 'launcher'}),

    awful.key({modkey,	    altkey}, 'h', function() awful.spawn.with_shell('$TERMINAL --hold htop') end,
    	      {description = 'htop', group = 'launcher'}),

    awful.key({modkey,	    altkey},		'n', function() awful.spawn.with_shell('$TERMINAL --hold neofetch') end,
    	      {description = 'neofetch', group = 'launcher'}),

    -- ================= Programs killing keybindings ===========================
    awful.key({ modkey, 'Shift' }, 'v', function () awful.spawn.with_shell('kill -9 $(pgrep vlc)') end,
              {description = 'kill vlc', group = 'launcher'}),

    awful.key({ modkey, 'Shift' }, 'm', function () awful.spawn.with_shell('kill -9 $(pgrep kodi)') end,
              {description = 'kill kodi', group = 'launcher'}),
awful.key({ modkey, 'Shift' }, 'u', function () awful.spawn.with_shell('kill -9 $(pgrep uget-gtk)') end,
              {description = 'kill uget', group = 'launcher'}),

    awful.key({ modkey, 'Shift' }, 't', function () awful.spawn.with_shell('kill -9 $(pgrep qbittorrent)') end,
              {description = 'kill qbittorrent', group = 'launcher'}),

    awful.key({ modkey, 'Shift' }, 'o', function () awful.spawn.with_shell('spt_k.sh') end,
              {description = 'kill spotify', group = 'launcher'}),

    -- ================= Screenshoot keybinging ===========================
	awful.key({modkey, 'Shift'},'s',function() awful.spawn.with_shell(apps.screenshot) end,
	{description = 'Take a screenshot', group = 'hotkeys'}),

    -- ================= Hotkeys (using multimedia keys) ===========================
    
--awful.key({}, 'XF86AudioRaiseVolume', volume_widget.raise,
awful.key({}, 'XF86AudioRaiseVolume', function() awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+') end ,
 {description = "Volume increase", group = "hotkeys"}),

--awful.key({},'XF86AudioLowerVolume', volume_widget.lower,
awful.key({}, 'XF86AudioLowerVolume', function() awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-') end,
 {description = "Volume decrease", group = "hotkeys"}),

--awful.key({},'XF86AudioMute', volume_widget.toggle,
awful.key({}, 'XF86AudioMute', function() awful.spawn('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle') end,
 {description = "Volume mute", group = "hotkeys"}),

--awful.key({altkey}, 'x', volume_widget.raise,
-- {description = "Volume increase", group = "hotkeys"}),
--
--awful.key({altkey},'z', volume_widget.lower,
-- {description = "Volume decrease", group = "hotkeys"}),
--
--awful.key({altkey},'c', volume_widget.toggle,
-- {description = "Volume mute", group = "hotkeys"}),

awful.key({}, 'XF86MonBrightnessDown', function () brightness_widget:dec() end, {description = "decrease brightness", group = "hotkeys"}),

awful.key({}, 'XF86MonBrightnessUp', function () brightness_widget:inc() end, {description = "increase brightness", group = "hotkeys"}),

    awful.key({ }, 'XF86AudioNext', function () awful.spawn('playerctl next') end,
              {description = 'Playerctl next song', group = 'hotkeys'}),

    awful.key({ }, 'XF86AudioPrev', function () awful.spawn('playerctl previous') end,
              {description = 'Playerctl previous song', group = 'hotkeys'}),

    awful.key({ }, 'XF86AudioPlay', function () awful.spawn('playerctl play-pause') end,
              {description = 'Playerctl play-pause', group = 'hotkeys'}),

    awful.key({ }, 'XF86AudioNext', function () awful.spawn('mpc next') end,
              {description = 'mpc next song', group = 'hotkeys'}),

    awful.key({ }, 'XF86AudioPrev', function () awful.spawn('mpc prev') end,
              {description = 'mpc previous song', group = 'hotkeys'}),

    awful.key({ }, 'XF86AudioPlay', function () awful.spawn('mpc toggle') end,
              {description = 'mpc play-pause', group = 'hotkeys'}),

    -- ================= Hotkeys (using modifier key) ===========================
    awful.key({ altkey}, 'd', function () awful.spawn('playerctl next') end,
              {description = 'Jump to the next song', group = 'hotkeys'}),

    awful.key({ altkey}, 'a', function () awful.spawn('playerctl previous') end,
              {description = 'Jump to the previous song', group = 'hotkeys'}),

    awful.key({ altkey}, 's', function () awful.spawn('playerctl play-pause') end,
              {description = 'Play/Pause current song', group = 'hotkeys'}),

    awful.key({ altkey, }, 'm', function () awful.spawn.with_shell('mpv --cache=yes $(xclip -o -selection clipboard)') end,
              {description = 'Play the copied link with mpv w caching', group = 'hotkeys'}),

    awful.key({ altkey, }, 'r', function () awful.spawn.with_shell('record.sh $(xclip -o -selection clipboard)') end,
              {description = 'Play and record the copied link with mpv', group = 'hotkeys'}),

    awful.key({ altkey, 'Control'}, 's', function () awful.spawn.with_shell('mpvWatch.sh play') end,
              {description = 'Play the copied link with mpv w caching', group = 'hotkeys'}),

    awful.key({ altkey, 'Control'}, 'q', function () awful.spawn.with_shell('zathura /home/hisham/Documents/Quran_7afs.pdf') end,
              {description = 'Read al-quraan alkareem', group = 'hotkeys'}),
    -- ================= dmenu scripts ===========================
    awful.key({ raltkey }, '1', function () awful.spawn.with_shell('dmenu_url.sh') end,
              {description = 'dmenu script to surf the web', group = 'dmenu'}),

    awful.key({ raltkey }, '2', function () awful.spawn.with_shell('dmenu_webSearch.sh') end,
              {description = 'dmenu script to search the web', group = 'dmenu'}),

    awful.key({ raltkey }, '3', function () awful.spawn.with_shell('dmenu_kill.sh') end,
              {description = 'dmenu script to kill a process', group = 'dmenu'}),

    awful.key({ raltkey }, '4', function () awful.spawn.with_shell('nordvpn.sh') end,
              {description = 'dmenu script to switch the vpn', group = 'dmenu'}),

    awful.key({ raltkey }, '5', function () awful.spawn.with_shell('emojis.sh') end,
              {description = 'dmenu script to select an emoji', group = 'dmenu'}),

    awful.key({ raltkey }, '6', function () awful.spawn.with_shell('configs.sh') end,
              {description = 'dmenu script to edit confgiration files', group = 'dmenu'}),

    awful.key({ raltkey, }, '7', function () awful.spawn.with_shell('movies.sh') end,
              {description = 'Play a random movie', group = 'dmenu'}),

    awful.key({ raltkey }, 'w', function () awful.spawn.with_shell('mpvWatch.sh list') end,
              {description = 'Select and Play video', group = 'dmenu'}),

    awful.key({ raltkey }, 's', function () awful.spawn.with_shell('dmenu_services.sh') end,
              {description = 'dmenu script to Start/Stop systemd services', group = 'dmenu'}),

    awful.key({ modkey }, 't', function () awful.spawn.with_shell('awesome_theme.sh') end,
              {description = 'Toggle dark or light theme', group = 'dmenu'}),

    awful.key({ modkey,           }, 'r',     function () awful.spawn.with_shell('$TERMINAL scale.sh') end,
              {description = 'Change Screen resolution', group = 'dmenu'}),

--    awful.key({ 'Control' }, 'p', function () awful.spawn.with_shell('passmenu') end,
--              {description = 'spawn pass program', group = 'dmenu'}),

    awful.key({ raltkey }, 'Escape', function() awful.spawn.with_shell('shutdown.sh') end,
        {description = 'Power options', group = 'dmenu'}),

    -- Increase number of clients in master
    awful.key({ modkey, 'Shift'   }, 'h',     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = 'increase the number of master clients', group = 'layout'}),

    -- Decrease number of clients in master
    awful.key({ modkey, 'Shift'   }, 'l',     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = 'decrease the number of master clients', group = 'layout'}),

    -- =======================================
    -- Cycle layouts
    -- =======================================
    awful.key({ modkey,           }, 'space', function () awful.layout.inc( 1)                end,
              {description = 'select next', group = 'layout'}),
    awful.key({ modkey, 'Shift'   }, 'space', function () awful.layout.inc(-1)                end,
              {description = 'select previous', group = 'layout'}),

     awful.key({altkey, }, 'Tab', function() awesome.emit_signal(
         'bling::window_switcher::turn_on')
     end,
     {description = "Window Switcher", group = "bling"})

   -- =========================================
   -- CLIENT RESIZING
   -- =========================================

    --awful.key({modkey, 'Control'}, 'h',       function(c) resize_client(client.focus, 'left') end),

    --awful.key({modkey, 'Control'}, 'j',       function(c) resize_client(client.focus, 'down') end),

    --awful.key({ modkey, 'Control' }, 'k',     function(c) resize_client(client.focus, 'up') end),

    --awful.key({modkey, 'Control'}, 'l',       function(c) resize_client(client.focus, 'right') end)
    )

clientkeys = gears.table.join(
    awful.key({ modkey, 'Shift'   }, 'c',      function (c) c:kill()                         end,
              {description = 'close', group = 'client'}),
    awful.key({ modkey, 'Control' }, 'space',  awful.client.floating.toggle                     ,
              {description = 'toggle floating', group = 'client'}),
    awful.key({ modkey, 'Control' }, 'm',       function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = '(un)maximize', group = 'client'}),
    awful.key({ modkey, 'Control' }, 'Return', function (c) c:swap(awful.client.getmaster()) end,
              {description = 'move to master', group = 'client'})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, '#' .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = 'view tag #'..i, group = 'tag'}),
        -- Toggle tag display.
        awful.key({ modkey, 'Control' }, '#' .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = 'toggle tag #' .. i, group = 'tag'}),
        -- Move client to tag.
        awful.key({ modkey, 'Shift' }, '#' .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = 'move focused client to tag #'..i, group = 'tag'}),
        -- Toggle tag on focused client.
        awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = 'toggle focused client on tag #' .. i, group = 'tag'})
    )
end

-- ================= Tags are clickable ===========================
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal('request::activate', 'mouse_click', {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal('request::activate', 'mouse_click', {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal('request::activate', 'mouse_click', {raise = true})
        awful.mouse.client.resize(c)
    end)
)
-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 1, function () mymainmenu:hide() end)
))
-- }}}

-- ==================== Set keys ====================================
root.keys(globalkeys)

return keys
