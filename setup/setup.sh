#!/bin/bash
# static definitions

###############################################################################
############## CONSTANTS SETUP ################################################
###############################################################################

LINUX_ZSH_PACKAGES=(zsh python-pygments)
MAC_ZSH_PACKAGES=(zsh pygments)

LINUX_VIM_PACKAGES=(build-essential cmake python3-dev python3-venv python-dev vim neovim universal-ctags golang openjdk-11-jdk luarocks)
MAC_VIM_PACKAGES=(cmake nvim go python npm luarocks swiftformat "--HEAD universal-ctags/universal-ctags/universal-ctags")

LINUX_FZF_PACKAGES=(ripgrep fd-find)
MAC_FZF_PACKAGES=(ripgrep fd)

LINUX_TOOLS_PACKAGES=(vim picocom git tldr tree tmux claude-code )
MAC_TOOLS_PACKAGES=(macvim picocom git tldr tree tmux claude-code )

OH_MY_ZSH_SETUP_COMMAND='sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended'

FZF_SETUP_COMMAND="$HOME/.fzf/install --key-bindings --completion --no-update-rc --xdg"


# XDG EXPLICIT SETUP
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=/usr/local/share/:/usr/share/
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CONFIG_DIRS=$HOME/config:/etc/xdg
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache


###############################################################################
############## PROCESS ARGS ###################################################
###############################################################################

CONFIGURE_VIM=false
CONFIGURE_ZSH=false
INSTALL_TOOLS=false
MANAGE_CONFIGS=false
INSTALL_FONTS=false
VERBOSE=false
FORCE_YCM=false
FORCE=false

if [ $# -eq 0 ];
then
     CONFIGURE_VIM=true
     CONFIGURE_ZSH=true
     INSTALL_TOOLS=true
     MANAGE_CONFIGS=true
     INSTALL_FONTS=true
fi 

show_usage()
{
  echo "setup.sh [options]
  a helper script to setup a variety of command line tools and settings
  options:
  * no options will install all
  -v: Setup vim
  -z: Setup zsh
  -t: setup miscellaneous tools 
  -c: Manage configuration files (rc files mainly)
  -f: Install fonts
  --verbose: Show verbose output of setup
  --force: Continue when errors are encountered (this mode is not well tested)
  -h: Show this help
  "
}



while test $# != 0
do
    case "$1" in
    -v) CONFIGURE_VIM=true ;;
    -z) CONFIGURE_ZSH=true ;;
    -t) INSTALL_TOOLS=true ;;
    -c) MANAGE_CONFIGS=true ;;
    -f) INSTALL_FONTS=true ;;
    --verbose) VERBOSE=true ;;
    --force) FORCE=true ;;
    -h|--help) show_usage; exit 0;;
    *) echo "Unknown arument: $1";;
    esac
    shift
  done




###############################################################################
############## PREPARE THE ENVIRONMENT ########################################
###############################################################################
#

SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR=$(dirname $SETUP_DIR)
mkdir -p "$CONFIG_DIR/.tmp" 
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
export PATH=$PATH:/usr/local/bin

# Hide output from commands unless verbose mode is enabled
exec 3>&1 4>&2 # create new fds for messages and errors
if ! $VERBOSE; then
  exec 1>/dev/null 2>&1 # point stdout and stderr to /dev/null
fi

# Determine the OS of the host machine
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     MACHINE_TYPE=Linux;;
    Darwin*)    MACHINE_TYPE=Mac;;
    CYGWIN*)    MACHINE_TYPE=Cygwin;;
    MINGW*)     MACHINE_TYPE=MinGw;;
    *)          MACHINE_TYPE="UNKNOWN:${unameOut}"
esac




###############################################################################
############## DEFINE FUNCTIONS ##############################################
###############################################################################

message()
{
  echo -e "$1" >&3
}

error()
{
  echo -e "\x1b[31m$1\x1b[0m" >&4
  exit 1
}

warning()
{
  echo -e "\x1b[33m$1\x1b[0m" >&4
}

status()
{
  echo -n -e "$1" >&3
}

show_banner()
{
  message "\x1b[34m======================= $1 =======================\x1b[0m"
}

do_thing()
{
command="$1"
description="$2"
status "$2"
eval $1
if [ $? -ne 0 ]; then
  if $FORCE;
  then
    message ": \x1b[31mFAILED - BUT CONTINUING DUE TO FOCED MODE,,,\x1b[0m"
  else
    message ": \x1b[31mFAIL\x1b[0m"
    error "\nError encountered. Please re-run with --verbose for more details"
  fi
else
  message ": \x1b[32mOK\x1b[0m"
fi
}


install()
{
packages=("$@")
for package_name in "${packages[@]}"
do
  case $MACHINE_TYPE in
    Linux) do_thing "sudo apt-get install -y $package_name" "Installing $package_name";;
    Mac) do_thing "brew install $package_name" "Installing $package_name";;
    *) error "No install method on platform: $MACHINE_TYPE - Please manualy install $package_name";;
  esac
done
}

use_repo()
{
  repo_url=$1
  repo_location=$2
  if [ -d $repo_location ]
  then 
    if git -C $repo_location rev-parse;
    then
      cd $repo_location 
      git pull
      return
    fi
  fi
  git clone $repo_url $repo_location 
}




###############################################################################
############## PRE-RUN ACTIONS ################################################
###############################################################################

# Display run config
message "Configure VIM: $CONFIGURE_VIM"
message "Configure ZSH: $CONFIGURE_ZSH"
message "Install tools: $INSTALL_TOOLS"
message "Manage configs: $MANAGE_CONFIGS"
message "Install fonts: $INSTALL_FONTS"
message "Verbose Mode: $VERBOSE"
message "Running on: $MACHINE_TYPE"

# generally usefully stuff
show_banner "Preforming pre-run actions (updating repos and installing wget)"
case $MACHINE_TYPE in
  Linux) sudo apt-get update; install wget;;
  Mac) brew update; install wget;;
  *) error "Platform unsupported. Please manually install the following and re-run this script: wget"; exit ;;
esac




###############################################################################
############## SETUP ZSH ######################################################
###############################################################################

if $CONFIGURE_ZSH;
then
    show_banner "Installing zsh packages"
    case $MACHINE_TYPE in
      Linux) install "${LINUX_ZSH_PACKAGES[@]}";;
      Mac) install "${MAC_ZSH_PACKAGES[@]}";;
      *) error "Platform unsupported. Please manually install the following: ${LINUX_ZSH_PACKAGES[*]} or ${MAC_ZSH_PACKAGES[*]}";;
    esac

  show_banner "Setting up zsh stuff"
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    warning "NOTICE: in a moment, the shell will transition to ZSH. When this happens, simply type 'exit' and then press enter"
    do_thing "$OH_MY_ZSH_SETUP_COMMAND" "Installing oh-my-zsh"
    do_thing "sudo chsh --shell /usr/bin/zsh $USER" "Changing $USER's shell to zsh"
  fi
 
  do_thing "use_repo https://github.com/zsh-users/zsh-syntax-highlighting.git $CONFIG_DIR/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "Installing zsh syntax highlighting"

  do_thing "use_repo https://github.com/romkatv/powerlevel10k.git $CONFIG_DIR/zsh/oh-my-zsh/custom/themes/powerlevel10k" "Installing powerlevel10k"

  do_thing "wget -O ~/.iterm2_shell_integration.zsh https://iterm2.com/shell_integration/zsh" "Installing iterm zsh integration"
  
fi

###############################################################################
############## SETUP VIM ######################################################
###############################################################################
if $CONFIGURE_VIM;
then
  show_banner "Setting up vim"
    warning "NOTICE: It we are going to install NVIM for you, but depending on your OS version, you may want to replace it with one that you build from source becuase our setup needs a pretty modern version of nvim"
    case $MACHINE_TYPE in
      Linux) install "${LINUX_VIM_PACKAGES[@]}" ;;
      Mac) install "${MAC_VIM_PACKAGES[@]}";;
      *) error "Platform unsupported. Please manually install the following: ${LINUX_ZSH_PACKAGES[*]} or ${MAC_ZSH_PACKAGES[*]}";;
    esac
fi



###############################################################################
############## SETUP FZF AND FD ###############################################
###############################################################################

if $CONFIGURE_VIM || $CONFIGURE_ZSH;
then
  show_banner "Setting up fzf"
    case $MACHINE_TYPE in
      Linux) install "${LINUX_FZF_PACKAGES[@]}"
        # fd name is used by some other package, so the fd we want gets
        # installed as fd-find... make a link
        mkdir -p $HOME/.local/bin
        ln -s $(which fdfind) $HOME/.local/bin/fd
        ;;
      Mac) install "${MAC_FZF_PACKAGES[@]}";;
      *) error "Platform unsupported. Please manually install the following: ${LINUX_ZSH_PACKAGES[*]} or ${MAC_ZSH_PACKAGES[*]}";;
    esac

  do_thing "use_repo https://github.com/junegunn/fzf.git $HOME/.fzf" "Cloning fzf"
  mkdir -p $HOME/.local/bin
  ln -s $HOME/.fzf/bin/fzf $HOME/.local/bin/fzf
  do_thing "$FZF_SETUP_COMMAND" "Installing fzf"

fi

###############################################################################
############## INSTALL TOOLS ##################################################
###############################################################################

if $INSTALL_TOOLS; then
    show_banner "Installing tools packages"
    case $MACHINE_TYPE in
      Linux) install "${LINUX_TOOLS_PACKAGES[@]}";;
      Mac) install "${MAC_TOOLS_PACKAGES[@]}";;
      *) error "Platform unsupported. Please manually install the following: ${LINUX_TOOLS_PACKAGES[*]} or ${MAC_TOOLS_PACKAGES[*]}";;
    esac
fi


###############################################################################
############## MANAGE CONFIG FILES ############################################
###############################################################################

if $MANAGE_CONFIGS; then
  # General managed files
  show_banner "Backing up and replacing managed config (rc) files"
  do_thing "cd ~; mkdir -p '.config-backups'" "Creating folder for storing backups"
  while read -r filepath dotfile;
  do 
	  backup_filename="${dotfile#?}-$current_time"
    cd ~
    if [ -f "$dotfile" ]; then
      do_thing "cd ~; cp -L $dotfile .config-backups/$backup_filename; ln -fs .config-backups/$backup_filename .config-backups/${dotfile#?}-latest" "Backing up ~/$dotfile"
    fi
    do_thing  "cd ~; ln -fs $HOME/config/$filepath ./$dotfile"  "Linking managed version of ~/$dotfile from ~/config/$filepath"
  done < "$SETUP_DIR/managed_files.txt"

  # XDG config files
  while read -r filepath application config_file;
  do 
          base_backup_name="$application-${config_file#?}"
          base_backup_name="${base_backup_name//\//-}" # replace all slashes with dashes so we do not get nested directories in the backup file names
	  backup_filename="$base_backup_name-$current_time"
    cd ~
    if [ ! -d "$XDG_CONFIG_HOME/$$application" ] ; then 
      do_thing "mkdir -p $XDG_CONFIG_HOME/$application" "Creating XDG config dir for $application ($XDG_CONFIG_HOME/$application)" 
    fi
    xdg_config_path="$XDG_CONFIG_HOME/$application/$config_file"
    if [ -f "$xdg_config_path" ]; then
      do_thing "cd ~; cp -L $xdg_config_path .config-backups/$backup_filename; ln -fs .config-backups/$backup_filename .config-backups/${base_backup_name#?}-latest" "Backing up ~/$xdg_config_path"
    fi
    do_thing  "cd ~; ln -fs $HOME/config/$filepath $xdg_config_path"  "Linking managed version of ~/$xdg_config_path from ~/config/$filepath"
  done < "$SETUP_DIR/xdg_configs.txt"
if [ "$MACHINE_TYPE" = "Mac" ]; then
  # Handle Cursor and VSCode configs in Application Support for settings.json and keybindings.json

  # Cursor
  CURSOR_APP_SUPPORT="$HOME/Library/Application Support/Cursor/User"
  for file in settings.json keybindings.json; do
    src="$CURSOR_APP_SUPPORT/$file"
    xdg_src="$XDG_CONFIG_HOME/Cursor/User/$file"
    if [ -f "$src" ] || [ -L "$src" ]; then
      CURSOR_BACKUP="$HOME/.config-backups/cursor-$file-$current_time"
      do_thing "cp -a \"$src\" \"$CURSOR_BACKUP\"" "Backing up existing Cursor $file from Application Support"
      do_thing "rm -f \"$src\"" "Removing existing Cursor $file from Application Support"
    fi
    do_thing "mkdir -p \"$CURSOR_APP_SUPPORT\"" "Ensuring Cursor User directory exists"
    do_thing "ln -sf \"$xdg_src\" \"$src\"" "Symlinking XDG Cursor $file to Application Support"

    # just another random bit of helper to make VSCode and Cursor work better on mac:
    do_thing "defaults write com.todesktop.230313mzl4w4u92  ApplePressAndHoldEnabled -bool false" "Disabling mac keypress hold"
    do_thing "defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false" "Disabling mac keypress hold"
  done

  # VSCode
  VSCODE_APP_SUPPORT="$HOME/Library/Application Support/Code/User"
  for file in settings.json keybindings.json; do
    src="$VSCODE_APP_SUPPORT/$file"
    xdg_src="$XDG_CONFIG_HOME/Code/User/$file"
    if [ -f "$src" ] || [ -L "$src" ]; then
      VSCODE_BACKUP="$HOME/.config-backups/vscode-$file-$current_time"
      do_thing "cp -a \"$src\" \"$VSCODE_BACKUP\"" "Backing up existing VSCode $file from Application Support"
      do_thing "rm -f \"$src\"" "Removing existing VSCode $file from Application Support"
    fi
    do_thing "mkdir -p \"$VSCODE_APP_SUPPORT\"" "Ensuring VSCode User directory exists"
    do_thing "ln -sf \"$xdg_src\" \"$src\"" "Symlinking XDG VSCode $file to Application Support"
  done
fi
fi




###############################################################################
############## INSTALL FONTS ##################################################
###############################################################################

if $INSTALL_FONTS; then
  show_banner "Installing fonts"
  if [ $MACHINE_TYPE = "Linux" ]
  then
    do_thing "wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Overpass/Mono/Regular/OverpassMNerdFontMono-Regular.otf && sudo mv 'OverpassMNerdFontMono-Regular.otf' /usr/share/fonts/opentype && sudo apt install -y language-pack-en" "Installing overpass nerd font"
  elif [ $MACHINE_TYPE = "Mac" ]
  then
    do_thing "brew tap homebrew/cask-fonts; brew install --cask font-overpass-nerd-font" "Installing overpass nerd font"
  else
    do_thing "wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Overpass/Mono/Regular/OverpassMNerdFontMono-Regular.otf" "Downloading overpass nerd font"
    warning "Please install the font that was just downloaded to your home directory: OverpassMNerdFontMono-Regular.otf"

  fi
  mkdir ~/config/tmp
fi
