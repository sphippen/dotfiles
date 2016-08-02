autoload -U compinit promptinit
compinit
promptinit

setopt autocd
setopt autopushd
setopt rmstarwait
setopt extendedglob
setopt nohup
setopt zle
setopt vi
setopt promptsubst

export HISTSIZE=99999
export HISTFILE="$HOME/.zhistory"
export SAVEHIST="$HISTSIZE"
setopt histignorealldups
setopt histignorespace
setopt incappendhistory

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

function tmuxline() {
  if [ ! -z "$TMUX" ]; then
    name="$(tmux display-message -p '#S:#W')"
    echo "%F{magenta}%B[%b%F{yellow}tmux<$name>%F{magenta}%B]%b"
  fi
}

pline1='%F{magenta}%B[%b%F{cyan}%D{%y/%m/%d %T %Z(%z)}%F{magenta}%B]%b$(tmuxline)'
pline2='%F{magenta}%B<%b%F{red}%n@%m%F{magenta}:%F{green}%U%~%u%F{magenta}%B>%b'
pline3='%F{magenta}%B[%b%(2L_%F{cyan}%LL%F{magenta}|_)%(1j_%F{green}%jj%F{magenta}|_)%F{yellow}%h%F{magenta}%B]%b %F{black}%B%#%b%f '

PROMPT="$pline1
$pline2
$pline3"

RPROMPT='%(0?..%F{red}%B%?<-%f%b)'

# OS "Detection"
if [ $(uname -s) = "Darwin" ]; then
  TYPE="Mac"
elif [ $(uname -s) = "Linux" ]; then
  TYPE="Linux"
else
  echo "Couldn't determine OS type."
fi

# Aliases
if [ $TYPE = "Linux" ]; then
  alias colemak='setxkbmap us -variant colemak'
  alias qwerty='setxkbmap us'
  alias ls='LC_COLLATE=C ls -lbhF --color=auto'
  alias la='LC_COLLATE=C ls -lbhFA --color=auto'
elif [ $TYPE = "Mac" ]; then
  alias ls='ls -lbhFG'
  alias la='ls -lbhFGA'
fi

alias ez="vim ~/.zshrc"
alias sz=". ~/.zshrc"
alias grep="grep --color=auto"
alias grec="grep --color=always"
alias egrep="egrep --color=auto"
alias egrec="egrep --color=always"
alias lesc="less -R"
alias vi=vim
alias png=ping
alias pg='ping 8.8.8.8'
alias exeit=exit
alias eixt=exit
alias exti=exit
alias えぃｔ=exit
alias gdiff='git diff --no-index'

# Variables
export EDITOR=vim
export PATH="$HOME/bin:$PATH"

# Functions
function cv() {
  emulate -L zsh
  cd "$@" || exit 1

  if [ -e "$HOME/.zshnols" ]; then
    while read line; do
      printf "$PWD" | egrep -e "$line" &> /dev/null
      if [ $? -eq 0 ]; then
        return
      fi
    done < "$HOME/.zshnols"
  fi
  ls
}

[ ! -e "$HOME/.zshlocal" ] || . "$HOME/.zshlocal"
