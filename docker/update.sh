#!/bin/bash

# Move into smoke directory
cd ~/.smoke

# Make sure the witness is disabled
echo "Did you remember to disable your witness via wallet.sh? (y|n)"
read input
if [ $disabled != "y" ]; then
    echo "Exiting without upgrade."
    exit
fi

# download smoked and wallet
wget https://github.com/smokenetwork/smoked/releases/download/v0.1.0/smoked-0.1.0-x86_64-linux.tar.gz
wget https://github.com/smokenetwork/smoked/releases/download/v0.0.6/cli_wallet-0.0.6-x86_64-linux.tar.gz

# extract smoked and wallet
tar -xzf smoked-0.1.0-x86_64-linux.tar.gz
tar -xzf cli_wallet-0.0.6-x86_64-linux.tar.gz

# remove tar files
rm *.gz

# wait two seconds
sleep 2

# Tell user update is complete
echo "Smoked and CLI Wallet are now up to date"

# Move back to home directory
cd

exit
