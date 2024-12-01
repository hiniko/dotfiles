# Sherman's Dotfiles

Use this repo to set up a new *nix system. 

It can currently do 

* `link.sh`
    * create symbolic links to configs in directory to the home directory
    * will create backups of exsting files and folders if they already exist

* macOS Tools and Application installation
    * Uses a `Brewfile` to install from brew, casks and mas (mac app store) taps 
    * Uses `set_defaults.sh` to configure a bunch of preferences from Finder to Screenshots

* Configure `oh-my-zsh (omz)`  
    * with `Powerline10k`
    * with a number of plugins (`fzf` `ssh-agent` `zsh-syntax-hilighting`) 
    * with a nubmer of aliases that are helpful (see `zsh/aliases`)

* Configure `tmux` 
    * lots of preferenes but binding the `tmux` escape sequence to `^a

* Configure `git`
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

* Configure `neovim`
    * IDE level config with LSP support 
    * Has autoamted packet setup and hash based plugin installation for a good OOTB 
        * Should be able to run nvim and everything just work on first / second run 

*  Configure `fzf` fuzzy finder TUI config
    * needed because the brew install has default keybindings in a dir that the base config doesn't expect. These are handled by the `zsh` config anyway so it isn't a problem
