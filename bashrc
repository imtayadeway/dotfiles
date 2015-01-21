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
pathmunge $HOME/.rvm/bin after
pathmunge $HOME/.cask/bin after

### variables

export DISPLAY=:0.0

if [[ $(uname) == Darwin ]]; then
    export EDITOR="open -a Emacs"
else
    export EDITOR="emacsclient -nw -c -a ''"
fi

export LANG="en_US"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export HISTFILESIZE=20000

source $HOME/.bashrc.aliases
source $HOME/.bashrc.prompt

source $HOME/.rvm/scripts/rvm # load rvm

### local config settings, if any

if [ -e $HOME/.bashrc.local ]; then
  source $HOME/.bashrc.local
fi
