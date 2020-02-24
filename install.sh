#!/bin/bash
SV="0.1.0"
WV="0.0.6"

# see if smoked exists
if [ ! -f ~/.smoke/smoked ]; then 
	cd ~/.smoke

	# download smoked and wallet
	wget https://github.com/smokenetwork/smoked/releases/download/v${SV}/smoked-${SV}-x86_64-linux.tar.gz
	wget https://github.com/smokenetwork/smoked/releases/download/v${WV}/cli_wallet-${WV}-x86_64-linux.tar.gz
	
	# extract smoked and wallet
	tar -xzf smoked-${SV}-x86_64-linux.tar.gz
	tar -xzf cli_wallet-${WV}-x86_64-linux.tar.gz
	
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
