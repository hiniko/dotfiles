# dbt shell completions
[ -f ~/.dbt-completion.bash ] || return 0
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source ~/.dbt-completion.bash
