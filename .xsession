# Autostart useful programs
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &
xrdb merge ~/.Xresources &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
compfy &
#com.github.wwmm.easyeffects --gapplication-service -l normalize_output &
~/.fehbg &
nm-applet &
solaar -w hide &
#flameshot &
copyq &
udiskie -t &
#nextcloud &
#tint2 &
~/.local/bin/wacomConfig.sh &
emacs --daemon &
