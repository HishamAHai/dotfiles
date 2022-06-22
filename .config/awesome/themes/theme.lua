local awful = require('awful')
local gears = require('gears')
local config_dir = gears.filesystem.get_configuration_dir()
local colorschemes_dir     =   os.getenv('HOME') .. '/.config/awesome/themes/colorschemes/'
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local Themes_path = config_dir .. '/awesome/themes/'

local theme = {}

-- Font
theme.font          =   'Open Sans 11'

-- Define 16 colors base
local ColorScheme = {}
for line in io.lines(colorschemes_dir .. 'Material_Dark' .. '.conf') do 
    table.insert(ColorScheme, line)
end

theme.color2                      =   ColorScheme[7]
theme.color3                      =   ColorScheme[9]
theme.color4                      =   ColorScheme[11]
theme.color5                      =   ColorScheme[13]
theme.color6                      =   ColorScheme[15]
theme.color7                      =   ColorScheme[17]
theme.color9                      =   ColorScheme[6]
theme.color11                     =   ColorScheme[10]
theme.color12                     =   ColorScheme[12]
theme.color13                     =   ColorScheme[14]
theme.color14                     =   ColorScheme[16]

theme.bg_normal             =   ColorScheme[1] --.. 'd0'
theme.fg_normal             =   ColorScheme[2]
theme.bg_empty              =   ColorScheme[18] .. '2f'
theme.fg_urgent             =   ColorScheme[5]
theme.fg_occupied           =   ColorScheme[5]
theme.taglist_fg_occupied   =   ColorScheme[7]
theme.taglist_bg_occupied   =   nil
theme.taglist_bg_empty      =   nil
theme.taglist_bg_focus      =   theme.fg_occupied
theme.bg_systray            =   theme.bg_normal

-- Border colors
theme.border_width          =   dpi(1)
theme.border_normal         =   theme.bg_normal
theme.border_focus          =   theme.fg_occupied

-- tooltip
theme.tooltip_border_color  =   theme.border_focus
theme.tooltip_bg            =   theme.bg_normal
theme.tooltip_fg            =   theme.fg_normal
theme.tooltip_font          =   theme.font
theme.tooltip_border_width  =   dpi(0)
theme.tooltip_opacity       =   0.85
theme.tooltip_align         =   'top'

-- wibar
theme.wibar_fg              =   theme.fg_normal
theme.wibar_border_width    =   dpi(0)
theme.wibar_border_color    =   theme.border_focus

-- hotkeys
theme.hotkeys_bg		        =	theme.bg_normal
theme.hotkeys_font		        =	theme.font
theme.hotkeys_fg		        =	theme.fg_normal
theme.hotkeys_border_width	    =	dpi(1)
theme.hotkeys_border_color	    =	theme.border_focus
theme.hotkeys_opacity		    =	0.85
theme.hotkeys_modifiers_fg	    =	theme.border_focus
theme.hotkeys_description_font	=	theme.font
theme.hotkeys_shape             =   function(cr, width, height) gears.shape.rounded_rect(cr, width, height, awful.screen.focused().geometry.width * 0.004) end

-- tasklist
theme.tasklist_fg_focus         =   theme.fg_normal
theme.tasklist_bg_normal        =   theme.bg_empty
theme.tasklist_disable_icon     =   true
theme.tasklist_plain_task_name  =   true
theme.tasklist_font             =   theme.font
theme.tasklist_align            =   'center'
theme.icon_theme                =   '/usr/share/icons/Papirus-Dark/48x48/apps'

theme.layout_fairh      = Themes_path..'layouts/fairhw.png'
theme.layout_fairv      = Themes_path..'layouts/fairvw.png'
theme.layout_floating   = Themes_path..'layouts/floatingw.png'
theme.layout_max        = Themes_path..'layouts/maxw.png'
theme.layout_fullscreen = Themes_path..'layouts/fullscreenw.png'
theme.layout_tilebottom = Themes_path..'layouts/tilebottomw.png'
theme.layout_tile       = Themes_path..'layouts/tilew.png'
theme.layout_spiral     = Themes_path..'layouts/spiralw.png'
theme.layout_dwindle    = Themes_path..'layouts/dwindlew.png'

-- menu
theme.menu_font         = 'Inter 12'
theme.menu_height       = dpi(20)
theme.menu_width        = dpi(160)
theme.menu_border_color = '#0000'
theme.menu_border_width = dpi(2)
theme.menu_submenu      = "ᐅ "

-- current temp
theme.temp_cold         =   ColorScheme[11]
theme.temp_norm         =   ColorScheme[9]
theme.temp_hot          =   ColorScheme[5]
theme.temp_min          =   ColorScheme[15]
theme.temp_max          =   ColorScheme[14]

theme.titlebar_bg       =   theme.border_focus
theme.titlebar_fg       =   theme.fg_normal
theme.titlebar_close_button_normal = "/home/hisham/.config/awesome/icons/buttons/close.svg"
theme.titlebar_close_button_focus  = "/home/hisham/.config/awesome/icons/buttons/close.svg"
theme.titlebar_sticky_button_normal_inactive = "/home/hisham/.config/awesome/icons/buttons/sticky_button.svg"
theme.titlebar_sticky_button_focus_inactive  = "/home/hisham/.config/awesome/icons/buttons/sticky_button.svg"
theme.titlebar_sticky_button_normal_active = "/home/hisham/.config/awesome/icons/buttons/sticky_button.svg"
theme.titlebar_sticky_button_focus_active  = "/home/hisham/.config/awesome/icons/buttons/sticky_button.svg"

theme.titlebar_floating_button_normal_inactive = "/home/hisham/.config/awesome/icons/buttons/floating_button.svg"
theme.titlebar_floating_button_focus_inactive  = "/home/hisham/.config/awesome/icons/buttons/floating_button.svg"
theme.titlebar_floating_button_normal_active = "/home/hisham/.config/awesome/icons/buttons/floating_button.svg"
theme.titlebar_floating_button_focus_active  = "/home/hisham/.config/awesome/icons/buttons/floating_button.svg"

theme.titlebar_maximized_button_normal_inactive = "/home/hisham/.config/awesome/icons/buttons/maximize.svg"
theme.titlebar_maximized_button_focus_inactive  = "/home/hisham/.config/awesome/icons/buttons/maximize.svg"
theme.titlebar_maximized_button_normal_active = "/home/hisham/.config/awesome/icons/buttons/maximize.svg"
theme.titlebar_maximized_button_focus_active  = "/home/hisham/.config/awesome/icons/buttons/maximize.svg"

-- Configure the window switcher
theme.window_switcher_widget_bg = theme.bg_normal              -- The bg color of the widget
theme.window_switcher_widget_border_width = dpi(1)            -- The border width of the widget
theme.window_switcher_widget_border_radius = dpi(8)           -- The border radius of the widget
theme.window_switcher_widget_border_color = theme.border_focus    -- The border color of the widget
theme.window_switcher_clients_spacing = 20               -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 350                 -- The width of one client widget
theme.window_switcher_client_height = 350                -- The height of one client widget
theme.window_switcher_client_margins = 10                -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10             -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = true                            -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10                  -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center"             -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200            -- The width of one title
theme.window_switcher_name_font = "Inter 10"              -- The font of all titles
theme.window_switcher_name_normal_color = theme.fg_normal      -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = ColorScheme[14]       -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center"             -- How to vertically align the one icon
theme.window_switcher_icon_width = 40  

return theme
