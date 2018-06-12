#!/bin/bash

#if there is not a forwarded agent then ask for key selection
ssh-add -L >/dev/null
if [ $? -eq 1 ];
then
  if [[ $1 =~ ^(fetch|pull|push|remote|submodule|daemon|update-server-info)$ ]];
  then
    if [ -f ~/config/tmp/last_git_ssh_id ];
    then
      lastId=$(cat ~/config/tmp/last_git_ssh_id)
      echo "Please enter ssh id path (or press enter for $lastId)..."
      read idFile
      if [[ -z $idFile ]];
      then
        idFile=$lastId 
      fi 
    else
      echo "Please enter ssh id path..."
      read idFile
    fi

    idFile_expanded=${idFile/#\~/$HOME}
    if [ ! -f $idFile_expanded ];
    then
      
      echo "$idFile_expanded does not exist."
      exit 1
    else
      echo $idFile_expanded > ~/config/tmp/last_git_ssh_id
    fi 
    echo Using $idFile_expanded for ssh id...
    export GIT_SSH_COMMAND="ssh -i $idFile_expanded"
  fi
elif [ -t 1 ];
then 
  if [[ $1 =~ ^(fetch|pull|push|remote|submodule|daemon|update-server-info)$ ]];
  then
    echo "Using agent ssh key"
  fi
fi

git "$@"

