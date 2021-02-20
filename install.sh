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
    link_bashrc
}

function try_linking() {
    if [ -e "$1" ]
    then
        echo "skipping " $(target $1) ": " $(skip_reason $(target $1))
    else
        echo "linking " $(target $1)
        mkdir
    fi
}

function target() {
    echo $(readlink --canonicalize $(echo "~/." $1))
}

function skip_reason() {
    if [ -h $1 ]
    then
        echo "already linked"
    else
        echo "file already exists. deleted or move before reinstalling."
    fi

}

function link_bashrc() {
    echo "boop"
}

main
