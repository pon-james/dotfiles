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


############
# Trackpad #
############

# Enable tap to click
defaults write -g com.apple.mouse.tapBehavior -int 1

# Enable three finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1

