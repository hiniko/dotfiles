# Homebrew Python
[ -d /opt/homebrew/opt/python/libexec/bin ] || return 0
export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
