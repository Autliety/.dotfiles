# .bashrc
# Last updated by Auly at 2020/6/8
# branch: Master (macOS)

# Get global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Get user specific programs
export PATH=/usr/local/sbin:$HOME/bin:$PATH
# Edit PS1 behavior
export PS1='\n\[\e[0;32m\][\A] \u\[\e[33m\]@\h: \[\e[31m\]\w \[\e[35m\] \[\e[33m\]\n\$\[\e[0m\] '
# Set vim as default editor
export EDITOR='vim'
# aliases
alias ls='ls -F --color'
alias la='ls -A --color'
alias ll='ls -lha --color'
alias cp='command cp -aiv'
alias mv='command mv -iv'
alias ..='cd ..'

alias vi='vim'
alias cls='clear'
alias refresh='source ~/.bash_profile'

# cd-pwd-ls
function cd() {
    command cd $@
    pwd
    ls
}
