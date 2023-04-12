#!/usr/bin/env bash

theme=$(ls ~/.config/awesome/themes/colorschemes | sed -e 's/\.conf//' | dmenu -i -l 5 -g 10 -p "Select a theme: ")

[ -z "$theme" ] && exit
sed -i "17s/'.*' .. '.conf'/'$theme' .. '.conf'/" ~/.config/awesome/themes/theme.lua

if [[ $theme == *"Dark"* ]]; then
    sed -i '7s/Light/Dark/' ~/.config/awesome/widgets/Weather_widget.lua
    sed -i '8s/light/dark/' ~/.config/awesome/widgets/Weather_widget.lua
    sed -i '4s/light/dark/ ; 5s/Light/Dark/' ~/.gtkrc-2.0
    sed -i '2s/light/dark/ ; 3s/Light/Dark/' ~/.config/gtk-3.0/settings.ini
    sed -i '/gtk-application-prefer-dark-theme/s/0/1/' ~/.config/gtk-3.0/settings.ini
    sed -i '/icon_theme/s/Light/Dark/' ~/.config/qt5ct/qt5ct.conf
    sed -i '/icon_theme/s/Light/Dark/' ~/.config/qt6ct/qt6ct.conf
    printf "[General]\ntheme=KvLibadwaitaDark" > ~/.config/Kvantum/kvantum.kvconfig
    sed -i '24s/lighter/darker/' ~/.config/nvim/init.vim
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    if [[ $theme == *"Material"* ]]; then
	kitty +kitten themes "Material Dark"
    elif [[ $theme == *"Doom"* ]]; then
	kitty +kitten themes "Doom One"
    elif [[ $theme == *"Dracula"* ]]; then
	kitty +kitten themes "Dracula"
    fi
    #feh --bg-fill $HOME/Pictures/NT-blur-dark.jpg 

    cd ~/.config/dmenu
    rm -f config.h
    sed -i '19s/Light/Dark/' config.def.h
    sudo make clean install

else
    sed -i '7s/Dark/Light/' ~/.config/awesome/widgets/Weather_widget.lua
    sed -i '8s/dark/light/' ~/.config/awesome/widgets/Weather_widget.lua
    sed -i '4s/dark/light/ ; 5s/Dark/Light/' ~/.gtkrc-2.0
    sed -i '2s/dark/light/ ; 3s/Dark/Light/' ~/.config/gtk-3.0/settings.ini
    printf "[General]\ntheme=KvLibadwaita" > ~/.config/Kvantum/kvantum.kvconfig
    sed -i '24s/darker/lighter/' ~/.config/nvim/init.vim
    sed -i '/gtk-application-prefer-dark-theme/s/1/0/' ~/.config/gtk-3.0/settings.ini
    sed -i '/icon_theme/s/Dark/Light/' ~/.config/qt5ct/qt5ct.conf
    sed -i '/icon_theme/s/Dark/Light/' ~/.config/qt6ct/qt6ct.conf
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    if [[ $theme == *"Material"* ]]; then
	kitty +kitten themes "Material"
    elif [[ $theme == *"Doom"* ]]; then
	kitty +kitten themes "Doom One Light"
    fi
    #feh --bg-fill $HOME/Pictures/NT-blur-light.jpg 

    cd ~/.config/dmenu
    rm -f config.h
    sed -i '19s/Dark/Light/' config.def.h
    sudo make clean install

fi
echo 'awesome.restart()' | awesome-client
