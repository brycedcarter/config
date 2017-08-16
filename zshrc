LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

# Path to your oh-my-zsh installation
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
POWERLEVEL9K_MODE="nerdfont-complete"
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

POWERLEVEL9K_FOLDER_ICON=""

#POWERLEVEL9K_HOME_SUB_ICON="%F{black} $(print $'\uE0B1') %F{black}" 
#POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{black} $(print $'\uE0B1') %F{black}"

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true

POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL9K_NVM_BACKGROUND="238"
POWERLEVEL9K_NVM_FOREGROUND="green"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"

POWERLEVEL9K_TIME_BACKGROUND='255'
#POWERLEVEL9K_COMMAND_TIME_FOREGROUND='gray'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='245'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time time)
POWERLEVEL9K_SHOW_CHANGESET=true

# autocomplete will treat hythens and underscores the same
HYPHEN_INSENSITIVE="true"

# dis[ly elipsis when waiting for autocomplete info
COMPLETION_WAITING_DOTS="true"

# plugins to load
plugins=(git history common-aliases osx wd colored-man colorize zsh-syntax-highlighting)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin/"
export EDITOR=vim  

ZSH_CUSTOM=~/config/oh-my-zsh/custom
source $ZSH/oh-my-zsh.sh

# These must be called after the theme has been sources or the function will not be available
POWERLEVEL9K_HOME_SUB_ICON="$(print_icon "HOME_ICON")"
POWERLEVEL9K_DIR_PATH_SEPARATOR=" $(print_icon "LEFT_SUBSEGMENT_SEPARATOR") "

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
#ZSH_HIGHLIGHT_STYLES[cursor]='bold'
#ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
#ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
#ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
#ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
#ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
#ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
#ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,bold'


# source zshrc sub configs
source ~/config/source_sub_zsh_configs.sh

# general purpose aliases
# =======================================================================================

# Aliases for starting and stopping dhcp server on mac
alias dhcp-start='sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist'
alias dhcp-stop='sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist'

# shorthand for finding text in files in current dir
function myfind() {
       find . -name \* -print0 | xargs -0 grep --color -n "$1"
}

