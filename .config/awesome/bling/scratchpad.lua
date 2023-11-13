local awful = require('awful')
local bling = require('modules.bling')
local rubato = require('modules.rubato')


local scratch_width = awful.screen.focused().geometry.width * 0.8
local scratch_height = awful.screen.focused().geometry.height * 0.8

-- These are example rubato tables. You can use one for just y, just x, or both.
-- The duration and easing is up to you. Please check out the rubato docs to learn more.
local anim_y = rubato.timed {
    pos = 450,
    rate = 60,
    easing = rubato.quadratic,
    intro = 0,
    duration = 0.5,
    awestore_compat = true -- This option must be set to true.
}

local anim_x = rubato.timed {
    pos = -3850,
    rate = 60,
    easing = rubato.quadratic,
    intro = 0,
    duration = 0.5,
    awestore_compat = true -- This option must be set to true.
}

local pulse_scratch = bling.module.scratchpad {
   command = 'kitty --class scpul pulsemixer',
   rule = { instance = 'scpul'},
   sticky = false,
   autoclose = true,
   floating = true,
   geometry = {x=scratch_width / 4, y=scratch_height / 4, height=scratch_height * 6 / 8, width=scratch_width * 6 / 8},
   reapply = true,
   dont_focus_before_close = false,
   --rubato = {x = anim_x, y = anim_y},
}
awesome.connect_signal("scratch::pulse",function()pulse_scratch:toggle() end)

local lf_scratch = bling.module.scratchpad {
   command = 'kitty --class sclf lf',
   rule = { instance = 'sclf'},
   sticky = false,
   autoclose = true,
   floating = true,
   geometry = {x=scratch_width / 8, y=scratch_height / 8, height=scratch_height, width=scratch_width},
   reapply = true,
   dont_focus_before_close = false,
   --rubato = {x = anim_x, y = anim_y},
}
awesome.connect_signal("scratch::lf",function()lf_scratch:toggle() end)
