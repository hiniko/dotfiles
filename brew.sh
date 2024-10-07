#!/bin/bash

is_not_installed() { ! command -v "$1" &> /dev/null; }

# Function to display usage
usage() {
    echo "Usage: $0 [-h] [-v] --no-apps"
    echo
    echo "Options:"
    echo "  --no-apps       Skip installation of applications"
    exit 1
}

# Default values
with_apps=1

# Parse options
while [[ "$1" != "" ]]; do
    case "$1" in
        -h | --help)
            usage
            ;;
        -f | --no-apps)
            with_apps=0
            ;;
        --) # End of all options
            shift
            break
            ;;
        *)
            break
            ;;
    esac
    shift
done

declare -a tools=("zsh" "bash" "fzf" "nvim" "direnv" "tree" "go" "npm")
declare -a apps=("alfred" "iterm2" "1password")

# Setup Brew
if is_not_installed "brew"; then 
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

declare -a to_install=("${tools[@]}")
if [[ $with_apps -eq 1 ]]; then 
  to_install+=("${apps[@]}")
fi

# Install tools and apps with brew
brew install "${to_install[@]}" 
