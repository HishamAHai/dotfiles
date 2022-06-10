-- ======================= Imports ===================================
local naughty = require('naughty')
local beautiful = require('beautiful')
local gears = require('gears')
local awful = require('awful')
local dpi = beautiful.xresources.apply_dpi
local screen_width = awful.screen.focused().geometry.width

-- =================== Theme Definitions =============================
naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(92)
naughty.config.defaults.resize_strategy = 'center'
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 10
naughty.config.defaults.margin = dpi(10)
naughty.config.defaults.border_color = beautiful.border_focus
naughty.config.defaults.border_width = dpi(0)
naughty.config.defaults.position = 'bottom_right'
naughty.config.defaults.font = 'Inter 10'
naughty.config.defaults.width = screen_width * 0.16
naughty.config.defaults.max_width = screen_width * 0.16
naughty.config.defaults.shape = function(cr, w, h)
   gears.shape.rounded_rect(cr, w, h, dpi(6))
end

naughty.config.padding = dpi(4)
naughty.config.spacing = dpi(4)
naughty.config.icon_dirs = {
   '/usr/share/icons/Papirus',
   '/usr/share/icons/Tela-dark',
   '/usr/share/pixmaps/'
}
naughty.config.icon_formats = {'png', 'svg'}

-- Timeouts
naughty.config.presets.low.timeout = 8
naughty.config.presets.critical.timeout = 0

naughty.config.presets.normal = {
   fg = beautiful.fg_normal,
   bg = beautiful.bg_normal,
}

naughty.config.presets.low = {
   fg = beautiful.fg_normal,
   bg = beautiful.bg_normal,
}

naughty.config.presets.critical = {
   fg = '#ffffff',
   bg = '#ff0000',
   timeout = 0
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical


-- ======================= Error Handling ============================
if awesome.startup_errors then
   naughty.notify({
      preset = naughty.config.presets.critical,
      title = 'Oops, there were errors during startup!',
      text = awesome.startup_errors
   })
end

do
   local in_error = false
   awesome.connect_signal(
      'debug::error',
      function(err)
         if in_error then
            return
         end
         in_error = true

         naughty.notify({
            preset = naughty.config.presets.critical,
            title = 'Oops, an error happened!',
            text = tostring(err)
         })
         in_error = false
      end
   )
end

