# .bashrc
# Last updated by Auly at 2018/11/13
# branch: Master (macOS)

# Get global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Get user specific programs
export PATH=$PATH:$HOME/bin
# Set up basic colors on [ls]
export CLICOLOR=true
export LSCOLORS='gxfxcxdxbxegedabagacad'
# Edit PS1 behavior
export OPS1="\n\[\e[0;32m\][\A] \[\e[33m\]\u@\h: \[\e[31m\]\w\n\$ \[\e[0m\]"
export PS1=$OPS1
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
            unset ALL_PROXY SSR_COUNTRY
            export PS1=$OPS1
            ;;
        'ssr')
            export ALL_PROXY='socks5://localhost:1086'
            export SSR_COUNTRY=$(curl ipinfo.io/country)
            if [ ! $SSR_COUNTRY ]; then
                unset ALL_PROXY
                return 1
            fi
            echo "SSR proxy connected. Country: $SSR_COUNTRY"
            export PS1="\[\e[35m\]<SSR-$SSR_COUNTRY> $OPS1"
            ;;
        *)
            echo 'Usage: proxy [ ssr | off ] '
            ;;
    esac
}

