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
