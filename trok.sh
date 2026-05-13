
#!/usr/bin/bash

themes=("dark" "light")
current_theme=0

ALACRITTY_CONFIG="/home/andy/.config/alacritty/alacritty.toml"
alacritty=("~/.config/alacritty/dark.toml" "~/.config/alacritty/light.toml")

if [ -z $1 ]; then
	echo "set - set current theme"
	echo "list - lists all themes"
	exit
fi

_set(){
	local index=$1
	local theme=${themes[$index]}

	echo "setting theme to:" $theme 

	echo "general.import = ['"${alacritty[$index]}"']" > $ALACRITTY_CONFIG
	echo "setting alacritty to:" $theme
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

