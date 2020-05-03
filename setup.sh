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
    case $MACHINE_TYPE in
      Linux) sudo apt-get install build-essentials; sudo apt-get install cmake python3-dev python-dev vim;;
      Mac) brew remove vim; brew install cmake macvim python;;
      *) echo "Platform unsupported. Please manualy install the following and re-run this script: compiler toochain, cmake, pyhton dev symbols, vim"; exit ;;
    esac
fi

# check that zsh is installed
if $CONFIGURE_ZSH;
  then
    case $MACHINE_TYPE in
      Linux) sudo apt-get install zsh python-pygments;;
      Mac) brew install zsh python-pygments ;;
      *) echo "Platform unsupported. Please manualy install the following and re-run this script: zsh"; exit ;;
    esac
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
I
if $CONFIGURE_VIM ;
then
    # compile ycm
    cd ~/.vim/bundle/YouCompleteMe
    python3 install.py --all
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
  use_repo https://github.com/romkatv/powerlevel10k.git $DIR/oh-my-zsh/custom/themes/powerlevel10k
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

  vim +'PlugInstall --sync' +qa
fi

wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf
if [ $MACHINE_TYPE = "Linux" ]
then
  sudo mv "DejaVu Sans Mono Nerd Font Complete Mono.ttf" /usr/share/fonts/truetype
  sudo apt install language-pack-en
else
  echo "Please install the font that was just downloaded to your home directory: DejaVu Sans Mono Nerd Font Complete Mono.ttf"

fi
mkdir ~/config/tmp
