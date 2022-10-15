local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/'


local Cpu_temp_widget = {}
screen_width = awful.screen.focused().geometry.width

timeout = 5
CPU_CMD = [[ bash -c "cat /sys/devices/platform/coretemp.0/hwmon/hwmon?/temp1_input" ]]

cpu_temp_widget = wibox.widget {
    {
        {
            {
                {
                    id = 'icon',
                    image = '/usr/share/icons/Papirus/48x48/devices/cpu.svg',
                    resize = true,
                    widget = wibox.widget.imagebox
                },
                top = screen_width * 0.0005,
                bottom = screen_width * 0.0005,
                right = screen_width * 0.003,
                widget = wibox.container.margin
            },
            {
                id = 'temp',
                widget = wibox.widget.textbox
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    --bg = Wdt_bg,
    shape = Wdt_shape,
    widget = wibox.container.background
}
cpu_temp_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e sensors')
    end
        end)

function Update_cpu_temp_widget(widget,stdout)
    widget:get_children_by_id('temp')[1]:set_text(stdout / 1000 .. '°C')
end

watch(CPU_CMD,timout,Update_cpu_temp_widget,cpu_temp_widget)

return Cpu_temp_widget
