# Sherman's Dotfiles

Use this repo to set up a new *nix system. 

It can currently handle:

* Installing and configuring `oh-my-zsh (omz)`  
    * with `Powerline10k`
    * with a number of plugins (`fzf` `ssh-agent` `zsh-syntax-hilighting`) 
    * with a nubmer of aliases that are helpful (see `zsh/aliases`)
* `tmux` configuration
    * lots of preferenes but binding the `tmux` escape sequence to `^a
* `git`
    * global git config 
        * missing user section pending a good way to change between work / home "profiles"
        * lots of useful aliases
            * `git hist` for a graph ouput
            * `git hr` hard reset to head
            * `git sr` soft reset to head