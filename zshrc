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

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt hist_expand

export TERM=xterm-256color
export XDG_CONFIG_HOME=$HOME/.config
export RUST_SRC_PATH=/usr/local/src/rustc-1.7.0/src

exists() {
  which $1 > /dev/null 2>&1
}

if exists go ; then
  export GOPATH=~/go-dev
  export GOROOT=$(go env GOROOT)
  export PATH="${PATH}:$GOPATH/bin"
fi
if exists ros; then
  export ROSWELL_INSTALL_DIR=$HOME/.roswell
fi
if [ -d $HOME/.cargo ]; then
  source $HOME/.cargo/env
fi
if [ -d /usr/local/cuda ]; then
  export PATH="${PATH}:/usr/local/cuda/bin"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/cuda/lib64"
  export C_INCLUDE_PATH="/usr/local/cuda/include"
fi
export PATH="${PATH}:$HOME/.local/bin"
export PATH="${PATH}:$HOME/.conscript/bin:/usrlib/jvm/default/bin"
export PATH="${PATH}:$HOME/.gem/ruby/2.3.0/bin"
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

BASE16_SHELL=$HOME/.dotfiles/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

echo -e "\t\e[1m\e[32m\"作りたいものを作るには結局大量のコードを書かないといけない\"\e[0m"
echo "                                                     \e[2m\e[32mrui ueyama\e[0m"
