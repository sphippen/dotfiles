#!/usr/bin/env bash

SCRIPT_PATH=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

for file in .zshrc .gitconfig .vimrc; do
  rm -f "$HOME/$file"
  ln -s "$SCRIPT_DIR/$file" "$HOME/$file"
done

rm -f "$HOME/.gitignore"
ln -s "$SCRIPT_DIR/.generic-gitignore" "$HOME/.gitignore"

##############
# Tmux
##############
which tmux &>/dev/null && ( tmux -V | grep 'tmux 2' )

if [ $? -eq 0 ]; then
  TMUX_CONF=.tmux.2.conf
else
  TMUX_CONF=.tmux.conf
fi

rm -f "$HOME/.tmux.conf"
ln -s "$SCRIPT_DIR/$TMUX_CONF" "$HOME/.tmux.conf"

##############
# Thunderbird
##############
for dir in "$HOME/.thunderbird/"*.default; do
  [ -d "$dir" ] || continue
  mkdir -p "$dir/chrome"
  ln -s "$SCRIPT_DIR/userChrome.css" "$dir/chrome/userChrome.css"
done
