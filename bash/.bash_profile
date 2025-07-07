# Author:maodun
# Modifydate:2025.6.13
# Description:Configure bash by using .bash_profile
# Helpdocs:https://www.gnu.org/software/bash/manual/bash.html

# ~/.bash_profile



# exec .bashrc file if it exists 
[[ -f ~/.bashrc ]] && . ~/.bashrc



# set env variables
export EDITOR=helix
export PATH=~/.cargo/bin:$PATH
export PATH=~/.local/bin:$PATH
. "$HOME/.cargo/env"
