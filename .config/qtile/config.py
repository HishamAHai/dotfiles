# Imports
from libqtile import bar, layout, hook
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile import extension
import os
import subprocess

# Mod keys
mod = "mod4"
Ralt = "mod5"
Lalt = "mod1"

# Default programs
terminal = "kitty"
browser = "firefox"

keys = [
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), 
        desc="Toggle between layouts"),

    # Kill focued window
    Key([mod, "shift"], "c", lazy.window.kill(), 
        desc="Kill focused window"),

    # Reload qtile config
    Key([mod, "shift"], "r", lazy.reload_config(), 
            desc="Reload the config"),

    # Kill qtile
    Key([mod, "shift"], "q", lazy.shutdown(), 
            desc="Shutdown Qtile"),

    # Change keyboard layout
    Key([mod, Lalt], "space", lazy.widget["keyboardlayout"].next_keyboard(),
            desc="Change keyboard layout."),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), 
        desc="Move focus to left"),

    Key([mod], "l", lazy.layout.right(), 
        desc="Move focus to right"),

    Key([mod], "j", lazy.layout.down(), 
        desc="Move focus down"),

    Key([mod], "k", lazy.layout.up(), 
        desc="Move focus up"),

    #Key([mod], "space", lazy.layout.next(), 
    #    desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), 
        desc="Move window to the left"),

    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), 
        desc="Move window to the right"),

    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), 
        desc="Move window down"),

    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), 
        desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), 
        desc="Grow window to the left"),

    Key([mod, "control"], "l", lazy.layout.grow_right(), 
        desc="Grow window to the right"),

    Key([mod, "control"], "j", lazy.layout.grow_down(), 
        desc="Grow window down"),

    Key([mod, "control"], "k", lazy.layout.grow_up(), 
        desc="Grow window up"),

    Key([mod], "period", lazy.layout.normalize(), 
        desc="Reset all window sizes"),

    Key([mod, "control"], "space", lazy.window.toggle_floating(),
        desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",),

    # Programs keybindings
    Key([mod], "Return", lazy.spawn(terminal), 
        desc="Launch terminal"),

    Key([mod, "shift"], "a", lazy.spawn("alacritty"), 
        desc="Launch alacritty terminal"),

    #Key([mod], "p", lazy.spawn("dmenu_run -i -p Run: "), 
    #    desc="Launch dmenu"),
    Key([mod], 'p', lazy.run_extension(extension.DmenuRun(
        dmenu_prompt="Run: ",
        dmenu_font="FantasqueSansMono Nerd Font",
        dmenu_height=46,  # Only supported by some dmenu forks
        desc="Launch dmenu",
    ))),

    Key([mod], "c", lazy.spawn(browser), 
        desc="Launch browser"),

    Key([mod, Lalt], "k", lazy.spawn("org.kde.kdenlive"), 
        desc="Launch kdenlive"),

    Key([mod, Lalt], "i", lazy.spawn("org.inkscape.Inkscape"), 
        desc="Launch inkscape"),

    Key([mod, Lalt], "o", lazy.spawn("com.obsproject.Studio"), 
        desc="Launch OBS Studio"),

    Key([mod, "shift"], "g", lazy.spawn("org.gimp.GIMP"), 
        desc="Launch gimp"),

    Key([mod, "shift"], "d", lazy.spawn("resolve"), 
        desc="Launch Resolve Studio"),

    Key([mod], "e", lazy.spawn("emacsclient -c"), 
        desc="New Emacs client window"),

    Key([mod], "n", lazy.spawn(["sh", "-c", "nsxiv -tor /home/hisham/Pictures/*"]), 
        desc="Change wallpaper"),

    Key([mod, "shift"], "s", lazy.spawn(["sh", "-c", "maim -B -u $HOME/.screenshots/Screenshot-$(date +%Y-%m-%d-%H-%M).png"]), 
        desc="Take a screenshot using maim"),

    Key([Lalt, "control"], "s", lazy.spawn(["sh", "-c", "mpv --shuffle /mnt/MISC/VIDEOS/*"]), 
        desc="Play a random clip with mpv"),

    Key([Lalt], "m", lazy.spawn(["sh", "-c", "mpv --cache=yes $(xclip -o -selection clipboard)"]), 
        desc="Play the copied link with mpv with caching"),

    Key([mod], "v", lazy.spawn("virt-manager"), 
        desc="Launch virt manager"),

    # dmenu scripts
    Key([Ralt], "1", lazy.spawn("dmenu_url.sh"), 
        desc="Open websites"),

    Key([Ralt], "2", lazy.spawn("dmenu_webSearch.sh"), 
        desc="Search the web"),

    Key([Ralt], "3", lazy.spawn("dmenu_kill.sh"), 
        desc="Kill tasks"),

    Key([Ralt], "5", lazy.spawn("dmenu_emoji.sh"), 
        desc="emoji chooser"),

    Key([Ralt], "7", lazy.spawn("movies.sh"), 
        desc="Play a random movie"),

    Key([Ralt], "Escape", lazy.spawn("dmenu_shutdown.sh"), 
        desc="Play a random movie"),

    Key([Ralt], "w", lazy.spawn("mpvWatch.sh"), 
        desc="Select and play video"),

    Key([Ralt], "s", lazy.spawn("dmenu_services.sh"), 
        desc="dmenu script to Start/Stop systemd services"),

    # Multimedia keys
    Key([],"XF86AudioRaiseVolume", lazy.spawn("amixer -D default sset Master 5%+"),
            desc="Increse volume by 5%"),

    Key([],"XF86AudioLowerVolume", lazy.spawn("amixer -D default sset Master 5%-"),
            desc="Decrease volume by 5%"),

    Key([],"XF86AudioMute", lazy.spawn("amixer -D default sset Master toggle"),
            desc="Mute/Unmute"),

    Key([],"XF86AudioNext", lazy.spawn("playerctl next"),
            desc="Next song"),

    Key([],"XF86AudioPrev", lazy.spawn("playerctl previous"),
            desc="Previous song"),

    Key([],"XF86AudioPlay", lazy.spawn("playerctl play-pause"),
            desc="Play/Pause"),

]

groups = [Group(i) for i in [
    "JAVRIS", "TARS", "MOTHER", "HAL", "SKYNET", "FRIDAY", "VOYAGER",
]]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
        # Switch to workspace N
        Key([mod], actual_key, lazy.group[group.name].toscreen()),
        # Send window to workspace N
        Key([mod, "shift"], actual_key, lazy.window.togroup(group.name))
    ])


layouts = [
    layout.MonadTall(
        margin=8,
        border_focus="#e83a3f",
        border_normal="#222222",
        border_width=2,
        ),

    layout.Columns(
        margin=8,
        border_focus_stack=["#d75f5f", "#8f3d3d"],
        border_width=4
        ),

    layout.Stack(num_stacks=2),

    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Open Sans",
    fontsize=24,
    padding=3,
)
extension_defaults = widget_defaults.copy()

decor = {
    "decorations": [
        RectDecoration(
            colour="#7a7a7a8b",
            radius=5,
            filled=True,
            padding_y=4,
            padding_x=0,
            clip=False,
            line_width=0
            )
    ],
}

spacer4 = widget.Spacer(length=4)
separator5 = widget.Sep(padding=10, linewidth=5, size_percent=50)

screens = [
    Screen(
        # Bottom bar
        bottom=bar.Bar(
            [
                widget.Spacer(length=16),

                widget.TaskList(
                    **decor,
                    borderwidth=0,
                    ),

                widget.Spacer(),

                widget.GenPollText(
                    **decor,
                    update_interval=1,
                    func=lambda: subprocess.check_output("prayer.sh").decode("utf-8").strip()
                    ), spacer4,
                
                widget.OpenWeather(
                    **decor,
                    app_key="8cc75d17134e5ae1a723b5a39e7b6850",
                    cityid="7647007",
                    format='{location_city}: {main_temp} °{units_temperature} {weather_details}',
                    language='es',
                    update_interval=1800,
                    ), spacer4,

                widget.NvidiaSensors(
                    **decor,
                    fmt='GPU: {}',
                    update_interval=30,
                    ), spacer4,

                widget.ThermalZone(
                    **decor,
                    zone = '/sys/class/thermal/thermal_zone1/temp',
                    fmt='CPU: {}',
                    update_interval=30,
                    ), spacer4,

                widget.GenPollText(
                    **decor,
                    update_interval=86400,
                    func=lambda: subprocess.check_output("knl_v.sh").decode("utf-8").strip()
                    ), spacer4,

                widget.CurrentLayout(
                    **decor,
                    ), spacer4,

                widget.Systray(
                    icon_size=36,
                    ),
                ],
            46,
            background="#212121e8",
            margin=[3,10,6,10]
            ),

        # Top bar
        top=bar.Bar(
            [
                widget.Spacer(length=4),

                widget.Image(
                    filename='~/.config/awesome/icons/logo2.0.png',
                    margin=3,
                ),

                widget.Spacer(length=4),

                widget.GroupBox(
                    **decor, 
                    borderwidth=0,
                    highlight_method='block',
                    rounded=True,
                    ),

                widget.Spacer(),

                widget.GenPollText(
                    **decor,
                    update_interval=10800,
                    func=lambda: subprocess.check_output("packages.sh").decode("utf-8").strip()
                    ), spacer4,

                widget.CPU(
                    **decor,
                    update_interval=10,
                    ), spacer4,

                widget.Memory(
                    **decor,
                    update_interval=10,
                    ), spacer4,

                widget.GenPollText(
                    **decor,
                    update_interval=60,
                    func=lambda: subprocess.check_output("uptime.sh").decode("utf-8").strip()
                    ), spacer4,

                widget.Volume(
                    **decor,
                    update_interval=10,
                    ), spacer4,

                widget.Clock(
                    **decor,
                    format="%Y-%m-%d %a %I:%M %p"), spacer4,

                widget.KeyboardLayout(
                    **decor,
                    configured_keyboards=['latam','ara']
                    ),

                widget.Spacer(length=16),
            ],
            46,
            background="#212121e8",
            margin=[3,10,6,10],
        ),
    ),
]

# Rule to open browsers on the second group
@hook.subscribe.client_new
def client_new(client):
    if client.name == 'firefox':
        client.togroup('TARS')

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="mpv"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
