
# remove oh-my-zsh
if [ -d ~/.oh-my-zsh ];
then
  echo "Uninstalling oh-my-zsh"
  #bash uninstall_oh_my_zsh
fi

# replace backups
for filename in ~/config-backups/*-latest
do
  raw_name="$(echo $filename | sed -E 's/.*\/config-backups\/(.*)-latest$/\1/g')"
  #echo "Returning ~/config-backups/ $filename to "
done 

# remove backups dir

