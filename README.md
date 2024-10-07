# Sherman's Dotfiles

Use this repo to set up a new *nix system. 

It can currently setup:

* `brew.sh`
    * Installs basic tooling and applications to mac
* `link.sh`
    * create symbolic links to configs in directory to the home directory
    * will create backups of exsting files and folders if they already exist
* `oh-my-zsh (omz)`  
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
            * `git up` push to remote head ( useful to creating remote branches and syncing)
* `neovim`
    * IDE level config with LSP support 
    * currently needs install scripts for plugins to work OOTB
* `vim`
    * Older `vim` config with themes, and some plugins
    * also needs an install script for plugins to work
*  `fzf` fuzzy finder TUI config
    * needed because the brew install has default keybindings in a dir that the base config doesn't expect. These are handled by the `zsh` config anyway so it isn't a problem
