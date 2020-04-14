#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

# determine some info about the run envrionment and the arguments
CONFIGURE_VIM=false
CONFIGURE_ZSH=false

if [ $# -eq 0 ];
then
     CONFIGURE_VIM=true
     CONFIGURE_ZSH=true
fi 
while test $# != 0
do
    case "$1" in
    -v) CONFIGURE_VIM=true ;;
    -z) CONFIGURE_ZSH=true ;;
    -vz|-zv) CONFIGURE_VIM=true 
             CONFIGURE_ZSH=true ;;
    *) echo "Unknown arument: $1";;
    esac
    shift
  done

echo "Configure VIM: $CONFIGURE_VIM"
echo "Configure ZSH: $CONFIGURE_ZSH"

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     MACHINE_TYPE=Linux;;
    Darwin*)    MACHINE_TYPE=Mac;;
    CYGWIN*)    MACHINE_TYPE=Cygwin;;
    MINGW*)     MACHINE_TYPE=MinGw;;
    *)          MACHINE_TYPE="UNKNOWN:${unameOut}"
esac
echo "Running on: $MACHINE_TYPE"

# ========================= PERFORM PRE-RUN ACTIONS =========================== 

# check that vim is installed
if $CONFIGURE_VIM;
then
  if ! command -v vim;
  then
    echo "Please install vim and rerun the setup script"
    exit
  fi
fi

# check that zsh is installed
if $CONFIGURE_ZSH;
  then
  if ! command -v zsh;
  then
    echo "Please install zsh and rerun the setup script"
    exit
  fi
fi

# ========================== PERFORM ACTIONS ====================================

if $CONFIGURE_ZSH;
then
  if [ ! -d "~/.oh-my-zsh" ]; then

    # use whichever internet fetching command is availble to get and install oh-my-zsh
    if command -v wget;
    then
      sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    elif command -v curl;
    then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
  fi
fi

cd ~
mkdir -p config-backups

# back up existing config files and replace them with links to the config repo files
while read filename;
do 
	echo "Backing up and linking $filename"
  backup_filename="$filename-$current_time"
	cp -L .$filename config-backups/$backup_filename
	ln -fs config/$filename ./.$filename
  ln -fs config-backups/$backup_filename config-backups/$filename-latest
done < $DIR/managed_files.txt

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




if $CONFIGURE_ZSH;
then
  # install zsh syntax highlighting
  use_repo https://github.com/zsh-users/zsh-syntax-highlighting.git $DIR/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if $CONFIGURE_VIM;
then
  # Install bundle
  use_repo https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  # install the vim theme
  if [ ! -d ~/.vim/colors ]
  then
    mkdir ~/.vim/colors
  fi
  ln -f -s $DIR/vim/colors/brycedcarter.vim ~/.vim/colors/brycedcarter.vim
fi

wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf
sudo mv "DejaVu Sans Mono Nerd Font Complete Mono.ttf" /usr/share/fonts/truetype
sudo apt install language-pack-en
mkdir ~/config/tmp
