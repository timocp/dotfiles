# Shell Stuff
set fish_greeting

set -l cargo_bin ~/.cargo/bin

contains /usr/sbin $fish_user_paths; or set -Ua fish_user_paths /usr/sbin
if test -d $cargo_bin
    contains $cargo_bin $fish_user_paths; or set -Ua fish_user_paths $cargo_bin
end

# Environment Variables
# ---------------------
set -gx LC_COLLATE C
set -gx LESS "-aMiqRsS -j 5"
set -gx PAGER less

if command -sq nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end

# Aliases & Functions
# -------------------
alias be="bundle exec"
alias bigthings="du -sk * | sort -n"
alias ga="git add -p"
alias gg="git grep"
alias gs="git status"
alias git-snap="git stash store (git stash create)"
alias l="ls"
alias v="$EDITOR"
alias vnc="vncserver -geometry 1366x768 -SecurityTypes X509Vnc :1"
alias vrc="$EDITOR ~/.config/fish/config.fish"
alias vlocal="$EDITOR ~/.config/fish/conf.d/local.fish"

function .rc
    source ~/.config/fish/config.fish
    source ~/.config/fish/conf.d/local.fish
end

function gd -d "Git diff into gvim"
  git diff $argv | gvim -c "set syntax=diff columns=122 buftype=nowrite" -
end

# Other setup
# -----------

mkdir -p $HOME/.vim/{backup,swap}

git config --global alias.co "checkout"
git config --global init.defaultBranch main
git config --global pull.rebase false
