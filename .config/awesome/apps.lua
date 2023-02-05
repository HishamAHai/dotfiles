local awful = require('awful')

local apps = {
    browser = 'chromium-freeworld',
	editor	= os.getenv('EDITOR') or 'nvim',
	fmanager = 'pcmanfm',
	geditor	= 'geany',
	launcher = 'dmenu_run -i -p "Run:"',
	rofi = 'rofi -show drun',
	lock	= 'i3lock',
	mplayer	= 'spotify',
	screenshot	=	'maim -B -u $HOME/.screenshots/"Screenshot-"$(date +%Y-%m-%d-%H-%M).png',
	terminal = 'wezterm',
	vplayer	= 'mpv',
	vector	= 'inkscape',
	ssh	= 'filezilla',
	wallpaper = 'nsxiv -tor /mnt/SSD/Pictures/*'
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
      --'nitrogen --restore',
      --'picom --experimental-backends',
      --'lxsession',
  }

  for _,apps in pairs(startup_apps) do
      run_once(apps)
  end
end


return apps
