local json          =   require('json')
local watch         =   require('awful.widget.watch')
local awful         =   require('awful')
local wibox         =   require('wibox')
local xresources    =   require('beautiful.xresources')
local dpi           =   xresources.apply_dpi
local naughty       =   require('naughty')
local icons_dir     =   os.getenv('HOME') .. '/.config/awesome/icons/prayers/'

local GET_TIMES_CMD = "curl -s '%s'"
screen_height = awful.screen.focused().workarea.height
screen_width = awful.screen.focused().workarea.width

local Prayers_widget = {}

Prayers_widget = wibox.widget {
    {
        {
            id              =   'icon',
            forced_height   =   screen_width * 0.05,
            forced_width    =   screen_width * 0.05,
            resize          =   true,
            opacity         =   0.9,
            widget          =   wibox.widget.imagebox
        },
        halign   =   'center',
        widget  =   wibox.container.place
    },
    {
        {
            {
                id      =   'text',
                font    =   'Noto Kufi Arabic 8',
                widget  =   wibox.widget.textbox
            },
            right = screen_width * 0.0015,
            left = screen_width * 0.0015,
            widget = wibox.container.margin
        },
        bg = Wdt_bg,
        shape = Wdt_shape,
        widget = wibox.container.background
    },
    spacing = screen_height * 0.01,
    layout = wibox.layout.fixed.vertical,
}

Pryr_wdt = wibox.widget {
    {
        id      =   'mini_widget',
        font    =   'Noto Kufi Arabic 8',
        widget  =   wibox.widget.textbox
    },
    {
        {
            {
                id = 'mini_icon',
                image = icons_dir .. 'mosque.svg',
                resize = true,
                widget = wibox.widget.imagebox
            },
            top = screen_width * 0.0015,
            bottom = screen_width * 0.0015,
            widget = wibox.container.margin
        },
        halign = 'center',
        valign = 'center',
        widget = wibox.container.place
    },
    spacing = screen_width * 0.003,
    layout = wibox.layout.fixed.horizontal
}

--Arguments
local GeoLoc    =   'By_Cor' -- Choose either By_Cor for cooridnation based or By_City for city name based
local today     =   os.time() -- Date should be in the UNIX timestamp format
-- The more accurate coordinates the more accurate prayer times
local lat       =   '-41.124877'
local long      =   '-71.365303'
local city      =   'Bariloche'
local country   =   'Argentina'
local method    =   '2' -- method 2 for Americas
local adjustment=   '1' -- To adjust the hijri date
local timeout   =   60 -- 1 min is good enough to change the backgrouond of the current prayer
local TZ_adj    =   os.time()-os.time(os.date('!*t'))
local bgcolor   =   '#7e8d50'
local icons_ext =   '.svg'

if GeoLoc == 'By_City' then
    Api = ('http://api.aladhan.com/v1/timingsByCity?city=' .. city .. '&country=' .. country .. '&method=' .. method .. '&adjustment=' .. adjustment)
else
    Api = ('http://api.aladhan.com/v1/timings/' .. today .. '?latitude=' .. lat .. '&longitude=' .. long .. '&method=' .. method .. '&adjustment=' .. adjustment)
end

local function update_widget(widget,stdout)
    Current_time    =   os.date('%H:%M')
    Result          =   json.decode(stdout)
    Fajr            =   Result.data.timings.Fajr
    Shuruq          =   Result.data.timings.Sunrise
    Duhur           =   Result.data.timings.Dhuhr
    Asr             =   Result.data.timings.Asr
    Maghrib         =   Result.data.timings.Maghrib
    Isha            =   Result.data.timings.Isha

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

    Prayer_names = {'??????????', '????????????', '??????????', '??????????', '????????????', '????????????'}

    function Notification (name)
        naughty.notify(
        {
            timeout     =   30,
            font        =   'Noto Kufi Arabic 7',
            icon        =   icons_dir .. 'mosque' .. icons_ext,
            icon_size   =   dpi(48),
            text        =   '?????? ???????? ???????? ???????? <span fgcolor="' .. bgcolor .. '"><b>' .. name .. '</b></span> ?????? ?????????????? ???????????? ???????????? ??????????????????'
        }
        )
        if name == Prayer_names[1] then
            awful.spawn.with_shell('mpv $HOME/.local/share/Azan_fajr.webm')
        else
            awful.spawn.with_shell('mpv $HOME/.local/share/Azan.webm')
        end
    end

    Fajr_text       = '?? '   .. Prayer_names[1] .. '\t\t\t' .. Fajr    .. ' ?? '
    Shuruq_text     = '\n?? ' .. Prayer_names[2] .. '\t\t\t' .. Shuruq  .. ' ?? '
    Duhur_text      = '\n?? ' .. Prayer_names[3] .. '\t\t\t' .. Duhur   .. ' ?? '
    Asr_text        = '\n?? ' .. Prayer_names[4] .. '\t\t\t' .. Asr     .. ' ?? '
    Maghrib_text    = '\n?? ' .. Prayer_names[5] .. '\t\t\t' .. Maghrib .. ' ?? '
    Isha_text       = '\n?? ' .. Prayer_names[6] .. '\t\t\t' .. Isha    .. ' ?? '

    if Current_time >= Fajr and Current_time < Shuruq then
        if Current_time == Fajr then
            Notification(Prayer_names[1])
        end
        Remain          =   Diff(Duhur)
        Fajr_text       =   '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">?? ' .. Prayer_names[1] .. '\t\t\t' .. Fajr .. ' ?? </span>'
        Image           =   icons_dir .. 'praying_fajr' .. icons_ext
        Remain          =   Diff(Duhur)
        Next_prayer     =   Duhur
        Next_prayer_str =   Prayer_names[3]
    elseif Current_time >= Shuruq and Current_time < Duhur then
        if Current_time == Shuruq then
            awful.spawn.with_shell('mpv $HOME/.local/share/Nature.mp3')
        end
        Remain          =   Diff(Duhur)
        Shuruq_text     =   '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n?? ' .. Prayer_names[2] .. '\t\t\t' .. Shuruq .. ' ?? </span>'
        Image           =   icons_dir .. 'praying' .. icons_ext
        Remain          =   Diff(Duhur)
        Next_prayer     =   Duhur
        Next_prayer_str =   Prayer_names[3]
    elseif Current_time >= Duhur and Current_time < Asr then
        if Current_time == Duhur then
            Notification(Prayer_names[3])
        end
        Remain          =   Diff(Asr)
        Duhur_text      =   '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n?? ' .. Prayer_names[3] .. '\t\t\t' .. Duhur .. ' ?? </span>'
        Image           =   icons_dir .. 'praying_duhur' .. icons_ext
        Remain          =   Diff(Asr)
        Next_prayer     =   Asr
        Next_prayer_str =   Prayer_names[4]
    elseif Current_time >= Asr and Current_time < Maghrib then
        if Current_time == Asr then
            Notification(Prayer_names[4])
        end
        Remain          =   Diff(Maghrib)
        Asr_text        =   '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n?? ' .. Prayer_names[4] .. '\t\t\t' .. Asr .. ' ?? </span>'
        Image           =   icons_dir .. 'praying_asr' .. icons_ext
        Remain          =   Diff(Maghrib)
        Next_prayer     =   Maghrib
        Next_prayer_str =   Prayer_names[5]
    elseif Current_time >= Maghrib and Current_time < Isha then
        if Current_time == Maghrib then
            Notification(Prayer_names[5])
        end
        Remain          =   Diff(Isha)
        Maghrib_text    =   '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n?? ' .. Prayer_names[5] .. '\t\t\t' .. Maghrib .. ' ?? </span>'
        Image           =   icons_dir .. 'praying_maghrib' .. icons_ext
        Remain          =   Diff(Isha)
        Next_prayer     =   Isha
        Next_prayer_str =   Prayer_names[6]
    else
        if Current_time == Isha then
            Notification(Prayer_names[6])
        end
        Remain          =   Diff(Fajr)
        Isha_text       =   '<span bgcolor="' .. bgcolor .. '" bgalpha="68%">\n?? ' .. Prayer_names[6] .. '\t\t\t' .. Isha .. ' ?? </span>'
        Image           =   icons_dir .. 'praying_isha' .. icons_ext
        Remain          =   Diff(Fajr)
        Next_prayer     =   Fajr
        Next_prayer_str =   Prayer_names[1]
    end

    ArabicDay       =   Result.data.date.hijri.weekday.ar
    ArabicDayNum    =   Result.data.date.hijri.day
    HijriMonth      =   Result.data.date.hijri.month.ar
    HijriYear       =   Result.data.date.hijri.year
    HijriDate       =   ArabicDayNum .. ' ' .. HijriMonth .. ' ' .. HijriYear .. ' ??????????\n'
    Heading         =   '???????????? ???????????? ???????? ' .. ArabicDay .. '\n' .. HijriDate

    widget:get_children_by_id('text')[1]:set_markup(
    Heading ..
    '?????????? ??????????????:\t\t<span bgcolor="' .. bgcolor .. '" bgalpha="68%">' .. Remain .. '</span>' .. '\n' ..
    Fajr_text ..
    Shuruq_text ..
    Duhur_text ..
    Asr_text ..
    Maghrib_text ..
    Isha_text
    )
    widget:get_children_by_id('icon')[1]:set_image(Image)
    Pryr_wdt:get_children_by_id('mini_widget')[1]:set_text('???????????? ?????????????? ?? ' .. Next_prayer_str ..
    ' ??  ' .. Next_prayer .. ' ( ?????????? ?????????????? ' .. Remain .. ' )')
end

CAT_CMD = [[bash -c 'cat $HOME/.local/share/prayers.json']]
watch(CAT_CMD, timeout, update_widget, Prayers_widget)

awful.screen.connect_for_each_screen(function(s)
    s.Prayers_widget = awful.wibar(
    {
        height  =   screen_height * 0.36,
        width   =   screen_width * 0.13,
        shape   =   Wdt_shape,
    }
    )

    s.Prayers_widget:setup {
        {
            {
                layout  =   wibox.layout.fixed.horizontal,
                Prayers_widget
            },
            margins = screen_width * 0.005,
            widget  =   wibox.container.margin
        },
        halign = 'center',
        widget = wibox.container.place
    }

end)

return Prayers_widget
