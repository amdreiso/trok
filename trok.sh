#!/usr/bin/bash

themes=("dark" "light")
current_theme=0

ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.toml"
NVIM_CONFIG="$HOME/.config/nvim/lua/config/theme.lua"
POLYBAR_CONFIG="$HOME/.config/polybar/config.ini"

alacritty=("~/.config/alacritty/dark.toml" "~/.config/alacritty/light.toml")
polybar=("~/.config/polybar/dark.ini" "~/.config/polybar/light.ini")

nvim_background=("dark" "light") 
nvim_theme=("tokyonight" "alabaster")

if [ -z $1 ]; then
	echo "set - set current theme"
	echo "list - lists all themes"
	exit
fi

_set(){
	local index=$1
	local theme=${themes[$index]}

	echo "setting theme to:" $theme 

	# ALACRITTY CONFIG
	echo "general.import = ['${alacritty[$index]}']" > $ALACRITTY_CONFIG
	echo "setting alacritty to:" ${alacritty[$index]}

	# NVIM CONFIG
	sed -i "1s|.*|vim.o.background = \"${nvim_background[$index]}\"|" "$NVIM_CONFIG"
	sed -i "2s|.*|vim.cmd.colorscheme(\"${nvim_theme[$index]}\")|" "$NVIM_CONFIG"
	echo "setting nvim to: ${nvim_background[$index]} | ${nvim_theme[$index]}" 

	# POLYBAR CONFIG
	echo "include-file = ${polybar[$index]}" > $POLYBAR_CONFIG
	echo "setting polybar theme to: ${polybar[$index]}"
}

_list(){
	for i in ${themes[@]}; do
		echo $i
	done
}

if [ $1 = "list" ]; then 
	_list
	exit
fi

if [ $1 = "set" ]; then
	if [ -z $2 ]; then
		echo "Unspecified theme name"
		exit
	fi

	for ((i = 0; i < ${#themes[@]}; ++i)); do
		if [ ${themes[$i]} = $2 ]; then
			_set $i
			exit
		fi
	done

	echo "'" $2 "' does not exist as a theme"
fi

