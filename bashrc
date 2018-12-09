# .bashrc
# Last updated by Auly at 2018/11/13
# branch: Master (macOS)

# Get global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Get user specific programs
export PATH=$PATH:$HOME/bin
# Edit PS1 behavior
export PS1='\n\[\e[0;32m\][\A] \[\e[33m\]\u@\h: \[\e[31m\]\w \[\e[35m\]$(proxy ps1)$(__git_ps1) \[\e[0;32m\]\n\$\[\e[0m\] '
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
            unset ALL_PROXY SSR_CON
            ;;
        'ssr')
            export ALL_PROXY='socks5://localhost:1086'
            export SSR_CON=$(curl ipinfo.io/country)
            if [[ ! $SSR_CON ]]; then
                unset ALL_PROXY SSR_CON
                return 1
            fi
            ;;
        'ps1')
            echo ${SSR_CON+" (ssr-${SSR_CON})"}
            ;;
        *)
            echo 'Usage: proxy [ ssr | off ] '
            ;;
    esac
}

