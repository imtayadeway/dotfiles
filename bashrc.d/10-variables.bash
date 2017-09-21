source $HOME/.bin/git-completion.sh

### variables
export DISPLAY=:0.0
export EDITOR="emacsclient -nw -c -a ''"
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export HISTFILESIZE=20000
export TERM="xterm-256color"
export PGUSER=root
PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "

source "/usr/local/share/chruby/chruby.sh"
source "/usr/local/share/chruby/auto.sh"
chruby 2.4.2

### local config settings, if any
if [ -e $HOME/.bashrc.local ]; then
  source $HOME/.bashrc.local
fi
