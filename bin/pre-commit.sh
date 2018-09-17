#! /bin/sh
# Git pre-commit hook to check for bad patterns in files
#
# Installation
#
#   ln -s /path/to/pre-commit.sh /path/to/project/.git/hooks/pre-commit
#
# Based on
#
#   https://gist.github.com/alexbevi/3436040
#   http://codeinthehole.com/writing/tips-for-using-a-git-pre-commit-hook/
#   http://mark-story.com/posts/view/using-git-commit-hooks-to-prevent-stupid-mistakes
#   https://gist.github.com/3266940

STOP_COMMIT="0"

verify_commit () {
    files_pattern=$1
    forbidden=$2
    git diff --cached --name-only | \
        grep -E $files_pattern | \
        GREP_COLOR='4;5;37;41' xargs grep --color --with-filename -n $forbidden && \
        STOP_COMMIT=1
}

verify_commit '\.(rb|haml|coffee|erb)(\..+)?$' 'binding.pry'
verify_commit '\.js$' 'debugger'
verify_commit '\.js$' 'console\.'

if [ "$STOP_COMMIT" -eq "1" ]; then
    echo 'COMMIT REJECTED'
    exit 1
fi

exit 0
