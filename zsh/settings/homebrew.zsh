# Homebrew setup — must be sourced before other modules that depend on brew paths
[ -f /opt/homebrew/bin/brew ] || return 0
eval "$(/opt/homebrew/bin/brew shellenv)"
