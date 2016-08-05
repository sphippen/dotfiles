#!/usr/bin/env bash

SCRIPT_PATH=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

####################
# OS Detection
####################
if [ $(uname -s) = "Darwin" ]; then
  TYPE=Mac
elif [ $(uname -s) = "Linux" ]; then
  TYPE=Linux
else
  echo "Couldn't determine OS type."
  exit 1
fi

####################
# Generic
####################
for file in .zshrc .gitconfig .vimrc; do
  ln -fs "$SCRIPT_DIR/$file" "$HOME/$file"
done

####################
# Gitignore
####################
ln -fs "$SCRIPT_DIR/.generic-gitignore" "$HOME/.gitignore"

####################
# Tmux
####################
which tmux &> /dev/null && ( tmux -V | grep 'tmux 2' &> /dev/null )

if [ $? -eq 0 ]; then
  TMUX_CONF=.tmux.2.conf
else
  TMUX_CONF=.tmux.conf
fi

ln -fs "$SCRIPT_DIR/$TMUX_CONF" "$HOME/.tmux.conf"


####################
# Linux-specific
####################
if [ "$TYPE" = Linux ]; then

####################
# Fontconfig
####################
mkdir -p "$HOME/.config/fontconfig"
ln -fs "$SCRIPT_DIR/fonts.conf" "$HOME/.config/fontconfig/fonts.conf"

####################
# Thunderbird
####################
for dir in "$HOME/.thunderbird/"*.default; do
  [ -d "$dir" ] || continue
  mkdir -p "$dir/chrome"
  ln -fs "$SCRIPT_DIR/userChrome.css" "$dir/chrome/userChrome.css"
done

####################
# fcitx
####################
# -print because no spaces allowed...
for f in $(find fcitx -type f -print); do
  dest="$HOME/.config/$f"
  mkdir -p "$(dirname "$dest")"
  ln -fs "$SCRIPT_DIR/$f" "$dest"
done

fi
