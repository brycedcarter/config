# this script is responsible for sourcing sub zsh configs

if [ -d "$HOME/config-work" ]; then
	declare -a sub_zshrc=("$HOME/.config-work/zshrc.sub" "$HOME/.vm-zshrc.sub");
	for filename in "${sub_zshrc[@]}"
	do
	if [ -f $filename ]; then
		source $filename
	fi
	done
fi
