local json          =   require('json')
local awful         =   require('awful')
local beautiful     =   require('beautiful')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/prayers/'
local naughty       =   require('naughty')
local watch         =   require('awful.widget.watch')
local wibox         =   require('wibox')
local xresources    =   require('beautiful.xresources')
local dpi           =   xresources.apply_dpi

local GET_TIMES_CMD = "curl -s '%s'"
screen_height = awful.screen.focused().geometry.height
screen_width = awful.screen.focused().geometry.width

local Prayers_widget = {}

Pryr_wdt = wibox.widget {
    {
        {
            id      =   'mini_widget',
            widget  =   wibox.widget.textbox
        },
        valign = 'center',
        widget = wibox.container.place,
    },
    {
        {
            {
                id = 'mini_icon',
                image = icons_dir .. 'mosque.svg',
                forced_width = screen_width * 0.01,
                forced_height = screen_width * 0.01,
                resize = true,
                widget = wibox.widget.imagebox
            },
            top = screen_width * 0.0005,
            bottom = screen_width * 0.0005,
            widget = wibox.container.margin
        },
        halign = 'center',
        valign = 'center',
        widget = wibox.container.place
    },
    spacing = screen_width * 0.003,
    layout = wibox.layout.fixed.horizontal
}

local TZ_adj    =   os.time()-os.time(os.date('!*t'))
local bgcolor   =   beautiful.fg_occupied .. 'a9'
local icons_ext =   '.png'

Prayer_id       =   {'Fajr_widget', 'Shuruq_widget', 'Duhur_widget', 'Asr_widget', 'Maghrib_widget', 'Isha_widget'}
Prayer_bg_id    =   {'Fajr_widget_bg', 'Shuruq_widget_bg', 'Duhur_widget_bg', 'Asr_widget_bg', 'Maghrib_widget_bg', 'Isha_widget_bg'}
Prayer_names    =   {'الـــفجـــر', 'الشروق', 'الـــظهر', 'العــــصر', 'المــغرب', 'الـعشاء'}
icon_name       =   {'praying_fajr', 'praying', 'praying_duhur', 'praying_asr', 'praying_maghrib', 'praying_isha'}

local function update_widget(widget,stdout)
    Current_time    =   os.date('%H:%M')
    Result          =   json.decode(stdout)
    Times = {}
    table.insert(Times,Result.data.timings.Fajr)
    table.insert(Times,Result.data.timings.Sunrise)
    table.insert(Times,Result.data.timings.Dhuhr)
    table.insert(Times,Result.data.timings.Asr)
    table.insert(Times,Result.data.timings.Maghrib)
    table.insert(Times,Result.data.timings.Isha)
    table.insert(Times,Result.data.timings.Sunset)

    function Prayer_utc(P_h_m)
        str                         =   os.date('%a %d %b %Y ') .. P_h_m .. ':' .. os.date('%S')
        p                           =   "%a+ (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)"
        Day,Month,Year,Hour,Min,Sec =   str:match(p)
        MON                         =   {Jan=1,Feb=2,Mar=3,Apr=4,May=5,Jun=6,Jul=7,Aug=8,Sep=9,Oct=10,Nov=11,Dec=12}
        Month                       =   MON[Month]
        Seconds                     =   os.time({day=Day,month=Month,year=Year,hour=Hour,min=Min,sec=Sec}) - os.time() - TZ_adj
        return Seconds
    end

    function Diff(next_p)
        In_sec  =   Prayer_utc(next_p)
        Total   =   os.date('%H:%M',In_sec)
        return Total
    end

    function day_length()
        sunrise  =   Prayer_utc(Times[2])
        sunset  =   Prayer_utc(Times[7])
        length_number = sunset - sunrise - TZ_adj
        length   =   os.date('%H:%M',length_number)
        return length
    end


    function Notification (name)
        naughty.notify(
        {
            timeout     =   15,
            icon        =   icons_dir .. 'mosque.svg',
            icon_size   =   dpi(48),
            text        =   'حان الآن موعد صلاة <span fgcolor="' .. bgcolor .. '"><b>' .. name .. '</b></span> حسب التوقيت المحلي لمدينة باريلوتشي',
            position    =   'top_middle',
        }
        )
        if name == Prayer_names[1] then
            awful.spawn.with_shell('io.mpv.Mpv --volume=70 $HOME/.local/share/Azan_fajr.webm')
        else
            awful.spawn.with_shell('io.mpv.Mpv --volume=70 $HOME/.local/share/Azan.webm')
        end
    end

Texts = {}
for i=1,6 do
    table.insert(Texts, '۞ ' .. Prayer_names[i] .. '\t\t\t' .. Times[i]     .. ' ۞')
    widget:get_children_by_id(Prayer_bg_id[i])[1]:set_bg(beautiful.bg_empty)
    widget:get_children_by_id(Prayer_bg_id[i])[1]:set_shape(Wdt_shape)
    widget:get_children_by_id(Prayer_id[i])[1]:set_font('10')
end

    if Current_time >= Times[1] and Current_time < Times[6] then
        for i=1,5 do
            if Current_time >= Times[i] and Current_time < Times[i+1] then
                if Current_time == Times[2] then
                    awful.spawn.with_shell('io.mpv.Mpv $HOME/.local/share/Nature.mp3')
                elseif Current_time == Times[i] then
                    Notification(Prayer_names[i])
                end
                widget:get_children_by_id(Prayer_bg_id[i])[1]:set_bg(bgcolor)
                Remain          =   Diff(Times[i+1])
                Image           =   icons_dir .. icon_name[i] .. icons_ext
                Next_prayer     =   Times[i+1]
                Next_prayer_str =   Prayer_names[i+1]
            end
        end
    else 
        if Current_time == Times[6] then
            Notification(Prayer_names[6])
        end
        widget:get_children_by_id(Prayer_bg_id[6])[1]:set_bg(bgcolor)
        Remain          =   Diff(Times[1])
        Image           =   icons_dir .. icon_name[6] .. icons_ext
        Next_prayer     =   Times[1]
        Next_prayer_str =   Prayer_names[1]
    end

    ArabicDay       =   Result.data.date.hijri.weekday.ar
    ArabicDayNum    =   Result.data.date.hijri.day
    HijriMonth      =   Result.data.date.hijri.month.ar
    HijriYear       =   Result.data.date.hijri.year
    HijriDate       =   ArabicDayNum .. ' ' .. HijriMonth .. ' ' .. HijriYear .. ' هجرية'
    Heading         =   'مواقيت الصلاة ليوم ' .. ArabicDay ..  '\n' .. HijriDate .. '\n' .. 'طول اليوم: \t\t (' .. day_length() .. ' ساعة)\n'

    widget:get_children_by_id('icon')[1]:set_image(Image)
    widget:get_children_by_id('Heading_widget')[1]:set_markup(Heading ..
    'الوقت المتبقي:\t\t<span fgcolor="' .. beautiful.fg_occupied .. '">'.. Remain .. '</span> ۞ ')
    for i=1,6 do
        widget:get_children_by_id(Prayer_id[i])[1]:set_markup(Texts[i])
    end

    Pryr_wdt:get_children_by_id('mini_widget')[1]:set_markup('الصلاة القادمة: <span fgcolor="' 
    .. beautiful.color2 .. '">' .. Next_prayer_str .. ' ' .. Next_prayer  .. '</span> ' 
    .. ' (الوقت المتبقي <span fgcolor="' .. beautiful.color2 .. '">' .. Remain .. '</span>)')

end

Prayers_widget = wibox.widget {
   {
      {
         {
             id              =   'icon',
             forced_height   =   screen_width * 0.045,
             forced_width    =   screen_width * 0.045,
             resize          =   true,
             opacity         =   0.9,
             widget          =   wibox.widget.imagebox
         },
         halign   =   'center',
         valign   =   'center',
         widget  =   wibox.container.place
     },
     { -- Heading
         {
             {
                 id      =   'Heading_widget',
                 font    =   '10',
                 widget  =   wibox.widget.textbox
             },
             top = screen_width * 0.0020,
             right = screen_width * 0.0015,
             left = screen_width * 0.0015,
             widget = wibox.container.margin
         },
         bg = beautiful.bg_empty,
         shape = Wdt_shape,
         widget = wibox.container.background
     },
     { -- Fajr
         {
	    {
	       id      =   Prayer_id[1],
	       widget  =   wibox.widget.textbox
	    },
	    left = screen_width * 0.0015,
	    right = screen_width * 0.0015,
	    widget = wibox.container.margin
         },
         id      =   Prayer_bg_id[1],
         widget = wibox.container.background
     },
     { -- Shuruq
         {
	    {
	       id      =   Prayer_id[2],
	       widget  =   wibox.widget.textbox
	    },
	    left = screen_width * 0.0015,
	    right = screen_width * 0.0015,
	    widget = wibox.container.margin
         },
         id      =   Prayer_bg_id[2],
         widget = wibox.container.background
     },
     { -- Dhuhr
         {
	    {
	       id      =   Prayer_id[3],
	       widget  =   wibox.widget.textbox
	    },
	    left = screen_width * 0.0015,
	    right = screen_width * 0.0015,
	    widget = wibox.container.margin
         },
         id = Prayer_bg_id[3],
         widget = wibox.container.background
     },
     { -- Asr
         {
	    {
	       id      =   Prayer_id[4],
	       widget  =   wibox.widget.textbox
	    },
	    left = screen_width * 0.0015,
	    right = screen_width * 0.0015,
	    widget = wibox.container.margin
         },
         id      =   Prayer_bg_id[4],
         widget = wibox.container.background
     },
     { -- Maghrib
         {
	    {
	       id      =   Prayer_id[5],
	       widget  =   wibox.widget.textbox
	    },
	    left = screen_width * 0.0015,
	    right = screen_width * 0.0015,
	    widget = wibox.container.margin
         },
         id      =   Prayer_bg_id[5],
         widget = wibox.container.background
     },
     { -- Isha
         {
	    {
	       id      =   Prayer_id[6],
	       widget  =   wibox.widget.textbox
	    },
	    left = screen_width * 0.0015,
	    right = screen_width * 0.0015,
	    widget = wibox.container.margin
         },
         id      =   Prayer_bg_id[6],
         widget = wibox.container.background
     },
     spacing = screen_height * 0.0022,
     layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.margin
}

CAT_CMD = [[bash -c 'cat $HOME/.local/share/prayers.json']]
watch(CAT_CMD, timeout, update_widget, Prayers_widget)

awful.screen.connect_for_each_screen(function(s)
    s.Prayers_widget = awful.wibar(
    {
        screen  =   s,
        height  =   screen_height * 0.25,
        width   =   screen_width * 0.078,
        bg      =   '#0000',
        shape   =   bar_wdt_shape
    }
    )

    s.Prayers_widget:setup {
        {
            {
                layout  =   wibox.layout.fixed.horizontal,
                Prayers_widget
            },
            halign = 'center',
	    valign = 'center',
	    widget = wibox.container.place
        },
        widget = wibox.container.background,
        shape = big_wdt_shape,
        bg = beautiful.bg_normal
    }

end)
Prayers_widget:connect_signal('button::release',function(_,_,_,button)
    if (button == 1) then
       awful.spawn.with_shell('prayerTimes.sh')
    end
end)

return Prayers_widget
