#!/bin/bash

# Prompt for sudo access upfront
sudo -v

#################
# User settings #
#################

############
# Trackpad #
############

# Enable tap to click
defaults write -g com.apple.mouse.tapBehavior -int 1

# Enable three finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1

