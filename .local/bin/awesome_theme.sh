#!/usr/bin/env bash

theme=$(ls ~/.config/awesome/themes/colorschemes | sed -e 's/\.conf//' | dmenu -i -l 5 -g 10 -p "Select a theme: ")

[ -z "$theme" ] && exit
sed -i "17s/'.*' .. '.conf'/'$theme' .. '.conf'/" ~/.config/awesome/themes/theme.lua

if [[ $theme == *"Dark"* ]]; then
    sed -i '6s/Light/Dark/ ; 7s/light/dark/' ~/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '4s/light/dark/ ; 5s/Light/Dark/' ~/.gtkrc-2.0
    sed -i '2s/light/dark/ ; 3s/Light/Dark/' ~/.config/gtk-3.0/settings.ini
    printf "[General]\ntheme=KvLibadwaitaDark" > ~/.config/Kvantum/kvantum.kvconfig
    sed -i '4s/Light/Dark/' ~/.config/qt5ct/qt5ct.conf
    sed -i '24s/lighter/darker/' ~/.config/nvim/init.vim
    sed -i '2s/false/true' ~/.config/gtk-3.0/settings.ini
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
    sed -i '17s/Light/Dark/' config.def.h
    sudo make clean install

else
    sed -i '6s/Dark/Light/ ; 7s/dark/light/' ~/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '4s/dark/light/ ; 5s/Dark/Light/' ~/.gtkrc-2.0
    sed -i '2s/dark/light/ ; 3s/Dark/Light/' ~/.config/gtk-3.0/settings.ini
    printf "[General]\ntheme=KvLibadwaita" > ~/.config/Kvantum/kvantum.kvconfig
    sed -i '4s/Dark/Light/' ~/.config/qt5ct/qt5ct.conf
    sed -i '24s/darker/lighter/' ~/.config/nvim/init.vim
    sed -i '2s/true/false' ~/.config/gtk-3.0/settings.ini
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    if [[ $theme == *"Material"* ]]; then
	kitty +kitten themes "Material"
    elif [[ $theme == *"Doom"* ]]; then
	kitty +kitten themes "Doom One Light"
    fi
    #feh --bg-fill $HOME/Pictures/NT-blur-light.jpg 

    cd ~/.config/dmenu
    rm -f config.h
    sed -i '17s/Dark/Light/' config.def.h
    sudo make clean install

fi
echo 'awesome.restart()' | awesome-client
