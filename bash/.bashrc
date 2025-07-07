# Author:maodun
# Modifydate:2025.6.13
# Description:Configure baah by using .bashrc
# Helpdocs:https://www.gnu.org/software/bash/manual/bash.html

# ~/.bashrc



# Default config
    ## If not running interactively, don't do anything
    [[ $- != *i* ]] && return

    ## Set command line prompt
    PS1='[\u@\h \W]\$ '

    ## Set common commands alias
        ### Add color display
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        ### Update and isntall applications
        alias update='sudo pacman -Syu'
        alias install='sudo pacman -S'
        alias uninstall='sudo pacman -Rs'
        ### Set ssh alias 
            #### start ssh-agent in background 
            alias ssa='eval $(ssh-agent -s)'
            #### Add private key to ssh-agent
            alias apk='ssh-add ~/.ssh/key'
        ### Set disk alias
            #### Mount disk to /mnt/usb 
            alias m='sudo mount -t ntfs-3g /dev/sda1 /mnt'
            #### Umount disk from /mnt/usb
            alias um='sudo umount /mnt'
        ### Set bluetooth alias
        alias bt='bluetoothctl'



# Git config
    ## Set git alias
        ### Get local respository
        alias gi='git init'
        alias gcl='git clone'
        ### Get local files
        alias gs='git status'
        alias gd='git diff'
        alias gl='git log'
        ### Control local files
        alias ga='git add'
        alias gc='git commit'
        ### Get remote respository
        alias gr='git remote'
        ### Control remote files
        alias gf='git fetch'
        alias gm='git merge'
        alias gl='git pull'
        alias gh='git push'
        ### Control branch
        alias gd='git branch'
        alias gsw='git switch'
   


# Yazi config
    ## Set alias for 'yazi' and keep cwd when quit yazi with "q"
    function y() {
	      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	      yazi "$@" --cwd-file="$tmp"
	      IFS= read -r -d '' cwd < "$tmp"
	      [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	      rm -f -- "$tmp"
  }



# Zoxide config
    ## Run in background and map "cd" to "z"
    eval "$(zoxide init --cmd cd bash)"
. "$HOME/.cargo/env"
