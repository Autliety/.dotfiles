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
export PS1='\n\[\e[0;32m\][\A] \u\[\e[33m\]@\h: \[\e[31m\]\w \[\e[35m\]$(proxy ps1)$(__git_ps1) \[\e[33m\]\n\$\[\e[0m\] '
# Set up basic colors on [ls]
export CLICOLOR=true
export LSCOLORS='gxfxcxdxbxegedabagacad'
# Set vim as default editor
export EDITOR='vim'
# aliases
alias ls='ls -F'
alias la='ls -A'
alias ll='ls -lha'
alias cp='command cp -aiv'
alias mv='command mv -iv'
alias ..='cd ..'

alias vi='vim'
alias cls='clear'
alias refresh='source ~/.bash_profile'

# Include git-prompt setting 
source /usr/local/etc/bash_completion.d/git-prompt.sh
# cd-pwd-ls
function cd() {
    command cd $@
    pwd
    ls
}
# Disable rm command
function rm() { 
    echo '[rm] is disabled by some reason. '
    echo 'Please use [dl] instead. ' 
}
# Delete and restore files, instead of rm
function dl() {
    if [ ! -d $HOME/.Trash ]; then
        mkdir $HOME/.Trash
    fi
    if [ ! $1 ]; then
        echo 'Move file to trashbin. Usage: dl <filename>...'
        return 1
    fi
        command mv -fv $@ ~/.Trash
}
function ld() {
    if [ ! $1 ]; then
        echo 'Restore file from trashbin. Usage: ld <filename>...'
        return 1
    fi
    for f in $@; do
        command mv -iv ~/.Trash/$f ./
    done
}
# Setup proxy connection
function proxy() {
    case $1 in 
        'off')
            unset ALL_PROXY HTTP_PROXY HTTPS_PROXY prx_con
            ;;
        'socks')
            export ALL_PROXY='socks5://localhost:1080'
            export prx_con=$(curl ipinfo.io/country)
            if [[ ! $prx_con ]]; then
                 unset ALL_PROXY prx_con
                return 1
            fi
            ;;
        'http')
            export HTTP_PROXY='http://localhost:1087'
            export HTTPS_PROXY='http://localhost:1087'
            export prx_con=$(curl ipinfo.io/country)
            if [[ ! $prx_con ]]; then
                unset HTTP_PROXY HTTPS_PROXY SR_CON
                return 1
            fi
            ;;
        'ps1')
            echo ${prx_con+" (prx-${prx_con})"}
            ;;
        *)
            echo 'Usage: proxy [ http | socks | off ] '
            ;;
    esac
}
# One-line homebrew update
function newbrew() {
    proxy socks
    brew update
    brew upgrade
    brew cask upgrade
    proxy off
}
