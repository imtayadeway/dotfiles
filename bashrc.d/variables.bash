source $HOME/.bin/git-completion.sh

### variables
export DISPLAY=:0.0
export EDITOR="emacsclient -nw -c -a ''"
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export HISTSIZE=-1
export HISTFILESIZE=200000
export TERM="xterm-256color"
PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "

source "/usr/local/share/chruby/chruby.sh"
source "/usr/local/share/chruby/auto.sh"
chruby 2.5.3
