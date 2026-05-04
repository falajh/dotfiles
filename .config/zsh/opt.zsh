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
# export KEYTIMEOUT=0

#match menu
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cach-path ~/.local/cash/zsh
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
bindkey -v
