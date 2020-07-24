#!/bin/bash

# Prompt for sudo access upfront
sudo -v

#################
# User settings #
#################

## Set login picture
dscl . delete /Users/$(whoami) jpegphoto
dscl . delete /Users/$(whoami) Picture
sudo dscl . create /Users/$(whoami) Picture "$(pwd)/user-picture.png"

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES


