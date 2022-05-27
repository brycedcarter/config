#!/bin/bash

# This is a script that is used to initialize, or connect to tmux sessions both
# remotely and locally


###############################################################################
############## CONSTANTS SETUP ################################################
###############################################################################

TMUX_SESSION_EXISTS="tmux has-session -t "
TMUX_NEW="tmux  new -d -s "
TMUX_ATTACH="tmux -CC attach -t "

###############################################################################
############## PROCESS ARGS ###################################################
###############################################################################

LOCAL_SESSION=true
SESSION_NAME="dev"
HOST="localhost"


show_usage()
{
  echo "dev [options] [host]
  A helper script for creating or connecting to tmux sessions either locally 
  or remotely

  [options]
    -n|--name NAME: Provide the name of the session that should be created or c
             onnected to. If not provided, will default to 'dev'
    -h|--help: Show this help
  [host]: Provide the ip address or hostname to connect to. If not provided, 
          just use the current terminal instead of an ssh tunnel
  "
}

POSITIONAL=()
while test $# != 0
do
    case "$1" in
    -n|--name) 
      SESSION_NAME="$2"
      shift # consume 1 arg
      ;;
    -h|--help) show_usage; exit 0;;
    *) 
      POSITIONAL+=($1)
      ;;
    esac
    shift
  done

  if [ "${#POSITIONAL[@]}" -gt 1 ]; then
    echo "Invalid arguments"
    show_usage
  elif [ "${#POSITIONAL[@]}" -eq 1 ] ; then 
    LOCAL_SESSION=false
    HOST="${POSITIONAL[0]}"
  fi

#echo "all done parsing"
#echo "local session=$LOCAL_SESSION"
#echo "session name=$SESSION_NAME"
#echo "host=$HOST"

if $LOCAL_SESSION; then 
  $($TMUX_SESSION_EXISTS  $SESSION_NAME)
  if [ $? -ne 0 ]; then
    $TMUX_NEW $SESSION_NAME
  fi 
  $TMUX_ATTACH $SESSION_NAME
else
  ssh -o ForwardX11=yes -o ForwardX11Trusted=yes -o ForwardAgent=yes -t $HOST "$TMUX_SESSION_EXISTS $SESSION_NAME || $TMUX_NEW $SESSION_NAME; $TMUX_ATTACH $SESSION_NAME"
fi 
