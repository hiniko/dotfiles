export FZF_DEFAULT_OPTS="--layout=reverse --info=inline --height=80% --multi --preview='([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2>/dev/null | head -n 200' --preview-window=':hidden' --color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008' --prompt='∼ ' --pointer='▶' --marker='✓' --bind '?:toggle-preview' --bind 'ctrl-a:select-all' --bind 'ctrl-e:execute(vim {+} >/dev/tty)' --bind 'ctrl-v:execute(code {+})' --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'"

# Setup FZF keybindings
source <(fzf --zsh)