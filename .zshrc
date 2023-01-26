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
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' %F{8}[%f%F{3}%b%f%F{8}]%f'
setopt PROMPT_SUBST
PROMPT='%F{8}[%f%F{8}%T%f%F{8}]%f %F{8}[%f%F{14}%~%f%F{8}]%f${vcs_info_msg_0_} %F{8}(%f%F{9}%?%f%F{8})%f%F{11}%#%f '
