#! /bin/sh
###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Shell opens with: /bin/bash
defaults write com.apple.Terminal Shell -string "/bin/bash"

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Set Solarized "Solarized Dark xterm-256color" as the default
TERM_PROFILE='Solarized Dark xterm-256color'
default wirte com.apple.Terminal 'Startup Window Settings' -string "${TERM_PROFILE}"
default write com.apple.Terminal 'Default Window Settings' -string "${TERM_PROFILE}"

# Use Option key as Meta key
defaults write com.apple.terminal useOptionAsMetakey -bool true

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
defaults write com.apple.terminal FocusFollowsMouse -bool true
defaults write org.x.X11 wm_ffm -bool true

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
