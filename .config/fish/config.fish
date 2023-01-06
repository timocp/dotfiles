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
alias xmlformat="xmllint -format"

if command -sq VBoxManage
    function shutdown-if-up
        set -l host $argv[1]
        set -l uuid $argv[2]
        echo "== Trying to shutdown $host ($uuid)"
        echo "VBoxManage list runningvms | grep $uuid"
        if VBoxManage list runningvms | grep $uuid
            if ssh $host w | grep " 0 users"
                ssh $host "sudo shutdown now"
            else
                echo "== Cannot shutdown $host, there are logged in users"
                return 1
            end
        else
            echo "== $host is not running"
        end
        return 0
    end

    function wait-for-vms
        echo "== Waiting for VMs to shut down"
        while true
            set -l count (VBoxManage list runningvms | wc -l)
            echo "Running VMs: $count"
            if [ $count = "0" ]
                break
            end
            sleep 1
        end
        echo "== All VMs stopped"
    end

    alias runningvms="VBoxManage list runningvms"
end

function .rc
    source ~/.config/fish/config.fish
    if test -e ~/.config/fish/conf.d/local.fish
        source ~/.config/fish/conf.d/local.fish
    end
end

function gd -d "Git diff"
  gitk &
  disown
end

# Other setup
# -----------

mkdir -p $HOME/.vim/{backup,swap}

git config --global alias.co "checkout"
git config --global init.defaultBranch main
git config --global pull.rebase false
