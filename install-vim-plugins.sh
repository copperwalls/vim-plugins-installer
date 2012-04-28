#!/bin/bash
# -- install-vim-plugins.sh ----------------------------------------------------
#
# This program comes with no warranty. Use at your own risk.
# You have been warned. (That said, it works well for me :)
#
# Copyright (c) 2012 ed.o
# include 'MIT-License.txt'
#
# See https://github.com/copperwalls/vim-plugins-installer
#
# ------------------------------------------------------------------------------
shopt -s -o nounset

# Will use as suffix for backup(s)
declare -rx NOW=$(date +%s)

# Default path
# (You probably know what you’re doing if you need to change this)
declare -rx DOTVIM_DIR="$HOME/.vim"
declare -rx DOTVIMRC="$HOME/.vimrc"

# Remember where we started
declare -rx ORIG_WORK_DIR=$PWD

# Change if desired. Only used if ~/.gitconfig does not exist
declare -rx GIT_EMAIL='ed.o@example.com'
declare -rx GIT_USERNAME='ed.o'

# GitHub URLs of the plugins to be installed. One URL/line.
# No checking here so ensure that the file exists!
declare -rx PLUGINS=$(grep -v ^# plugins.urls)

# Function to call when something is wrong
whoopsy () {
    echo
    echo >&2 "FATAL ERROR: $@ Aborting..."
    exit 192
}

# This won’t work without git; let’s check it first
which git > /dev/null 2>&1
[ $? -ne 0 ] && whoopsy 'Install git first!'

# Leave ~/.gitconfig alone if it exists, else create one
if [ ! -f '~/.gitconfig' ]; then
    git config --global user.email $GIT_EMAIL
    git config --global user.name $GIT_USERNAME
fi

# Leave ~/.vimrc alone if it exists, else use bundled sample
if [ ! -f "$DOTVIMRC" ]; then
    [ ! -f "$ORIG_WORK_DIR/dotvimrc" ] &&
        whoopsy 'Bundled "dotvimrc" file not found!'
    cp "$ORIG_WORK_DIR/dotvimrc" "$DOTVIMRC"
fi

# Leave ~/.vim alone if we already have pathogen.vim
if [ ! -f "$DOTVIM_DIR/autoload/pathogen.vim" ]; then
    # OK, we don’t have it. But do we have ~/.vim?
    # Yes? Why? Anyway, let’s start fresh. Make sure to create backups.
    # Creating backups is always good :)
    if [ -d "$DOTVIM_DIR" ]; then
        mv "$DOTVIM_DIR" "${DOTVIM_DIR}-old-$NOW"
    fi
    # The real party starts here =)
    mkdir -p "$DOTVIM_DIR"
    # Now install pathogen
    # Yeah, we could use curl or wget here but since we already have git...
    git clone git://github.com/tpope/vim-pathogen.git /tmp/pathogen
    mv /tmp/pathogen/autoload "$DOTVIM_DIR"
    rm -rf /tmp/pathogen
fi

# Let’s start working on the plugins now
cd "$DOTVIM_DIR"

# Let’s see if we’re in a new/fresh directory; initialize it for git if so
if [ ! -d '.git' ]; then
    git init
    git add .
    git commit -m "Initial commit"
fi

# Now let’s install all our favorite $PLUGINS
for PLUGIN in $PLUGINS
do
    USER=$(echo $PLUGIN | awk -F'/' '{ print $(NF - 1) }')
    PLUGIN_NAME=$(echo $PLUGIN | awk -F'/' '{ print $NF }')
    # I know, I know I’m being finicky here
    # I want my directory names in lowercase and without a .vim at the end :)
    PLUGIN_DIR_NAME=$(echo $PLUGIN_NAME | tr "[:upper:]" "[:lower:]")
    PLUGIN_INSTALL_DIR="bundle/${PLUGIN_DIR_NAME%.vim}"
    # Assume installed if directory exists; continue to next plugin if so
    [ -d "$PLUGIN_INSTALL_DIR" ] && continue
    echo
    git submodule -q \
      add git://github.com/$USER/$PLUGIN_NAME.git $PLUGIN_INSTALL_DIR
    git submodule -q init && git submodule -q update
done

# Last check. Exit if pathogen anything is set in ~/.vimrc
PATHOGEN_IN_DOTVIMRC=$(grep pathogen.infect "$DOTVIMRC")
[ -n "$PATHOGEN_IN_DOTVIMRC" ] && exit 0

# Otherwise, display a reminder:
cat <<EOE

Ensure that you at least have the following in your "$DOTVIMRC":

    call pathogen#infect()

See https://github.com/tpope/vim-pathogen for details.
EOE

#
# All done! Happy hacking!
# ---------------------------------------------------------------------- ed.o --
