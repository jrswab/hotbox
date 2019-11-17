#!/bin/bash
# see if smoked exists
if [ ! -f ~/.smoke/smoked ]; then 
	cd ~/.smoke

	# download smoked and wallet
	wget https://github.com/smokenetwork/smoked/releases/download/v0.0.6/smoked-0.0.6-x86_64-linux.tar.gz
	wget https://github.com/smokenetwork/smoked/releases/download/v0.0.6/cli_wallet-0.0.6-x86_64-linux.tar.gz
	
	# extract smoked and wallet
	tar -xzf smoked-0.0.7-x86_64-linux.tar.gz
	tar -xzf cli_wallet-0.0.6-x86_64-linux.tar.gz
	
	# remove tar files
	rm *.gz
	
	# wait two seconds
	sleep 2

	# Launch script in background
	~/.smoke/smoked &
	# Get its PID
	smokePID=$!
	# Wait for 2 seconds
	sleep 2
	# Kill it
	kill -INT $smokePID
	sleep 4
	# move preset config
	cp ~/.config/config.ini.example witness_node_data_dir/config.ini
	# move to home dir
	cd
fi

# run tmux
tmux new -s hotbox

exit
