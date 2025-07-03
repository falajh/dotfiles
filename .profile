setxkbmap -layout us,ara -option caps:super
TOUCHPAD=$(xinput list --name-only | grep -i touchpad)
xinput set-prop "$TOUCHPAD" "libinput Tapping Enabled" 0
#xset r rate 200 35
export XCURSOR_THEME=LyraQ-cursors
export TERMINAL="alacritty"
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"
export PAGER="bat --paging=always --style='changes'"
export FZF_DEFAULT_OPTS="--bind tab:down,shift-tab:up --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$XDG_DATA_HOME/go"
export XDG_SATE_HOME="$HOME/.local/state"
export SYSTEMD_PAGER=
