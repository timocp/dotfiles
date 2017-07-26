#! /bin/sh
#
# Symlinks all dotfiles into the home directory.

cd $(dirname $0)
for f in $(find . -type f -not -name $(basename $0) -a -not -name LICENSE | sed 's/^\.\///' | grep -v '^.git/'); do
    if [ -e $HOME/$f -a ! -h $HOME/$f ]; then
        echo -n "Overwrite regular file $HOME/$f (y/n)? "
        read answer
        if echo "$answer" | grep -iq "^y"; then
            rm -f $HOME/$f
        else
            continue
        fi
    fi
    ln -sfv $(pwd)/$f $HOME/$f
done
