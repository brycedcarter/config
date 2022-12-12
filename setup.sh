#!/bin/bash
# static definitions

###############################################################################
############## CONSTANTS SETUP ################################################
###############################################################################

LINUX_ZSH_PACKAGES=(zsh python-pygments ripgrep fd-find)
MAC_ZSH_PACKAGES=(zsh pygments ripgrep fd)

LINUX_VIM_PACKAGES=(build-essential cmake python3-dev python3-venv python-dev vim universal-ctags golang npm openjdk-11-jdk fzf)
MAC_VIM_PACKAGES=(cmake macvim go python fzf "--HEAD universal-ctags/universal-ctags/universal-ctags")

LINUX_TOOLS_PACKAGES=(vim picocom git tldr tree)
MAC_TOOLS_PACKAGES=(macvim picocom git tldr tree)

OH_MY_ZSH_SETUP_COMMAND='sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended'

FZF_SETUP_COMMAND="/usr/local/opt/fzf/install --key-bindings --completion --no-update-rc"

YCM_COMPILE_COMMAND="git submodule update --init --recursive; python3 install.py --all"


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
  -ycm: Compile YouCompleteMe
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
    --ycm) FORCE_YCM=true ;;
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

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
export PATH=$PATH:/usr/local/bin
ssh-add

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

  do_thing "$FZF_STEUP_COMMAND" "Adding fzf key bindings"
 
  do_thing "use_repo https://github.com/zsh-users/zsh-syntax-highlighting.git $DIR/oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "Installing zsh syntax highlighting"

  do_thing "use_repo https://github.com/romkatv/powerlevel10k.git $DIR/oh-my-zsh/custom/themes/powerlevel10k" "Installing powerlevel10k"

  do_thing "wget -O ~/.iterm2_shell_integration.zsh https://iterm2.com/shell_integration/zsh" "Installing iterm zsh integration"
  
fi




###############################################################################
############## SETUP VIM ######################################################
###############################################################################

if $CONFIGURE_VIM;
then
    show_banner "Installing vim packages"
    case $MACHINE_TYPE in
      Linux) install "${LINUX_VIM_PACKAGES[@]}";;
      Mac) install "${MAC_VIM_PACKAGES[@]}";;
      *) error "Platform unsupported. Please manually install the following: ${LINUX_VIM_PACKAGES[*]} or ${MAC_VIM_PACKAGES[*]}";;
    esac

  show_banner "Setting up vim stuff"
  do_thing "use_repo https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim" "Installing vundle"

  do_thing "cd ~/config; vim +'source vimrc' +'PluginInstall' +qa" "Installing VIM plugins"
  do_thing "cd ~/config; vim +'source vimrc' +'call doge#install()' +qa" "Installing Doge (document generation)"
fi

if $CONFIGURE_VIM || $FORCE_YCM;
then
    if ! [[ -f ~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.cpython-39-darwin.so ]] || $FORCE_YCM; then
    # compile ycm
    
    do_thing "cd ~/.vim/bundle/YouCompleteMe; $YCM_COMPILE_COMMAND" "Compiling YouCompleteMe"
    fi
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
  show_banner "Backing up and replacing managed config (rc) files"
  do_thing "cd ~; mkdir -p '.config-backups'" "Creating folder for storing backups"
  while read filename;
  do 
    backup_filename="$filename-$current_time"
    cd ~
    if [ -f .$filename ]; then
      do_thing "cd ~; cp -L .$filename .config-backups/$backup_filename; ln -fs .config-backups/$backup_filename .config-backups/$filename-latest" "Backing up ~/.$filename"
    fi
    do_thing  "cd ~; ln -fs config/$filename ./.$filename"  "Linking managed version of ~/.$filename from ~/config"
  done < $DIR/managed_files.txt
fi




###############################################################################
############## INSTALL FONTS ##################################################
###############################################################################

if $INSTALL_FONTS; then
  show_banner "Installing fonts"
  if [ $MACHINE_TYPE = "Linux" ]
  then
    do_thing "wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Overpass/Mono/Regular/complete/Overpass%20Mono%20Regular%20Nerd%20Font%20Complete.otf; sudo mv 'Overpass Mono Regular Nerd Font Complete.otf' /usr/share/fonts/truetype; sudo apt install -y language-pack-en" "Installing overpass nerd font"
  elif [ $MACHINE_TYPE = "Mac" ]
  then
    do_thing "brew tap homebrew/cask-fonts; brew install --cask font-overpass-nerd-font" "Installing overpass nerd font"
  else
    do_thing "wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Overpass/Mono/Regular/complete/Overpass%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.otf" "Downloading overpass nerd font"
    warning "Please install the font that was just downloaded to your home directory: DejaVu Sans Mono Nerd Font Complete Mono.ttf"

  fi
  mkdir ~/config/tmp
fi
