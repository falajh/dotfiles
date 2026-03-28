# zle-keymap-select () {
# 	if [[ ${KEYMAP} == vicmd ]]; then
# 		echo -ne '\e[2 q' #block
# 	else
# 		echo -ne '\e[6 q' #thin
# 	fi
# }
# zle -N zle-keymap-select
#
# zle-line-init () {
# 	zle -K viins
# 	echo -ne '\e[6 q' #thin 
# }
# zle -N zle-line-init

sub-shell() {
	CURSOR=0
	if [[ $BUFFER != "" ]]; then
		BUFFER=" \$(${BUFFER})"
	else
		local cmd="$(fc -ln -1)"
		BUFFER=" \$(${cmd})"
	fi
}
zle -N sub-shell
bindkey '^o' sub-shell

fuck(){
	sudo $(fc -ln -1)
}

syncd() {
	rsync -Pavh  --update\
		--include-from="$HOME/.config/sync.list.txt"\
		--exclude="*"\
		"$HOME"/ ~/code/dotfiles/
}
