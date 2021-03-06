#!/bin/bash -x

# Parameters:
# IP List (file path)
# remote host username

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for i in $(cat < "$1"); do
  echo "Sending .ssh/id_rsa.pub to Host: $i"
  ssh $2@$i 'mkdir -p .ssh'
  cat /var/lib/jenkins/.ssh/id_rsa.pub | ssh $2@$i 'cat >> .ssh/authorized_keys'
  ssh $2@$i 'chmod 700 .ssh; chmod 640 .ssh/authorized_keys'
done

echo "Script Ends..."
