# Go environment
command -v go &>/dev/null || return 0
export GOPATH="${HOME}/go"
export PATH="$GOPATH/bin:$PATH"
