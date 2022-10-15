local awful = require('awful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/'


local Gpu_temp_widget = {}
screen_width = awful.screen.focused().geometry.width

timeout = 5
--GPU_CMD = [[ bash -c "cat /sys/class/drm/card0/device/hwmon/hwmon?/temp1_input" ]]
GPU_CMD = [[ bash -c "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader" ]]

gpu_temp_widget = wibox.widget {
    {
        {
            {
                {
                    id = 'icon',
                    image = '/usr/share/icons/Papirus/48x48/apps/deepin-graphics-driver-manager.svg',
                    resize = true,
                    widget = wibox.widget.imagebox
                },
                top = screen_width * 0.0005,
                bottom = screen_width * 0.0005,
                right = screen_width * 0.0024,
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
gpu_temp_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e sensors')
    end
        end)

function Update_gpu_temp_widget(widget,stdout)
    --widget:get_children_by_id('temp')[1]:set_text(stdout / 1000 .. '°C')
    widget:get_children_by_id('temp')[1]:set_text(stdout .. '°C')
end

watch(GPU_CMD,timout,Update_gpu_temp_widget,gpu_temp_widget)

return Gpu_temp_widget
