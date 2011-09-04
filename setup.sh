#!/bin/sh
cd $(dirname $0)
for dotfile in *
do
    if [ $dotfile != '.' ] && [ $dotfile != '..' ] \
        && [ $dotfile != '.git' ] && [ $dotfile != 'setup.sh' ]
    then
        ln -Fis "$PWD/$dotfile" "$HOME/.$dotfile"
    fi
done
