#! /bin/sh
#
# Symlinks all dotfiles into the home directory.

cd $(dirname $0)
for f in $(find . -type f -not -name $(basename $0) -a -not -name LICENSE | sed 's/^\.\///' | grep -v '^.git/'); do
    if [ -e $HOME/$f -a ! -h $HOME/$f ]; then
        diff -u "$HOME/$f" "$f"
        printf "Replace regular file %s with symlink (y/n)? " "$HOME/$f"
        read answer
        if echo "$answer" | grep -iq "^y"; then
            rm -f $HOME/$f
        else
            continue
        fi
    fi
    mkdir -p $HOME/$(dirname $f)
    ln -sfv $(pwd)/$f $HOME/$f
done
