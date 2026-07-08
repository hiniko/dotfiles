# Claude (local user bin)
[ -d "$HOME/.local/bin" ] || return 0
export PATH="$HOME/.local/bin:$PATH"
