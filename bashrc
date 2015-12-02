#!/bin/bash

source $HOME/.bin/git-completion.sh

### path
pathmunge () {
  if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH=$PATH:$1
    else
      PATH=$1:$PATH
    fi
  fi
}

pathmunge /usr/local/sbin
pathmunge /usr/local/bin
pathmunge /usr/local/heroku/bin
pathmunge /sbin after
pathmunge $HOME/bin after
pathmunge $HOME/.rvm/bin after
pathmunge $HOME/.cask/bin after
pathmunge $HOME/.bin after

### variables
export DISPLAY=:0.0
export EDITOR="emacsclient -nw -c -a ''"
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export HISTFILESIZE=20000
export TERM="xterm-256color"
PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "

source $HOME/.bashrc.aliases
source $HOME/.bashrc.prompt
source $HOME/.bashrc.utils
source "/usr/local/share/chruby/chruby.sh"
source "/usr/local/share/chruby/auto.sh"
chruby 2.2.3

### local config settings, if any
if [ -e $HOME/.bashrc.local ]; then
  source $HOME/.bashrc.local
fi
