#!/usr/bin/env bash

resolution=(recording normal)
selected=$(printf '%s\n' "${resolution[@]}" | dmenu -i -p "Select your desired resolution ")

if [ $selected = "recording" ]; then
    sed -i '/dpi/s/144/192/' $HOME/.Xresources
    sed -i '4s/90/87/g' $HOME/.config/mpv/mpv.conf
    sed -i '/geometry.height/s/0.02/0.026/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/geometry.height/s/0.02/0.026/' $HOME/.config/awesome//ui/top_bar.lua
    sed -i '/Prayers_widget.x/s/0.92/0.898/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/WEATHER_WIDGET.x/s/0.92/0.898/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/quotes.x/s/0.92/0.898/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/quotes.y/s/0.6318/0.6368/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/Prayers_widget.y/s/0.275/0.232/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/WEATHER_WIDGET.y/s/0.92/0.898/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/bottom_bar.y/s/0.978/0.972/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/theme.font/s/11/10/' $HOME/.config/awesome/themes/theme.lua
    sed -i '/forced_width/s/0.058/0.075/' $HOME/.config/awesome/widgets/Cpu_widget.lua
    sed -i '/forced_width/s/0.04/0.05/' $HOME/.config/awesome/widgets/Packages_widget.lua
    sed -i '/forced_width/s/0.05/0.062/' $HOME/.config/awesome/widgets/Uptime_widget.lua
    sed -i '279s/0.24/0.283/' $HOME/.config/awesome/widgets/Prayers_widget.lua
    sed -i '280s/0.078/0.1/' $HOME/.config/awesome/widgets/Prayers_widget.lua
    sed -i '156s/0.078/0.1/' $HOME/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '157s/0.11/0.115/' $HOME/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '41s/0.078/0.1/' $HOME/.config/awesome/widgets/quotes.lua
    sed -i '10s/14/12/' $HOME/.config/kitty/kitty.conf
    #sed -i '/corner-radius/s/10.0/20.0/ ; /round-borders/s/10.0/20.0/' $HOME/.config/picom/picom.conf

    cd $HOME/.config/dmenu
    rm -f config.h
    sed -i '32s/46/56/' config.def.h
    sed -i '35s/3/4/' config.def.h
    sudo make clean install

elif [ $selected = "normal" ]; then
    sed -i '/dpi/s/192/144/' $HOME/.Xresources
    sed -i '4s/87/90/g' $HOME/.config/mpv/mpv.conf
    sed -i '/geometry.height/s/0.026/0.02/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/geometry.height/s/0.026/0.02/' $HOME/.config/awesome//ui/top_bar.lua
    sed -i '/Prayers_widget.x/s/0.898/0.92/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/WEATHER_WIDGET.x/s/0.898/0.92/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/quotes.x/s/0.898/0.92/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/quotes.y/s/0.6368/0.6318/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/Prayers_widget.y/s/0.232/0.275/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/WEATHER_WIDGET.y/s/0.898/0.92/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/bottom_bar.y/s/0.972/0.978/' $HOME/.config/awesome/ui/bottom_bar.lua
    sed -i '/theme.font/s/10/11/' $HOME/.config/awesome/themes/theme.lua
    sed -i '/forced_width/s/0.075/0.058/' $HOME/.config/awesome/widgets/Cpu_widget.lua
    sed -i '/forced_width/s/0.05/0.04/' $HOME/.config/awesome/widgets/Packages_widget.lua
    sed -i '/forced_width/s/0.062/0.05/' $HOME/.config/awesome/widgets/Uptime_widget.lua
    sed -i '279s/0.283/0.24/' $HOME/.config/awesome/widgets/Prayers_widget.lua
    sed -i '280s/0.1/0.078/' $HOME/.config/awesome/widgets/Prayers_widget.lua
    sed -i '156s/0.1/0.078/' $HOME/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '157s/0.115/0.11/' $HOME/.config/awesome/widgets/WEATHER_WIDGET.lua
    sed -i '41s/0.1/0.078/' $HOME/.config/awesome/widgets/quotes.lua
    sed -i '10s/12/14/' $HOME/.config/kitty/kitty.conf
    #sed -i '/corner-radius/s/20.0/10.0/ ; /round-borders/s/20.0/10.0/' $HOME/.config/picom/picom.conf

    cd $HOME/.config/dmenu
    rm -f config.h
    sed -i '32s/56/46/' config.def.h
    sed -i '35s/4/3/' config.def.h
    sudo make clean install
else exit 0
fi

xrdb -merge $HOME/.Xresources
echo 'awesome.restart()' | awesome-client
