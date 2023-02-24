###############################################################################
################ MANAGED FILE #################################################
###############################################################################
# This file should not be edited except in its original location of ~/config/zshrc
###############################################################################
# MY FAVORITE PLUGIN KEYS
# git status: gst
# git add: ga
# start git commit with verbose: gc
# search history with grep: hs <pattern>
# jump to stored warp point: wd <warp point name>
# store current dir ad warp point: wd add 
# list warp points: wd list
# OSX open directory in finder: ofd
# Windows (WSL) run cmd: cmd
# 
#
# # Use hyper.is or iTerm2 as terminal emulators

! [[ "$TERM" =~ ^.*256color.*$ ]] && echo "WARNING: \$TERM is does not seem to support 256 colors. Maybe you need to configure your terminal emulator to set \$TERM correctly"

LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

# Path to oh-my-zsh installation
export ZSH=~/.oh-my-zsh
export ZSH_CUSTOM=~/config/oh-my-zsh/custom


#========================= POWERLEVEL 10K SETTINGS ============================
#==============================================================================

unset -m 'POWERLEVEL9K_*|DEFAULT_USER'

#POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_MODE=awesome-fontconfig
ZSH_THEME="powerlevel10k/powerlevel10k"

function prompt_current_project() {
  if ! [ -z "$PRJACTIVE" ]; then
    p10k segment -b black -f blue -t "$PRJACTIVE"
  fi
 }


POWERLEVEL9K_OS_ICON_FOREGROUND=15 # setting backgrounds for all so that they do not cause problems with hyper terminal
POWERLEVEL9K_OS_ICON_BACKGROUND=237
POWERLEVEL9K_SSH_BACKGROUND=237
POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=234
POWERLEVEL9K_STATUS_OK_BACKGROUND=234

POWERLEVEL9K_ICON_PADDING=moderate
# The list of segments shown on the left. Fill it with the most important segments.
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  # =========================[ Line #1 ]=========================
  ssh                     # indicator to show if this is an ssh session
  os_icon                 # os identifier
  dir                     # current directory
  dir_writable            # current directory writable status 
  vcs                     # git status
  current_project         # show value of custom PRJACTIVE environment variable 
  # =========================[ Line #2 ]=========================
  newline                 # \n
  prompt_char             # prompt symbol
)
  # The list of segments shown on the right. Fill it with less important segments.
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    status                  # exit code of the last command
    newline
  )

POWERLEVEL9K_FOLDER_ICON="" # better than the defualt folder icon because it is bold


POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015" # make the lock a nice white instead of an ugly gold


POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='·'  # set up the filler between right and left prompts
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=238


POWERLEVEL9K_TRANSIENT_PROMPT=always # dont show the promp on every line

# updated icons:
POWERLEVEL9K_SSH_ICON='\uf489'


#==============================================================================
#==============================================================================

############################ LS_COLOR #########################################
# I do not like having background colors set for LS_COLORS
# a good reference can be found here: http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors
# #############################################################################
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=04;35:so=01;35:do=01;35:bd=40;33;04:cd=40;33;01:or=40;31;01:mi=00:su=34;04:sg=34;04:ca=30;41:tw=34:ow=34:st=34:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

# #############################################################################
# #############################################################################

# autocomplete will treat hythens and underscores the same
HYPHEN_INSENSITIVE="true"

# display elipsis when waiting for autocomplete info
COMPLETION_WAITING_DOTS="true"

# plugins to load
plugins=(
  git
  common-aliases
  macos
  wd
  colored-man-pages
  colorize
  zsh-syntax-highlighting
  command-not-found
  ssh-agent
  pip
  vi-mode
)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin/:$HOME/.local/bin/"
export EDITOR=vim  

zstyle :omz:plugins:ssh-agent agent-forwarding on
source $ZSH/oh-my-zsh.sh

# setting environment variables to be sent to ssh hosts
# NOTE: for these env vars to be sent to the host, the client config needs this
# line:
# SendEnv CUSTOM_SSH_ENV_*
# And the host config needs this line:
# AcceptEnv CUSTOM_SSH_ENV_*
export CUSTOM_SSH_ENV_TERM=$TERM_PROGRAM

# These must be called after the theme has been sourced or the function will not be available
POWERLEVEL9K_HOME_SUB_ICON="$(print_icon "HOME_ICON")"
POWERLEVEL9K_DIR_PATH_SEPARATOR=" $(print_icon "LEFT_SUBSEGMENT_SEPARATOR") "

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# source zshrc sub configs
source "$HOME/config/source_sub_zsh_configs.sh"

# source iterm2 integration
if [[ $CUSTOM_SSH_ENV_TERM == "iTerm.app" ]]; then
  source ~/.iterm2_shell_integration.zsh
fi

# setup fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# setup fzf settings
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=30%
--margin=5%
--border=rounded
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt '❯ '
--pointer '❯ ' 
--marker '*'
--bind '?:toggle-preview'
"
export FZF_DEFAULT_COMMAND='fd --search-path $HOME --search-path . . '
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type f"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_COMPLETION_TRIGGER='**'

# setup VI Mode
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
V8I_MODE_SET_CURSOR=true

# general purpose aliases
# =============================================================================

# Aliases for starting and stopping dhcp server on mac
function dhcp-start() {
  if [ -z "$1" -o -z "$2" ]; then
    echo "Usage: $1 [interface] [subnet]"
  else
  sudo ipconfig set "$1" INFORM "192.168.$2.1"
  sed -e "s/\${interface}/$1/g" -e "s/\${subnet}/$2/g" ~/config/data/bootpd.plist.on | sudo tee /etc/bootpd.plist > /dev/null
  sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist
  sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist
  fi

}

function dhcp-stop() {
  if [ -z "$1" ]; then
    echo "Usage: $1 [interface]"
  else
  sudo ipconfig set "$1" DHCP
  sudo cp ~/config/data/bootpd.plist.off /etc/bootpd.plist
  sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist
  fi
}

# For setting some environment variables that can be use as a quick way to set
# where output data should be sent
function setprj() {
  if [ -d "$1" ]; then
    export PRJACTIVE=$(basename $1) 
    export PRJPATH=$1 
  elif ! [ -z "$PRJBASE" ]; then
    export $(cat "$PRJBASE/ACTIVE" | xargs)
  else
    echo "Project base not set"
  fi
}
alias clearprj='export PRJACTIVE=;PRJPATH='
setprj

# If no ssh key is ready in the agent, load one
if [ "$(ssh-add -l)" = "The agent has no identities." ]; then
  ssh-add
fi

# Faster access to native shell on windows
alias cmd=/mnt/c/Windows/System32/cmd.exe

# quick acces to searching running processes
alias pss='ps -ax | grep ' 

# special ssh for when connecting to a trusted system
alias sssh='ssh -o ForwardX11=yes -o ForwardX11Trusted=yes -o ForwardAgent=yes '

# tool for opening and connecting to tmux sessions with iTerm
alias dev='~/config/dev.sh'

# Key bindings (VI mode)
# To find out what escape sequence is generated by a key, Press Ctrl+V followed
# by the key
bindkey -v

# NOTE: These bindings for history will need to change if "vi-mode" plugin is
# not used. Change the "O" to a "["
bindkey -M main '^[OA' history-beginning-search-backward 
bindkey -M main '^[OB' history-beginning-search-forward

bindkey -M viins 'jk' vi-cmd-mode

# workaround for getting stateful environment variables back into zshs that live
# inside temux sessions:
# From here: https://www.babushk.in/posts/renew-environment-tmux.html
if [ -n "$TMUX" ]; then
function refresh {
  export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
  export $(tmux show-environment | grep "^DISPLAY")
  }
else
  function refresh { }
fi

function preexec {
  refresh
}

function mksublib {
  mkdir $1
  sed "s/{NAME}/$1/g" ~/config/templates/BUILD_LIB > "$1/BUILD"
  touch "$1/$1.h"
  touch "$1/$1.cpp"
  touch "$1/${1}_test.h"
  touch "$1/${1}_test.cpp"
  touch "$1/README.md"
}

function mksubbin {
  mkdir $1
  sed "s/{NAME}/$1/g" ~/config/templates/BUILD_BIN > "$1/BUILD"
  touch "$1/$1.h"
  touch "$1/$1.cpp"
  touch "$1/${1}_test.cpp"
  touch "$1/README.md"
}
