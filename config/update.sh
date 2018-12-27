#!/bin/bash

# Move into smoke directory
cd ~/.smoke

# download smoked and wallet
https://github.com/smokenetwork/smoked/releases/download/v0.0.6/smoked-0.0.6-x86_64-linux.tar.gz
https://github.com/smokenetwork/smoked/releases/download/v0.0.6/cli_wallet-0.0.6-x86_64-linux.tar.gz

# extract smoked and wallet
tar -xzf smoked-0.0.6-x86_64-linux.tar.gz
tar -xzf cli_wallet-0.0.6-x86_64-linux.tar.gz

# remove tar files
rm *.gz

# wait two seconds
sleep 2

# Tell user update is complete
echo "Smoked and CLI Wallet Updated"

# Move back to home directory
cd

exit
