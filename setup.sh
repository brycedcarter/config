#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

# determine some info about the run envrionment and the arguments
CONFIGURE_VIM=false
CONFIGURE_ZSH=false
FORCE_YCM=false

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
    --ycm) FORCE_YCM=true ;;
    *) echo "Unknown arument: $1";;
    esac
    shift
  done

show_banner()
{
  echo -e "\x1b[32m======================= $1 =======================\x1b[0m"
}

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
# generally usefully stuff
case $MACHINE_TYPE in
  Linux) sudo apt-get update; sudo apt-get install wget;;
  Mac) brew update; brew install wget;;
  *) echo "Platform unsupported. Please manually install the following and re-run this script: wget"; exit ;;
esac


# check that vim is installed
if $CONFIGURE_VIM;
then
    show_banner "INSTALLING VIM"
    case $MACHINE_TYPE in
      Linux) sudo apt-get install build-essentials; sudo apt-get install cmake python3-dev python-dev vim universal-ctags fzf;;
      Mac) brew remove vim; brew install cmake macvim python fzf; brew install --HEAD universal-ctags/universal-ctags/universal-ctags;;
      *) echo "Platform unsupported. Please manually install the following and re-run this script: compiler toolchain, cmake, python dev symbols, vim, universal ctags"; exit ;;
    esac
fi

# check that zsh is installed
if $CONFIGURE_ZSH;
  then
    show_banner "INSTALLING ZSH"
    case $MACHINE_TYPE in
      Linux) sudo apt-get install zsh python-pygments ripgrep;;
      Mac) brew install zsh python-pygments ripgrep;;
      *) echo "Platform unsupported. Please manually install the following and re-run this script: zsh"; exit ;;
    esac
fi

# ========================== PERFORM ACTIONS ====================================

if $CONFIGURE_ZSH;
then
  if [ ! -d "~/.oh-my-zsh" ]; then
    show_banner "INSTALLING OH-MY-ZSH"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  fi
  show_banner "INSTALLING FZF KEY BINDINGS"
  /usr/local/opt/fzf/install --key-bindings --completion --no-update-rc
  
fi

if $CONFIGURE_VIM || $FORCE_YCM;
then
    if ! [[ -f ~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.cpython-39-darwin.so ]] || $FORCE_YCM; then
    show_banner "INSTALLING YOU-COMPLETE-ME"
     # compile ycm
    cd ~/.vim/bundle/YouCompleteMe
    python3 install.py --all
    fi
fi

cd ~
mkdir -p config-backups

# back up existing config files and replace them with links to the config repo files
show_banner "BACKING UP MANAGED FILES"
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
  show_banner "INSTALLING ZSH SYNTAX HIGHLIGHTING"
  # install zsh syntax highlighting
  use_repo https://github.com/zsh-users/zsh-syntax-highlighting.git $DIR/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  show_banner "INSTALLING POWERLEVEL10K"
  use_repo https://github.com/romkatv/powerlevel10k.git $DIR/oh-my-zsh/custom/themes/powerlevel10k
fi

if $CONFIGURE_VIM;
then
  # Install bundle
  show_banner "INSTALLING VUNDLE"
  use_repo https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  # install the vim theme
  show_banner "INSTALLING CUSTOM VIM THEME"
  if [ ! -d ~/.vim/colors ]
  then
    mkdir ~/.vim/colors
  fi
  ln -f -s $DIR/vim/colors/brycedcarter.vim ~/.vim/colors/brycedcarter.vim

  vim +'PlugInstall --sync' +qa
fi

if [ $MACHINE_TYPE = "Linux" ]
then
  show_banner "INSTALLING OVERPASS NERD FONT"
  wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Overpass/Mono/Regular/complete/Overpass%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.otf
  sudo mv "Overpass Mono Regular Nerd Font Complete Mono.otf" /usr/share/fonts/truetype
  sudo apt install language-pack-en
elif [ $MACHINE_TYPE = "Mac" ]
then
  show_banner "INSTALLING OVERPASS NERD FONT"
  brew tap homebrew/cask-fonts
  brew install --cask font-overpass-nerd-font
else
  show_banner "DOWNLOADING OVERPASS NERD FONT"
  wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Overpass/Mono/Regular/complete/Overpass%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.otf
  echo "Please install the font that was just downloaded to your home directory: DejaVu Sans Mono Nerd Font Complete Mono.ttf"

fi
mkdir ~/config/tmp
