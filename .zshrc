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

PROMPT="%F{magenta}%B[%b%F{cyan}%D{%y/%m/%d %T %Z(%z)}%F{magenta}%B][%b%F{yellow}%l%F{magenta}%B]%b
%F{magenta}%B<%b%F{red}%n@%m%F{magenta}:%F{green}%U%~%u%F{magenta}%B>%b
%F{magenta}%B[%b%(2L_%F{cyan}%LL%F{magenta}|_)%(1j_%F{green}%jj%F{magenta}|_)%F{yellow}%h%F{magenta}%B]%b %F{black}%B%#%b%f "
RPROMPT="%(0?..%F{red}%B%?↩%f%b)"

# OS "Detection"
if [ $(uname -s) = "Darwin" ]; then
  TYPE="Mac"
  alias ls="ls -GlbhF"
  alias la="ls -aGlbhF"
elif [ $(uname -s) = "Linux" ]; then
  TYPE="Linux"
  alias ls="LC_COLLATE=C ls -lbhF --color=auto"
  alias la="LC_COLLATE=C ls -albhF --color=auto"
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

# Hooks
function chpwd() {
  emulate -L zsh
  if [[ ! "$-" == *i* ]]; then
    return
  fi

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

[ -e "$HOME/.zshlocal" ] && . "$HOME/.zshlocal"
