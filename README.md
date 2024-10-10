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
    * Conditional Work / Personal Config
        * Uses conditional includes of configs
        * `work.gitconfig` is in effect in `~/Work` based repos
        * `personal.gitconfig` is in effect in `~/Personal` based repos
        * `global_ignore` is used everywhere for the pesky files
* `neovim`
    * IDE level config with LSP support 
    * Has autoamted packet setup and hash based plugin installation for a good OOTB 
        * Shoudl be able to run nvim and everything just work on first / second run 

*  `fzf` fuzzy finder TUI config
    * needed because the brew install has default keybindings in a dir that the base config doesn't expect. These are handled by the `zsh` config anyway so it isn't a problem
