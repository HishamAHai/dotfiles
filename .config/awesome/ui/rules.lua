local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local wibox = require('wibox')

local rules = {}
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height
awful.rules.rules = {
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = buttonkeys,
            screen = awful.screen.preferred,
            placement = awful.placement.centered+awful.placement.no_offscreen,
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                'DTA', 'copyq', 'pinentry'
            },
            class = {
                'Arandr', 'Blueman-manager', 'Nitrogen', 'lxrandr', 'Lxappearance',
                'Hardinfo', 'Kvantum Manager', 'Xarchiver', 'Nm-connection-editor',
                'GParted', 'Timeshift-gtk', 'Virtualbox Machine', 'Virtualbox Manager',
                'Xfce4-about', 'KeePassXC', 'Pavucontrol', 'qt5ct', 'qt6ct', 'Songrec',
                'Xfce4-power-manager-settings', 'Cadence', 'Catia', 'NoiseTorch',
                'slickpicker', 'Psensor', 'org.kde.fancontrol.gui', 'Nextcloud',
                'Galculator','pavucontrol-qt','Nvidia-settings', 'Gddccontrol',
                'SimpleScreenRecorder', 'Solaar', 'corectrl', 'openrgb', 'Fsearch',
                'helvum', 'smile', 'livecaptions', 'scrcpy',
            },
        role = {
            'GtkFileChooserDialog', 'pop-up'
        },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            'Event Tester',  -- xev.
        },
        type = {
            'dialog'
        },
    },
    properties = {
        floating = true,
        --titlebars_enabled = true,
    }
},
    -- Specific applications run on specific tags
{
    rule_any = {
        class = {'wezterm', 'kitty'},
    },
    properties = {
        tags = {'J.A.R.V.I.S', 'VOYAGER' },
        switchtotag = true
    }
},

{
    rule = {
        class = 'Emacs'
    },
    properties = {
        size_hints_honor = false,
    }
},

{
    rule_any = {
        class = {'resolve'},
    },
    properties = {
        tag = screen[1].tags[5],
        titlebars_enabled = false, 
        floating = true,
        switchtotag = true
    }
},

{
    rule_any = {
        class = {'kdenlive'},
    },
    properties = {
        tag = screen[1].tags[5],
        titlebars_enabled = false,
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'firefox','Brave-browser', 'qutebrowser', 'LibreWolf'
        },
        name = {
            'Chromium',
        }
    },
    properties = {
        tags = {'TARS', 'CASE' },
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'Geany','libreoffice-startcenter','org-tinymediamanager-TinyMediaManager',
        }
    },
    properties = {
        tag = screen[1].tags[3],
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'Gimp',
        },
    },
    properties = {
        screen = 2,
    }
},

{
    rule_any = {
        class = {
            'altaqwaa',
        },
    },
    properties = {
        floating = true,
    }
},

{
    rule_any = {
        class = {
            'Inkscape',
        },
    },
    properties = {
        --titlebars_enabled = true,
        tag = screen[1].tags[3],
        floating = false,
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'Pcmanfm','Uget-gtk', 'Nemo', 'krusader', 'pcmanfm-qt', 'Fragments',
        }
    },
    properties = {
        tag = screen[1].tags[4],
        switchtotag = true
    }
},

{
    rule_any = {
        class = {
            'mpv'
        }
    },
    properties = {
        tags = {'T-800','F.R.I.D.A.Y'},
        switchtotag = true,
        floating = true,
        border_width = 0
    }
},

{
    rule_any = {
        class = {
            'obs'
        }
    },
    properties = {
        screen = 3,
    }
},

{
    rule_any = {
        class = {
            'Ardour'
        }
    },
    properties = {
        tag = screen[1].tags[4],
        switchtotag = true,
	--titlebars_enabled = true,
    }
},

}

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c,{size=screen_height*0.016}) : setup {
        { -- Left
            awful.titlebar.widget.closebutton    (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.stickybutton   (c),
            layout = wibox.layout.fixed.horizontal()
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            layout  = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- ========================= Signals ===========================================
-- No borders for floating windows
--screen.connect_signal('arrange', function(s)
--    for _, c in pairs(s.clients) do
--        if c.floating == true then
--            c.border_width = 0
--        end
--    end
--end)

-- Enable borders for focused windows
client.connect_signal('focus', function(c)
            if not awful.rules.match_any(c, {class = {'mpv', 'scrcpy', 'Nsxiv', 'Vlc', 'resolve', 'Blender', 'Double Commander'}}) then
                c.border_width = beautiful.border_width
                c.border_color = beautiful.border_focus
            end
end)
client.connect_signal('unfocus', function(c)
    c.border_width = 0
    c.border_color = beautiful.border_normal
end)

-- Enable mouse bindings to move and resize clients
client.connect_signal('manage', function (c)
    c:keys(clientkeys)
    c:buttons(clientbuttons)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
    c:emit_signal('request::activate', 'mouse_enter', {raise = false})
end)

-- Dialogs of kdenlive are not to be tiled
client.connect_signal('activated', function(c)
    if awful.rules.match(c, {class = 'kdenlive'}) and not awful.rules.match(c, {type = {'dialog'}}) then
        c.titlebars_enabled   =   false
        c.floating            =   false
        c.switchtotag         =   true
    end
end)

return rules
