#!/bin/sh

# What distro are we using
distro=$(awk -F "=" '/NAME/ {gsub(/"/,"");split($2, arr, " ");print(arr[1]);exit}' /etc/os-release)

# Choose the right package manager depending on the distro
case $distro in
    "Arch")
	       ins_pkg=$(pacman -Qq | wc -l)
	       upd_pkg=$(checkupdates | wc -l)  # It requires pacman-contrib to be installed
	       ;;
    "Fedora")
	       ins_pkg=$(dnf list --installed | wc -l)
	       upd_pkg=$(dnf check-update | wc -l)
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

# Print the results
echo "📦 $upd_pkg ($ins_pkg)"
