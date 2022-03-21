#!/bin/bash

set -e

readonly DOTFILES=(
    ackrc
    agignore
    authinfo.gpg
    bashrc
    bashrc.d
    bin
    bundle/config
    config/redshift.conf
    emacs.d
    gemrc
    gitconfig
    gitignore
    gitmessage
    lein/profiles.clj
    mbsyncrc
    offlineimaprc
    offlineimap.py
    railsrc
    rubocop.yml
    rspec
    tmux.conf
)

function main() {
    for file in "${DOTFILES[@]}"; do
        try_linking $file
    done
}

function try_linking() {
    if [ -e "$(link_name $1)" ]
    then
        echo "skipping " $1 ": " $(skip_reason $1)
    else
        echo "linking " $(link_name $1)
	mkdir --parents $(dirname $(link_name $1))
        ln --symbolic $(link_target $1) $(link_name $1)
    fi
}

function link_target() {
    readlink --canonicalize ~/.dotfiles/"$1"
}

function link_name() {
    readlink --canonicalize-missing ~/."$1"
}

function skip_reason() {
    if [ -L "$HOME/.$1" ]
    then
        echo "already linked"
    else
        echo "file already exists. delete or move before reinstalling."
    fi

}

main
