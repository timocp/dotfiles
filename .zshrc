# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colorize
  colored-man-pages
  debian
  emoji-clock
  encode64
  git-flow-avh
)

source $ZSH/oh-my-zsh.sh

# User configuration

typeset -U path
path+=($HOME/bin)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if command -v nvim &> /dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

unsetopt share_history

mkdir -p $HOME/.vim/{backup,swap}

export LC_COLLATE=C
export LESS="-aMiqRsS -j 5"
export PAGER=less

alias .rc="source ~/.zshrc"
alias be="bundle exec"
alias bigthings="du -sk * | sort -n"
alias feature="git flow feature"
alias ga="git add"
alias gb="git blame"
alias gdc="gd --cached"
alias gg="git grep"
alias gs="git status"
alias l="/bin/ls -N --color=tty"
alias la="/bin/ls -aN --color=tty"
alias ls="/bin/ls -lN --color=tty"
alias lsa="/bin/ls -laN --color=tty"
alias v=$EDITOR
alias vrc="$EDITOR ~/.zshrc"

sshaws() {
    key=$HOME/.keys/$1.pem
    if [ -e $key ]; then
        echo "Finding $1 by tags..."
        instance_id=$(aws ec2 describe-tags | jq -r '.Tags[] | select(.Key=="Name" and .ResourceType=="instance" and .Value=="'$1'").ResourceId')
        echo "Instance ID is $instance_id"
        public_dns_name=$(aws ec2 describe-instances --instance-id $instance_id | jq -r '.Reservations[0].Instances[0].PublicDnsName')
        echo "Public DNS is $public_dns_name"
        ssh -i $key ubuntu@$public_dns_name
    else
        echo "$key is missing"
    fi
}

gd() {
    git diff "$@" | gvim -c "set syntax=diff columns=122 buftype=nowrite" -
}

vf() {
    $EDITOR $(fzf)
}

# git grep -> fzf -> open selection
ggvim() {
    choice=$(gg "$@" | fzf -0 -1 --ansi --preview "cat {-1}")
    if [ ! -z "$choice" ]; then
        echo $EDITOR $choice
    fi
}

if command -v xdg-open &> /dev/null; then
    alias open=xdg-open
fi

# get local (eg, work/home specific) aliases and other things
if [ -e ~/.zlocal ]; then
    source ~/.zlocal
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
