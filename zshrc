######################################################################################
################ MANAGED FILE ########################################################
######################################################################################
# This file should not be edited except in its original location of ~/config/zshrc
######################################################################################
# MY FAVORITE PLUGIN KEYS
# git status: gst
# git add: ga
# start git comit with verbose: gc
# search history with grep: hs <pattern>
# jump to stored warp point: wd <warp point name>
# store current dir ad warp point: wd add 
# list warp points: wd list
# OSX open directory in finder: ofd
# Windows (WSL) run cmd: cmd
# 
#
# # Use hyper.is or iTerm2 as terminal emulators
#
export TERM="xterm-256color"

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
export ZSH_CUSTOM=~/config/oh-my-zsh/custom



#========================= POWERLEVEL 10K SETTINGS ================================
#==================================================================================

unset -m 'POWERLEVEL9K_*|DEFAULT_USER'

#POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_MODE=awesome-fontconfig
ZSH_THEME="powerlevel10k/powerlevel10k"


POWERLEVEL9K_OS_ICON_FOREGROUND=15 # setting backgrounds for all so that they do not cause problems with hyper termal
POWERLEVEL9K_OS_ICON_BACKGROUND=237
POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=234
POWERLEVEL9K_STATUS_OK_BACKGROUND=234

POWERLEVEL9K_ICON_PADDING=moderate
# The list of segments shown on the left. Fill it with the most important segments.
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  # =========================[ Line #1 ]=========================
  ssh                     # indictaor to show if this is an ssh session
  os_icon                 # os identifier
  dir                     # current directory
  dir_writable            # current directory writable status 
  vcs                     # git status
  # =========================[ Line #2 ]=========================
  newline                 # \n
  prompt_char             # prompt symbol
)
  # The list of segments shown on the right. Fill it with less important segments.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    status                  # exit code of the last command
    newline
  )

POWERLEVEL9K_FOLDER_ICON="" # better than the defualt folder icon because it is bold


POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015" # make the lock a nice white instead of an ugly gold


POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='·'  # set up the fillter between right and left prompts
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=238


POWERLEVEL9K_TRANSIENT_PROMPT=always # dont show the promp on every line



#==================================================================================
#==================================================================================
## Set name of the theme to load.
## Look in ~/.oh-my-zsh/themes/
#POWERLEVEL9K_MODE="nerdfont-complete"
#ZSH_THEME="powerlevel9k/powerlevel9k"

#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

#POWERLEVEL9K_FOLDER_ICON=""

##POWERLEVEL9K_HOME_SUB_ICON="%F{black} $(print $'\uE0B1') %F{black}" 
##POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{black} $(print $'\uE0B1') %F{black}"

## this is a workaround for super slow "git stash list" command found here: https://github.com/bhilburn/powerlevel9k/issues/323
##POWERLEVEL9K_VCS_GIT_HOOKS=(git-tagname vcs-detect-changes git-untracked git-aheadbehind git-remotebranch)

#POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

#POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true

#POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
#POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
#POWERLEVEL9K_NVM_BACKGROUND="238"
#POWERLEVEL9K_NVM_FOREGROUND="green"
#POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="blue"
#POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"

#POWERLEVEL9K_TIME_BACKGROUND='004'
##POWERLEVEL9K_COMMAND_TIME_FOREGROUND='gray'
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='245'
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

#POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh os_icon dir dir_writable vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time time)
#POWERLEVEL9K_SHOW_CHANGESET=true

# autocomplete will treat hythens and underscores the same
HYPHEN_INSENSITIVE="true"

# display elipsis when waiting for autocomplete info
COMPLETION_WAITING_DOTS="true"

# plugins to load
plugins=(git history common-aliases osx wd colored-man-pages colorize zsh-syntax-highlighting command-not-found ssh-agent vundle pip)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin/"
export EDITOR=vim  



zstyle :omz:plugins:ssh-agent agent-forwarding on
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
function dhcp-start() {
  if [ -z "$1" -o -z "$2" ]; then
    echo "Usage: $1 [interface] [subnet]"
  else

  sudo ipconfig set "$1" INFORM "192.168.$2.1"
  sed -e "s/\${interface}/$1/g" -e "s/\${subnet}/$2/g" ~/config/bootpd.plist.on | sudo tee /etc/bootpd.plist > /dev/null
  
  sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist
  sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist
  fi

}

function dhcp-stop() {
  if [ -z "$1" ]; then
    echo "Usage: $1 [interface]"
  else

  sudo ipconfig set "$1" DHCP

  sudo cp ~/config/bootpd.plist.off /etc/bootpd.plist

  sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist
  fi
}

 #ssh-agent config
#if [ -z "$(pgrep ssh-agent)" ]; then
  #rm -rf /tmp/ssh-*
  #eval $(ssh-agent -s) > /dev/null
#else
  #export SSH_AGENT_PID=$(pgrep ssh-agent)
  #export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name 'agent.*')
#fi

if [ "$(ssh-add -l)" = "The agent has no identities." ]; then
  ssh-add
fi

#alias dhcp-start='sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist'
#alias dhcp-stop='sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist'
alias cmd=/mnt/c/Windows/System32/cmd.exe
#alias git='~/config/custom_git.sh'

# map the cat to colorized cat
alias cat=ccat


# shorthand for finding text in files in current dir
function myfind() {
       find . -name \* -print0 | xargs -0 grep --color -n "$1"
}

if [ -f ~/driving/scripts/zooxrc.sh ]; then
	source ~/driving/scripts/shell/zooxrc.sh
fi

bindkey '\e[A' history-beginning-search-backward 
bindkey '\e[B' history-beginning-search-forward
