# Google Cloud SDK
local gcloud_dir=""
if [ -d "$HOME/google-cloud-sdk" ]; then
    gcloud_dir="$HOME/google-cloud-sdk"
elif [ -d "$HOME/Downloads/google-cloud-sdk" ]; then
    gcloud_dir="$HOME/Downloads/google-cloud-sdk"
fi
[ -n "$gcloud_dir" ] || return 0

[ -f "$gcloud_dir/path.zsh.inc" ] && source "$gcloud_dir/path.zsh.inc"
[ -f "$gcloud_dir/completion.zsh.inc" ] && source "$gcloud_dir/completion.zsh.inc"
