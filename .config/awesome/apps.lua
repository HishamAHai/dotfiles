local awful = require('awful')

local apps = {
    browser = 'chromium-freeworld',
	editor	= os.getenv('EDITOR') or 'nvim',
	fmanager = 'pcmanfm',
	geditor	= 'geany',
	launcher = 'dmenu_run -i -l 5 -g 10 -p "Run:"',
	rofi = 'rofi -show drun',
	lock	= 'i3lock',
	mplayer	= 'spotify',
	screenshot	=	'maim -B -u $HOME/.screenshots/"Screenshot-"$(date +%Y-%m-%d-%H-%M).png',
	terminal = 'kitty',
	vplayer	= 'mpv',
	vector	= 'inkscape',
	ssh	= 'filezilla',
	wallpaper = 'nsxiv -tor /mnt/ssd/Pictures/*'
}
local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
        findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd), false)
end

do
  local startup_apps=
  {
'dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY',
'xrandr --output DP-4 --primary --right-of DP-2',
'xrdb merge ~/.Xresources',
'setxkbmap -model pc104 -layout latam,ara -variant deadtilde, -option grp:ctrl_space_toggle',
'/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1',
'picom',
'~/.fehbg',
'nm-applet',
'solaar -w hide',
--'flameshot &',
'copyq',
'udiskie -t',
--'nextcloud &',
--'tint2 &',
'~/.local/bin/wacomConfig.sh',
'emacs --daemon',
  }

  for _,apps in pairs(startup_apps) do
      run_once(apps)
  end
end


return apps
