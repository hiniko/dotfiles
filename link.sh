#!/bin/bash
# Link configurations to the their rightful home. Will check and backup 
# existing configs

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

backup(){
	local FILE_PATH="$(dirname "$1")"
	local FILE_NAME="$(basename "$1")"
	# Check if file is a link, remove if it is else backup file
	[[ -L "$1" ]] || { echo "Backing up $2"; cp "$1" "${FILE_PATH}/${FILE_NAME}.bk"; }
	rm "$1"
}

unlink(){
	echo "Unlinking $1"
	rm "$1"
}

link(){
	[[ -e "$1" ]] || { echo "Config $1 does not exist" && exit 1; }
	[[ -e "$2" ]] && { backup "$2"; }
	[[ -h "$2" ]] && { unlink "$2"; }
	echo "Linking $1"
	ln -s "$1" "$2"
}

mkdir -p "${HOME}/.config/"

link "${DIR}/nvim/" 			"${HOME}/.config/nvim"
link "${DIR}/vim/vimrc" 		"${HOME}/.vimrc"
link "${DIR}/tmux/tmux.conf"  	"${HOME}/.tmux.conf"
link "${DIR}/git/gitconfig"   	"${HOME}/.gitconfig"
link "${DIR}/zsh/zshrc"       	"${HOME}/.zshrc"
link "${DIR}/zsh/p10k.zsh" 		"${HOME}/.p10k.zsh"
