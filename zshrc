#
# Dotfiles for Eddie
# Copyright (c) Eddie 2017
#

#autoload -Uz compinit promptinit utility
#compinit
#promptinit
#prompt paradox

export TERM=xterm-256color
export XDG_CONFIG_HOME=$HOME/.config
export RUST_SRC_PATH=/usr/local/src/rustc-1.7.0/src
if [ `which go` ]; then
  export GOPATH=~/go-dev
  export GOROOT=$(go env GOROOT)
  export PATH="${PATH}:$GOPATH/bin"
fi
if [ `which ros` ]; then
  export ROSWELL_INSTALL_DIR=$HOME/.roswell
fi
export PATH="${PATH}:$HOME/.local/bin"
export PATH="${PATH}:$HOME/.conscript/bin:/usrlib/jvm/default/bin"
export PATH="${PATH}:$HOME/.gem/ruby/2.3.0/bin"
export PATH="${PATH}:$ROSWELL_INSTALL_DIR/bin"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
if [ `which nvim` ]; then
  alias vim=nvim
fi

if [ ! `which exa` ]; then
  alias exa=ls
fi

alias ls=exa
alias l=ls
alias la="ls -a"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

echo -e "\t\e[1m\e[32m\"作りたいものを作るには結局大量のコードを書かないといけない\"\e[0m"
echo "                                                     \e[2m\e[32mrui ueyama\e[0m"
. /home/tamamu/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
