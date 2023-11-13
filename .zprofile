#User directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

##System directories
export XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
export XDG_CONFIG_DIRES="/etc/xdg"
export ZDOTDIR=$HOME/.config/zsh
export STARSHIP_CONFIG=~/.config/starship/starship.toml

## Applications
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export KDEHOME="$XDG_CONFIG_HOME"/kde
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
##export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
##export XCOMPOSECACHE="$XDG_CACHE_HOME"/X11/xcompose
##export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
##export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export HISTFILE="$XDG_CACHE_HOME"/zsh/history
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
#export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

#Add .local/bin to the environment variables path
export PATH=$HOME/.local/bin:$HOME/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$HOME/Applications:/opt/resolve/bin:$HOME/.local/share/cargo/bin/:/usr/sbin:$PATH

# Unify the gtk and qt5 themes
export QT_QPA_PLATFORMTHEME="qt6ct"
#export QT_STYLE_OVERRIDE=kvantum
#export QT_SCALE_FACTOR=1.25
#export QT_AUTO_SCREEN_SCALE_FACTOR=0
export WLR_RENDERER_ALLOW_SOFTWARE=1

# Default applications
#export WM="awesome"
export EDITOR="nvim"
#export TERMINAL="kitty"
#export IMAGE="sxiv"
export VIDEO="mpv"

# nvidia specific EV
#export NVD_BACKEND="direct"
#export LIBVA_DRIVER_NAME="nvidia"

#export MOZ_GTK_TITLEBAR_DECORATION=client
#export MOZ_X11_EGL=1
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# Autostart useful programs
#dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &
#xrdb merge ~/.Xresources &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#picom &
#~/.fehbg &
#nm-applet &
#solaar -w hide &
##flameshot &
#QT_QPA_PLATFORM=xcb copyq &
#udiskie -t &
##nextcloud &
##tint2 &
#~/.local/bin/wacomConfig.sh &
#emacs --daemon &
