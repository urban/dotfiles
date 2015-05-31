#!/usr/bin/env bash

# References & Resources:
# - https://github.com/dstroot/.osx/
# — http://mths.be/osx

# NOTE: How to track changes to create your own commands:
#
# $ defaults read > a
# ---- Change a setting, then: ----
# $ defaults read > b
# $ diff a b
#
# Doing this creates files called a and b, then displays the difference between
# them. With this knowledge you can then open up the file b in Sublime Text 2,
# search for the bit that changed and try and work out the command to change
# it.
# -----------------------------------------------------------------------------
#
progname=$0
ver="1.0"

# identify yourself
echo "Running: $progname, version $ver."

# Set continue to false by default
CONTINUE=false

echo "Do you want to override your computers current settings? (y/n)"
read -r response
case $response in
  [yY])
  CONTINUE=true
esac

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  echo "Aborting!"
  exit
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osx_defaults.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Process configuration                                                       #
###############################################################################

# where we keep our defaults
DOTFILES=${HOME}/.dotfiles/
FILES=${DOTFILES}/osx/*

for f in $FILES; do
  echo ""
  echo "==================================================="
  echo " Processing $(basename $f) configuration"
  echo "==================================================="
  echo ""
  sh $f
done

###############################################################################
# Kill affected applications                                                  #
###############################################################################

echo ""
echo "==================================================="
echo " Restart affected applications"
echo "==================================================="
echo ""

applications=(
  "Activity Monitor"
  "Address Book"
  "Calendar"
  "Contacts"
  "cfprefsd"
  "Dock"
  "Finder"
  "Mail"
  "Messages"
  "Safari"
  "Divvy"
  "SystemUIServer"
  "Terminal"
  "Transmission"
  "Twitter"
  "iCal"
)

for app in "${applications[@]}"; do
	killall "${app}" > /dev/null 2>&1
done

echo "All done!"
echo "Note: some of these changes require a logout/restart to take effect."

exit 0
