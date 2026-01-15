#!/bin/bash

# This is a script that connects to tmux sessions on a remote host


###############################################################################
############## CONSTANTS SETUP ################################################
###############################################################################

TMUX_SESSION_EXISTS="tmux has-session -t "
TMUX_NEW="tmux  new -d -s "
TMUX_ATTACH="tmux attach -t "

###############################################################################
############## PROCESS ARGS ###################################################
###############################################################################

SESSION_NAME="dev"
HOST="localhost"
TIMEOUT=10


show_usage()
{
  echo "dev [options] [host]
  A helper script for connecting to tmux sessions on a remote host

  NOTE: if you are having issues with ssh-agent forwarding to the remote host, 
  follow this guide: https://blog.testdouble.com/posts/2016-11-18-reconciling-tmux-and-ssh-agent-forwarding/

  [options]
    -n|--name NAME: Provide the name of the session that should be created or c
             onnected to. If not provided, will default to 'dev'
    -t|--timeout SECOND: Connection timeout in seconds
    -h|--help: Show this help
  [host]: Provide the ip address or hostname to connect to.
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
    -t|--timeout) TIMEOUT=$2
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
    HOST="${POSITIONAL[0]}"
  fi

#echo "all done parsing"
#echo "local session=$LOCAL_SESSION"
#echo "session name=$SESSION_NAME"
#echo "host=$HOST"
#echo $TIMEOUT

if [ -n "$TMUX" ]; then
  echo "Run this from a non-tmux shell to avoid nesting."
  exit 1
fi

if [ -z "$HOST" ] || [ "$HOST" = "localhost" ]; then
  echo "A remote host is required."
  show_usage
  exit 1
fi

ssh_cmd=(
  ssh
  -o ConnectTimeout=$TIMEOUT
  -o ForwardX11=yes
  -o ForwardX11Trusted=yes
  -o ForwardAgent=yes
  -L 8181:localhost:8181
  -L 8250:localhost:8250
  -L 9191:localhost:9191
  -t "$HOST"
  "$TMUX_SESSION_EXISTS $SESSION_NAME || $TMUX_NEW $SESSION_NAME; $TMUX_ATTACH $SESSION_NAME"
)
exec "${ssh_cmd[@]}"
