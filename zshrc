# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="theunraveler"

# autocomplete will treat hythens and underscores the same
HYPHEN_INSENSITIVE="true"

# dis[ly elipsis when waiting for autocomplete info
COMPLETION_WAITING_DOTS="true"

# plugins to load
plugins=(git history common-aliases osx wd)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin/"
# export MANPATH="/usr/local/man:$MANPATH"
export EDITOR=vim  

source $ZSH/oh-my-zsh.sh

# source zshrc sub configs
source ~/config/source_sub_zsh_configs.sh

# general purpose aliases
# =======================================================================================

# Aliases for starting and stopping dhcp server on mac
alias dhcp-start='sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist'
alias dhcp-stop='sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist'
