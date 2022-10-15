local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local watch = require('awful.widget.watch')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/'


local Memory_widget = {}
local screen_width = awful.screen.focused().geometry.width

--MEM_CMD = [[ bash -c "free -h | awk '/^Mem/ {print $3}' | sed 's/i//'" ]]
MEM_CMD = [[ bash -c "memory.sh" ]]
timeout = 10

mem_widget = wibox.widget {
    {
        {
            {
                {
                    {
                        id = 'icon',
                        resize = true,
                        forced_height = screen_width * 0.01,
                        forced_width = screen_width * 0.01,
                        image = '/usr/share/icons/Papirus/48x48/devices/gnome-dev-memory.svg',
                        widget = wibox.widget.imagebox
                    },
                    margins = screen_width * 0.0005,widget = wibox.container.margin
                },
                valign = 'center',
                widget = wibox.container.place
            },
            {
                id = 'mem_wdt',
                widget = wibox.widget.textbox
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.margin(_,Wdt_lmgn,Wdt_rmgn,_,_,_,_),
    },
    --bg = Wdt_bg,
    fg = beautiful.color11,
    shape = Wdt_shape,
    widget = wibox.container.background
}
mem_widget:connect_signal('button::press', function (_,_,_,button)
    if (button == 1) then awful.spawn.with_shell('alacritty --hold -e htop')
    end
        end)

function Update_mem_widget(widget,stdout)
    widget:get_children_by_id('mem_wdt')[1]:set_text(stdout)
end

watch(MEM_CMD,timeout,Update_mem_widget,mem_widget)

return Memory_widget
