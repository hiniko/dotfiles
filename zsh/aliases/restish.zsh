# Restish — adds dotfiles bin to PATH and exposes restish-sync helper.
# restish-sync probes per-api openapi versions before running `restish api sync`.

command -v restish >/dev/null 2>&1 || return 0

local restish_bin="${DOTFILES_PATH}/bin"
[[ -d "$restish_bin" && ":$PATH:" != *":$restish_bin:"* ]] && export PATH="$restish_bin:$PATH"
