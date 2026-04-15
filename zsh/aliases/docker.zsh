# Docker
command -v docker &>/dev/null || return 0
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
docker-cleanup() { docker rm -f $(docker ps -a -q); }
