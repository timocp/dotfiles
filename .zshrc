# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tim/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Path with version control info
autoload -Uz vcs_info
precmd() { vcs_info }
sep='%F{8}|%f'
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats "%F{3}%b%f${sep}"
setopt PROMPT_SUBST
PROMPT='%F{10}%n%f%F{8}@%f%F{10}%m%f${sep}%F{12}%T%f${sep}%F{14}%~%f${sep}${vcs_info_msg_0_}%F{9}%?%f%F{11}%#%f '

# environment
export LC_COLLATE=C
export LESS="-aMiqRsS -j 5"
export PAGER=less

if command -v nvim &> /dev/null; then
  export EDITOR=nvim
elif command -v vim &> /dev/null; then
  export EDITOR=vim
else
  export EDITOR=vi
fi

# aliases
alias ..="cd .."
alias .rc="source ~/.zshrc"
alias be="bundle exec"
alias bigthings="du -sk * | sort -n"
alias gd="gitk &|"
alias gdc="git diff --cached"
alias gg="git grep"
alias gs="git status"
alias git-snap='git stash store $(git stash create)'
alias runningvms="VBoxManage list runningvms"
alias v=$EDITOR
alias vrc="$EDITOR ~/.zshrc"
alias xmlformat="xmllint -format"

# OS specifics
case "$OSTYPE" in
  linux*)
    alias l="/bin/ls -N --color=tty"
    alias la="/bin/ls -aN --color=tty"
    alias ls="/bin/ls -lN --color=tty"
    alias lsa="/bin/ls -alN --color=tty"
    ;;
  Darwin*)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    alias l="/bin/ls -G"
    alias la="/bin/ls -aG"
    alias ls="/bin/ls -lG"
    alias lsa="/bin/ls -alG"
    ;;
  *)
    echo "zshrc: Unhandled OS: $OSTYPE"
    ;;
esac

# get local (eg, work/home specific) aliases and other things
if [ -e ~/.zlocal ]; then
  source ~/.zlocal
fi

# ASDF runtime manager: https://asdf-vm.com/
if [ -d ~/.asdf ]; then
  source ~/.asdf/asdf.sh
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
  # initialise completions with ZSH's compinit
  autoload -Uz compinit && compinit
fi
