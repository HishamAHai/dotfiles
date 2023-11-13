local json          =   require('json')
local awful = require('awful')
local xresources = require('beautiful.xresources')
local beautiful =   require('beautiful')
local dpi = xresources.apply_dpi
local gears = require('gears')
local watch = require('awful.widget.watch')
local wibox = require('wibox')

screen_height = awful.screen.focused().geometry.height
screen_width = awful.screen.focused().geometry.width
local models_widget = {}
corners = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, screen_width * 0.002) end
    local model_cmd = [[ bash -c 'cat /mnt/nasbkup/models.json' ]]
    local timeout = 108

    model_id = {'artejones', 'miroslavaluewe', 'elenalooove', 'daddysgirl222', 'suma_ren', 'miss__tanya', 'tiffanyhouston_', 'seltin_sweety', 'yourcutekote', 'milky_noway', 'blondehottiekerry', 'kandycats', 'adarabunny', 'charlotte114', 'tqla', 'yesikasaenz', 'mysweethobby', 'angiefaith', 'devyale'}
    model_bg_id = {'artejones_bg', 'miroslavaluewe_bg', 'elenalooove_bg', 'daddysgirl222_bg', 'suma_ren_bg', 'miss__tanya_bg', 'tiffanyhouston__bg', 'seltin_sweety_bg', 'yourcutekote_bg', 'milky_noway_bg', 'blondehottiekerry_bg', 'kandycats_bg', 'adarabunny_bg', 'charlotte114_bg', 'tqla_bg', 'yesikasaenz_bg', 'mysweethobby_bg', 'angiefaith_bg', 'devyale_bg'}
    model_name = {'ArteJones\t', 'MiroslaLuewe', 'ElenaLooove', 'DaddysGirl222', 'SumaRen\t', 'Tanya\t\t', 'Tiffany\t\t', 'SeltinSweety', 'CuteKote\t', 'MilkyNoway', 'Kerry\t\t', 'KandyCats\t', 'AdaraBunny', 'Charlotte\t', 'Tqla\t\t\t', 'YesikaSaenz', 'SweetHobby', 'AngieFaith\t', 'Devyale\t\t'}

    function tablelength(T)
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
    end

    local update_widget = function(self,stdout)
        onOff = json.decode(stdout)
        status = {}
        for i=1,tablelength(model_id) do
            table.insert(status,onOff.status[i])
            self:get_children_by_id(model_bg_id[i])[1]:set_shape(corners)
            self:get_children_by_id(model_id[i])[1]:set_font('13')
            if status[i] == 'online' then
                self:get_children_by_id(model_bg_id[i])[1]:set_shape_border_color(beautiful.color2)
                self:get_children_by_id(model_bg_id[i])[1]:set_shape_border_width(dpi(1))
                self:get_children_by_id(model_id[i])[1]:set_opacity(1)
                self:get_children_by_id(model_id[i])[1]:set_markup('   ' .. model_name[i] .. '\t\t🍑\t\t' ..
                '<span bgcolor="' .. beautiful.color2 .. 'a8" fgcolor="' .. beautiful.fg_normal .. '">'
                .. status[i] .. '</span>')
                self:get_children_by_id(model_bg_id[i])[1]:set_fg(beautiful.color2)
                self:get_children_by_id(model_bg_id[i])[1]:set_bg(beautiful.color1 .. '5c')
            elseif status[i] == 'offline' then
                self:get_children_by_id(model_bg_id[i])[1]:set_shape_border_width(dpi(0))
                self:get_children_by_id(model_id[i])[1]:set_opacity(0.6)
                self:get_children_by_id(model_id[i])[1]:set_markup('   <span fgcolor="' .. beautiful.fg_normal
                .. '">' .. model_name[i] .. '</span>' .. '\t\t💤\t\t' .. status[i])
                self:get_children_by_id(model_bg_id[i])[1]:set_fg(beautiful.fg_urgent)
                self:get_children_by_id(model_bg_id[i])[1]:set_bg('#0000')
            end

        end
    end

    model = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        spacing = screen_height * 0.002,
        {
            {
                image = '/mnt/nasbkup/chaturbate.svg',
                resize = true,
                opacity = '0.45',
                widget = wibox.widget.imagebox
            },
            widget = wibox.container.margin(_,21,21,5,_,_)
        },
        {
            {
                id = model_id[1],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[1],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[2],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[2],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[3],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[3],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[4],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[4],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[5],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[5],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[6],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[6],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[7],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[7],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[8],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[8],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[9],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[9],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[10],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[10],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[11],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[11],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[12],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[12],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[13],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[13],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[14],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[14],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[15],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[15],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[16],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[16],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[17],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[17],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[18],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[18],
            widget = wibox.container.background
        },
        {
            {
                id = model_id[19],
                widget = wibox.widget.textbox
            },
            id = model_bg_id[19],
            widget = wibox.container.background
        },
    }
    awful.screen.connect_for_each_screen(function(s)
        if s.index == 1 then
            s.models_wdt= awful.wibar(
            {
                screen          =   s,
                --type            =   'desktop',
                bg              =   '#00000000',
                shape           =   function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, screen_width * 0.003)
                end,
                border_width    =   dpi(1),
                border_color    =   beautiful.fg_urgent,
                width           =   screen_width * 0.11,
                height          =   tablelength(model_id) * screen_height * 0.021
            }
            )

            s.models_wdt:setup{
                {
                    model,
                    widget = wibox.container.margin(_,4,4,4,4,_)
                },
                widget = wibox.container.background,
                bg = '#00000000',
            }
        end
    end)

    watch(model_cmd,timeout,update_widget,model)
    return models_widget
