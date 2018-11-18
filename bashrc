# .bashrc
# Last updated by Auly at 2018/11/13
# branch: Master (macOS)

# Get global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Get user specific programs
export PATH=$PATH:$HOME/bin
# Edit bash interface
export PS1_BAK='\[\e[33m\][\u@\h:\[\e[32m\]\W\[\e[33m\]]\$ \[\e[0m\]'
export PS1=${PS1_BAK}
export CLICOLOR=true
export LSCOLORS='gxfxcxdxbxegedabagacad'
# Set vim as default editor
export EDITOR='vim'
# Edit commands behavior
alias ls='ls -F'
alias la='ls -A'
alias ll='ls -lha'
alias cp='command cp -riv'
alias mv='command mv -iv'
alias ..='cd ..'
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

# Custom aliase and functions 
# Misc
alias cls='clear'
# Update home and profiles
alias refresh='source ~/.bash_profile'
# Delete and restore files, instead of rm
function dl() {
    if [ ! -d $HOME/.Trash ]; then
        mkdir $HOME/.Trash
    fi
    if [ ! $1 ]; then
        echo 'Move file to trashbin. Usage: dl <filename>...'
        return 1
    fi
        command mv -rfv $@ ~/.Trash
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
            unset ALL_PROXY
            export PS1=${PS1_BAK}
            ;;
        'ssr')
            export ALL_PROXY='socks5://localhost:1086'
            curl ipinfo.io/geo
            if [ $? -ne 0 ]; then
                unset ALL_PROXY
                return 1
            fi
            echo ' CONNECTED'
            export PS1='\[\e[33m\][\u@\h:\[\e[31m\]\W\[\e[33m\]]\$ \[\e[0m\]'
            ;;
        *)
            echo 'Usage: proxy [ ssr | off ] '
            ;;
    esac
}

