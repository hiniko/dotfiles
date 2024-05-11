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
