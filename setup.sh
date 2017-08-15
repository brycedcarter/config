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
