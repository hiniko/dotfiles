# direnv
command -v direnv &>/dev/null || return 0
eval "$(direnv hook zsh)"
