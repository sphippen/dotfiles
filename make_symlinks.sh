#!/usr/bin/env bash

set -e

SCRIPT_PATH=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

cd "$HOME"

for file in .zshrc .gitconfig .vimrc; do
  rm -f "$file"
  ln -s "$SCRIPT_DIR"/"$file" ./"$file"
done

rm -f .gitignore
ln -s "$SCRIPT_DIR"/.generic-gitignore ./.gitignore
