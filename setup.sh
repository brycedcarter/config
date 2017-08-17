DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

# check that vim is installed
if ! command -v vim;
then
	echo "Please install vim and rerun the setup script"
	exit
fi

# check that zsh is installed
if ! command -v zsh;
then
	echo "Please install zsh and rerun the setup script"
	exit
fi

if command -v wget;
then
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
elif command -v curl;
then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

cd ~
mkdir -p config-backups

while read filename;
do 
	echo "Backing up and linking $filename"
	cp -L .$filename config-backups/$filename-$current_time
	ln -fs config/$filename ./.$filename
done < $DIR/managed_files.txt

if git -C $DIR/oh-my-zsh/custom/plugins/zsh-syntax-highlighting rev-parse;
then
cd $DIR/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git pull
else
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $DIR/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi


if git -C ~/.vim/bundle/Vundle.vim rev-parse;
then
cd ~/.vim/bundle/Vundle.vim
git pull
else
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi


# install the vim theme
mkdir ~/.vim/colors
ln -f -s $DIR/vim/colors/brycedcarter.vim ~/.vim/colors/brycedcarter.vim

brew tap caskroom/fonts
brew cask install font-hack-nerd-font
