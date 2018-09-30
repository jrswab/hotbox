#!/bin/bash
# see if smoked exists
if [ ! -f ~/smoke/smoked ]; then 
	cd ~/smoke

	wget https://github.com/smokenetwork/smoked/releases/download/v0.0.5/smoked-0.0.5-x86_64-linux.tar.gz

	wget https://github.com/smokenetwork/smoked/releases/download/v0.0.5/cli_wallet-0.0.5-x86_64-linux.tar.gz

	tar -xzf smoked-0.0.5-x86_64-linux.tar.gz
	tar -xzf cli_wallet-0.0.5-x86_64-linux.tar.gz

	rm *.gz

	sleep 2

	# Launch script in background
	~/smoke/smoked &
	# Get its PID
	smokePID=$!
	# Wait for 2 seconds
	sleep 2
	# Kill it
	kill -INT $smokePID
	sleep 4
	# move updated config
	cp ~/config/config.ini.example witness_node_data_dir/config.ini
	# move wallet execution script
	mv ~/wallet.sh ~/smoke/run_wallet.sh
else
	echo 'Smoke directory found'
fi

exit
