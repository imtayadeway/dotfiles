#!/bin/bash

set -e

function main() {
    install_dependencies
    install_postgresql
}

function install_dependencies() {
    sudo apt-get update &&
	sudo apt-get install --assume-yes git \
	     build-essential \
	     gnupg2 \
	     curl ca-certificates gnupg \
	     redis-server \
	     tree \
	     libsodium23 \
	     libgmime-3.0-dev libxapian-dev \
	     guile-2.2-dev html2text xdg-utils \
	     libwebkit2gtk-4.0-dev \
	     silversearcher-ag \
	     isync
}

function install_postgresql() {
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg >/dev/null
    sudo apt-get install --assume-yes postgresql-14 libpq-dev
    sudo -u postgres createuser --interactive
    sudo -u postgres createdb tim
    # update pg_hba.conf
}

function install_heroku() {
    curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
}


function setup_mail() {
    mkdir -p ~/mail/personal
    mbsync —all
}

main
