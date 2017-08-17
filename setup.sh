DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

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


if git -C ~/.vim/bundle/Vundle.vim;
then
cd ~/.vim/bundle/Vundle.vim
git pull
else
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

brew tap caskroom/fonts
brew cask install font-hack-nerd-font
