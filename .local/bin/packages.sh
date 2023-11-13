#!/bin/sh

# What distro are we using
distro=$(awk -F "=" '/NAME/ {gsub(/"/,"");split($2, arr, " ");print(arr[1]);exit}' /etc/os-release)

## Choose the right package manager depending on the distro
case $distro in
    "Arch")
	    ins_pkg=$(pacman -Qq | wc -l)
	    upd_pkg=$(checkupdates | wc -l)  # It requires pacman-contrib to be installed
	    ;;
    "Fedora")
	    ins_pkg=$(dnf list --installed | wc -l)
	    upd_pkg=$(dnf check-update | wc -l)
	    ;;
    "Void")
	    ins_pkg=$(xbps-query -l | wc -l)
	    upd_pkg=$(xbps-checkvers -D /var/cache/xbps | wc -l)
	    ;;
    "Debian" | "Ubuntu" | "Linux") #Linux here refers to Linux Mint
	    ins_pkg=$(apt list --installed | wc -l)
	    upd_pkg=$(apt list --upgradable | wc -l)
	    ;;
    "openSUSE")
	    ins_pkg=$(zypper search --installed-only | wc -l)
	    upd_pkg=$(zypper list-updates | wc -l)
	    ;;
esac
#
#Change the color depending on the number of available updaates
#These clases will be used later in the style.css file of waybar
if [[ $upd_pkg -le "5" ]]; then
    class="low"
elif [[ $upd_pkg -le "10" ]]; then
    class="med"
else
    class="high"
fi
## Print the results
    # if using i3 or other X11 window manager bar, print the output as
    # a plain text
if [[ "$XDG_SESSION_TYPE" = "x11" ]]; then
    echo "📦 $upd_pkg ($ins_pkg)"

    # Else if using waybar print the output as json formatted text
elif [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    printf '{"text": "%s", "class": "%s"}\n' "📦 $ins_pkg ($upd_pkg)" "$class"
fi
