#!/bin/bash

# This is a script that is used to initialize, or connect to tmux sessions both
# remotely and locally


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


SSH_COMMAND="ssh -o ConnectTimeout=$TIMEOUT -o ForwardX11=yes -o ForwardX11Trusted=yes -o ForwardAgent=yes -L 8181:localhost:8181 -L 8250:localhost:8250 -L 9191:localhost:9191 -t $HOST \"$TMUX_SESSION_EXISTS $SESSION_NAME || $TMUX_NEW $SESSION_NAME; $TMUX_ATTACH $SESSION_NAME\""
if [ -z "$TMUX" ]; then
  # if we are not in a tmux session, then we can go ahead and connect to the remote host via ssh
  $SSH_COMMAND
else
  if [ -z "$HOST" ] || [ "$HOST" = "localhost" ]; then
    # If we are requesting a local dev session, switch the current client to it.
    $TMUX_SESSION_EXISTS "$SESSION_NAME"
    if [ $? -ne 0 ]; then
      $TMUX_NEW "$SESSION_NAME"
    fi
    tmux switch-client -t "$SESSION_NAME"
    exit 0
  fi
  # if we are in a tmux session, then we need to spawn a new terminal that is not a tmux session so that we do not end up with nested tmux sessions
  # NOTE: we need to set TMUX=skip_auto_launch_tmux_zsh (just any nonzero string) so that ghostty does not automatically launch a new tmux session
  nohup env TMUX=skip_auto_launch_tmux_zsh ghostty -e /bin/zsh -c "$SSH_COMMAND" >/dev/null 2>&1 & disown
fi


