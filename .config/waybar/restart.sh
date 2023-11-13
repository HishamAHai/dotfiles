#!/bin/sh

killall waybar
waybar -c $HOME/.config/waybar/config_right.jsonc & waybar -c $HOME/.config/waybar/config_left.jsonc -s $HOME/.config/waybar/style_left.css
#waybar -c $HOME/.config/waybar/left
