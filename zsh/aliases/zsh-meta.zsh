alias edit_zshconfig="$EDITOR ~/.zshrc"
alias edit_ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias edit_dotfiles="$EDITOR $DOTFILES_PATH"

alias grabconf='function _grab_conf() {
    local filename="$1"
    local dest_folder="$2"
    
    # Ensure that both filename and destination folder are provided
    if [[ -z "$filename" || -z "$dest_folder" ]]; then
        echo "Usage: grab_conf <filename> <dest_folder>"
        return 1
    fi

    # Create the destination directory inside $DOTFILES_PATH
    local full_dest_folder="$DOTFILES_PATH/$dest_folder"
    mkdir -p "$full_dest_folder"

    # Copy the file to the destination folder
    cp "$filename" "$full_dest_folder"

    # Run the link script
    $EDITOR "$DOTFILES_PATH/link.sh"
}; _grab_conf'
