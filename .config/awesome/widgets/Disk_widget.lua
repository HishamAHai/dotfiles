local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/'

local Disk_widget = {}
local screen_width = awful.screen.focused().geometry.width

DSK_CMD = [[ bash -c "df -h -P /home | awk '/\/.*/ {print $4}'"]]
timeout = 300

disk_widget = wibox.widget {
    {
        {
            {
                    {
                        id = 'icon',
                        resize = true,
                        forced_width = screen_width * 0.01,
                        forced_height = screen_width * 0.01,
                        image = '/home/hisham/.local/share/icons/Reversal-purple/devices/scalable/drive-harddisk.svg',
                        widget = wibox.widget.imagebox
                    },
                    margins = screen_width * 0.0005,
                    widget = wibox.container.margin
            },
            {
                {
                    {
                        id = 'disk_wdt',
                        widget = wibox.widget.textbox
                    },
                    widget = wibox.container.margin(_,_,Wdt_rmgn,_,_,_,_),
                },
            valign = 'center',
            widget = wibox.container.place
            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    --bg = Wdt_bg,
    fg = beautiful.color2,
    shape = Wdt_shape,
    widget = wibox.container.background
}
disk_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell ('alacritty --hold -e dust -r /home')
    end
        end)

function Update_disk_widget(widget,stdout)
    widget:get_children_by_id('disk_wdt')[1]:set_text(stdout)
end

watch(DSK_CMD,timeout,Update_disk_widget,disk_widget)

return Disk_widget
