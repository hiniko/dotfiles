# Quick FZF powered select, commit and push of files
alias yeet='yeeet() {
    selected_files=($(git status -s | fzf --multi --ansi | awk "{print \$2}" | tr "\n" "\0" | xargs -0))

    if [ -z "$selected_files" ]; then
        echo "No files selected."
    else
        echo -n "Enter commit message: "
        read commit_message
        if [ -z "$commit_message" ]; then
            echo "Commit message cannot be empty."
        else
            for file in $selected_files; do
                git add "$file"
            done
            git commit -m "$commit_message" && \
            git push -u origin HEAD
        fi
    fi
}; yeeet'

# --- Git subcommand functions ---

# Show a graph of commit history
function _git_hist() {
    command git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative "$@"
}

# Create a new branch with the prefix "sherman/"
function _git_nb() {
    local branch_name="sherman/$(echo "$@" | tr ' ' '-')"
    command git switch -c "$branch_name"
}

# Soft reset to last commit
function _git_sr() {
    command git reset --soft HEAD^1
}

# Hard reset to last commit
function _git_hr() {
    command git reset --hard HEAD^1
}

# Push current branch to origin, creating if needed
function _git_up() {
    command git push -u origin HEAD
}

# Commit with the given message
function _git_c() {
    if [[ -z "$1" ]]; then
        echo "no commit message"
        return 1
    fi
    command git commit -m "$1"
}

# Amend the last commit with tracked changed files
function _git_rc() {
    command git add -u && command git commit --amend --no-edit
}

# Commit amend
function _git_ca() {
    command git commit --amend "$@"
}

# Backup branch before rebase
function _git_rebase() {
    local current_ref=$(command git rev-parse --abbrev-ref HEAD)
    local short_sha=$(command git rev-parse --short HEAD)
    local backup_name
    if [[ "$current_ref" == "HEAD" ]]; then
        backup_name="backup/${short_sha}"
    else
        backup_name="backup/${current_ref//\//-}-${short_sha}"
    fi
    command git branch "$backup_name" HEAD && \
    command git rebase "$@"
}

# --- Git wrapper ---
function git() {
    case "$1" in
        hist)   shift; _git_hist "$@" ;;
        nb)     shift; _git_nb "$@" ;;
        sr)     _git_sr ;;
        hr)     _git_hr ;;
        up)     _git_up ;;
        c)      shift; _git_c "$@" ;;
        rc)     _git_rc ;;
        ca)     shift; _git_ca "$@" ;;
        rebase) shift; _git_rebase "$@" ;;
        *)      command git "$@" ;;
    esac
}
