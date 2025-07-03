source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath+=(/usr/share/zsh/site-functions)
autoload -Uz compinit && compinit 
source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.config/zsh/dracula/zsh-syntax-highlighting.sh
typeset -gA FAST_HIGHLIGHT_STYLES
FAST_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
FAST_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
FAST_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
FAST_HIGHLIGHT_STYLES[function]='fg=yellow,bold'
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
setopt INC_APPEND_HISTORY       # Immediately append new commands to history file
setopt SHARE_HISTORY            # Share history across all sessions
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicate entries
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt HIST_VERIFY              # Show command with history expansion before running
setopt auto_cd
setopt HIST_IGNORE_SPACE    # Don't save commands starting with space
setopt EXTENDED_HISTORY     # Save timestamp
export KEYTIMEOUT=1

#match menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
bindkey -v
# curser
zle-keymap-select () {
	if [[ ${KEYMAP} == vicmd ]]; then
		echo -ne '\e[2 q' #block
	else
		echo -ne '\e[6 q' #thin
	fi
}
zle -N zle-keymap-select

zle-line-init () {
	zle -K viins
	echo -ne '\e[6 q' #thin 
}

zle -N zle-line-init


fuck(){
	sudo $(fc -ln -1)
}


syncd() {
	rsync -Pavh  --update\
		--exclude=".git/"\
		--include-from="$HOME/.config/sync.list.txt"\
		--exclude="*"\
		"$HOME"/ ~/code/dotfiles/
	}

export PATH="$PATH:/home/zaater/.local/bin"
export PATH="$PATH:$GOPATH/bin"
loadpy() {
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"

	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
}
export STARSHIP_CONFIG=/home/zaater/.config/starship/starship.toml
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
source ~/.alias.sh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
