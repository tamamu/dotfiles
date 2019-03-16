#
# Dotfiles for Eddie
# Copyright (c) Eddie 2017
#
#
if [[ -s $HOME/.zprezto/init.zsh ]]; then
  source $HOME/.zprezto/init.zsh
fi

autoload -Uz compinit promptinit utility
compinit
promptinit
prompt paradox

case ${OSTYPE} in
  darwin*)
    export LANG=ja_JP.UTF-8
    ;;
  linux*)
    export DefaultIMModule=fcitx
    ;;
esac
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt hist_expand

export TERM=xterm-256color
export XDG_CONFIG_HOME=$HOME/.config
export RUST_SRC_PATH=/usr/local/src/rustc-1.7.0/src

export EDITOR=nvim

exists() {
  which $1 > /dev/null 2>&1
}

# TMUX
if which tmux >/dev/null 2>&1; then
    # if no session is started, start a new session
    test -z ${TMUX} && tmux

    # when quitting tmux, try to attach
    while test -z ${TMUX}; do
        tmux attach || break
    done
fi

# Choose a line from a file
function fortune-line() {
  sed -n $(awk "BEGIN{srand(1);print int(1+rand()*(-1+$(wc -l $1 | tr -s ' ' | cut -d ' ' -f 1)))}")p $1
}

# Fuzzy history search
# Installation: pacman -S fzf
if exists fzf; then
  # Colored cat command
  # Installation: pacman -S bat
  if exists bat; then
    function preview() {
      fzf --preview 'bat --color "always" {}'
    }
    function preview-current-directory() {
      ls | preview
    }
    zle -N preview-current-directory
    bindkey '^S' preview-current-directory
  fi

  function fh() {
    zle -U "$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')"
  }
  zle -N fh
  bindkey '^R' fh
fi

if exists pyenv; then
  case ${OSTYPE} in
    darwin*)
      export PYENV_ROOT=/usr/local/var/pyenv
      eval "$(pyenv init -)"
      ;;
    linux*)
      ;;
  esac
fi

if exists ros; then
  export ROSWELL_INSTALL_DIR=$HOME/.roswell
fi
if [ -e $HOME/.cargo/env ]; then
  source $HOME/.cargo/env
fi
if [ -d /usr/local/cuda ]; then
  export PATH="${PATH}:/usr/local/cuda/bin"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/cuda/lib64"
  export C_INCLUDE_PATH="/usr/local/cuda/include"
fi
export PATH="${PATH}:$HOME/.local/bin"
export PATH="${PATH}:$HOME/.conscript/bin:/usrlib/jvm/default/bin"
export PATH="${PATH}:$(ruby -e 'print Gem.user_dir')/bin"
export PATH="${PATH}:$ROSWELL_INSTALL_DIR/bin"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
if exists nvim; then
  alias vim=nvim
fi

if exists exa; then
  alias ls=exa
fi

if exists htop; then
  alias top=htop
fi

alias l=ls
alias la="ls -a"

if [ -e $HOME/.env ]; then
  source $HOME/.env
fi

if exists opam; then
  . /home/tamamu/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

if [ -e $HOME/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [ -e $HOME/Flutter/bin ]; then
  export PATH=$HOME/Flutter/bin:$PATH
fi

if exists git; then
  function _git_status() {
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
      echo git status -sb
      git status -sb
    fi
    echo
    echo
    zle reset-prompt
  }
  zle -N git_status _git_status
  bindkey '^G^S' git_status
fi

# Projects Architecture
#
# - ~/Projects/
#   - src/ # managed by ghq
#   - bin/ # add to $PATH

if [ -e $HOME/.goenv ]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  if exists go ; then
    export GOPATH=$HOME/Projects
    export GOROOT=$(go env GOROOT)
    export PATH="${PATH}:$GOPATH/bin"
  fi
  if exists peco && exists ghq && exists hub ; then
    alias g='cd $(ghq root)/$(ghq list | peco)'
    alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
  fi
else
  echo "Install goenv"
fi

BASE16_SHELL=$HOME/.dotfiles/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

echo -e "\tTips: \e[1m\e[32m\"$(fortune-line $HOME/.dotfiles/tips)\"\e[0m"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
