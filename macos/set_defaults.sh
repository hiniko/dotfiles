#!/bin/bash

## Find a list of defualts here: https://macos-defaults.com/dock/autohide.html
## You can also record and diff defualts using the `defaults_diff.sh` script

## Some of these settings require a log out or a reboot so at the end of this script
## we force a reboot

## Dock
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock "mineffect" -string "scale"
defaults write com.apple.dock "static-only" -bool "true" 
defaults write com.apple.dock "scroll-to-open" -bool "true" 


## Screenshots
defaults write com.apple.screencapture "disable-shadow" -bool "true"
mkdir ~/Screenshots
defaults write com.apple.screencapture "location" -string "~/Screenshots" 

## Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" 
defaults write com.apple.finder "AppleShowAllFiles" -bool "false" 
defaults write com.apple.finder "ShowPathbar" -bool "true" 
### Set default view to list view
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv" 
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true" 
### Do not open a new windows when opening a folder
defaults write com.apple.finder "FinderSpawnTab" -bool "false" 
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "true" 
### Change the size of the side bar icons and text
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1" 
## Desktop settings are a subset of finder
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true" 

## Menubar
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""

## Keyboard
### Set fn key to show emoji selector
defaults write com.apple.HIToolbox AppleFnUsageType -int "2"
### Use the F Keys as F Keys first
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
### Enable Tab / Shift-Tab menu navigation
defaults write NSGlobalDomain AppleKeyboardUIMode -int "0"

## Mission Control
defaults write com.apple.dock "expose-group-apps" -bool "true"
### Each display has it's own spaces
defaults write com.apple.spaces "spans-displays" -bool "true" 

## Activity monitor 
defaults write com.apple.ActivityMonitor "UpdatePeriod" -int "2" 

## MISC
### Do not "keep" windows when an app as been quit
defaults write NSGlobalDomain "NSQuitAlwaysKeepsWindow" -bool "false"

echo "Now restart your Mac for all settings to take effect"
sudo shutdown -r now
