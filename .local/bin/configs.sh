#!/bin/sh

actions=(awesomeRC awesomeTh awesomeAps neovim qtile xmonadC xmobar ranger picom dunst lf kitty alacritty)

selected=$(printf '%s\n' "${actions[@]}" | dmenu -i -p "Action: ")

case "$selected" in
	awesomeRC) exec $TERMINAL  nvim $HOME/.config/awesome/rc.lua ;;
	awesomeAps) $TERMINAL  nvim $HOME/.config/awesome/apps.lua ;;
	awesomeTh) $TERMINAL  nvim $HOME/.config/awesome/themes/theme.lua ;;
	xmonadC) $TERMINAL  nvim $HOME/.xmonad/xmonad.hs ;;
	xmobar) $TERMINAL  nvim $HOME/.config/xmobar/xmobarrc ;;
	ranger) $TERMINAL  nvim $HOME/.config/ranger/rc.conf ;;
	picom) $TERMINAL  nvim $HOME/.config/picom/picom.conf ;;
	dunst) $TERMINAL  nvim $HOME/.config/dunst/dunstrc;;
    qtile) $TERMINAL nvim $HOME/.config/qtile/config.py;;
    lf) $TERMINAL nvim $HOME/.config/lf/lfrc;;
    kitty) $TERMINAL nvim $HOME/.config/kitty/kitty.conf;;
    alacritty) $TERMINAL nvim $HOME/.config/alacritty/alacritty.yml;;
    neovim) $TERMINAL nvim $HOME/.config/nvim/init.vim ;;
esac
