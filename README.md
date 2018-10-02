# Hotbox Version 1.0.0
Scroll down to see the steps on setting up a new witness.
### Moving an existing witness to the Hotbox:
1. Disable your witness
  a. `update_witness "username" "url" "SMK1111111111111111111111111111111114T1Anm" {} true`
  b. Replace `username` and `url` with your information.
  c. Copy and paste the command into the CLI_Wallet.
  d. Wait for it to broadcast. You will see some yellow words scroll by and then a group of grayish-white text.
2. [Use the official instructions to install Docker for ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
3. Close your wallet with `ctrl+d` if open.
4. Shut down smoked with `ctrl+c`.
5. Make a copy of your smoke directory:
  a. `cp -r ~/smoke ~/smokebackup`
6. Pull the Hotbox Git repository:
  a. `cd` - this is to move into your home directory
  b. `git clone https://gitlab.com/jrswab/hotbox`
7. Copy your smoke directory into hotbox:
  a. `cp -r ~/smoke/* ~/hotbox/smoke`
8. `./runDocker.sh`
  a. To specify ports just add them to the end eg. `./runDocker.sh 20001 28090`
  b. If no ports are specified the script will expose port 2001 to 20001 and port 8090 to 28090.
  c. If you have a firewall make sure to open the ports used.
9. `tmux new -s hotbox`
10. `cd smoke`
11. `./smoked`
12. `ctrl+b c` to make a new Tmux window.
13. `cd smoke`
14. `./run_wallet.sh`
15. Unlock the wallet with your secret passphrase.
16. Re-enable your witness.

To get back to the smoked screen to see the blocks fall into place type `ctrl+b 0`.

#### To detach from the Docker:
1. `ctrl+b d` to set tmux to run in the background of the docker container.
2. `ctrl+h ` to detach the docker to the background of your server

#### To enter the detached Docker and see witness feed:
1. `./enterhotbox` (after typing this it may look like it hangs. Just press enter and you will see the docker prompt.)
2. `tmux a` - to enter your detached tmux session

### Starting up a new witness:
For information on securing your server please read the [official documentation](https://cdn.discordapp.com/attachments/491080454372327435/495224522556047361/Smoke.io_Witness_Guide_v1.3.pdf) for Smoke witnesses.

If at anytime while using this guide, these instructions are unclear or you get stuck please message me on Discord. You can find be me in the [smoke.io Discord group](https://discord.gg/MpJH3qq) as "J. R. Swab".

1. [Install Docker for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
2. Pull the Hotbox Git repository:
  a. `cd` to be in your home directory
  b. `git clone https://gitlab.com/jrswab/hotbox`
3. ~~Copy your smoke directory into hotbox:~~
4. `cd hotbox` then `./runDocker.sh`
  a. To specify ports just add them to the end eg. `./runDocker.sh 20001 28090`
  b. If no ports are specified the script will expose port 2001 to 20001 and port 8090 to 28090.
  c. If you have a firewall make sure to open the ports used.
5. `./install.sh`
6. `cd smoke`
7. `./run_wallet.sh`
8. `set_password *PickPassphrase*`
9. `import_key *Your Smoke Private Active Key*`
10. `suggest_brain_key`
  a. This will give you three keys. A private brain key (all words), a private WIF, and a Public WIF in that order from top to bottom.
  b. Save these in a safe place. If you can I recommend encrypting them.
11. `import_key *Private WIF*`
  a. Use the private WIF from the suggested brain key command above.
12. `ctrl+b c` to open a new Tmux window
13. `cd smoke/witness_node_data_dir/`
14. `nano config.ini`
  a. Vim is also included in the Docker if you prefer that editor.
15. Find the line that says `#witness =`
  a. remove the `#` and add your Smoke username
  b. eg. `witness = "jrswab"`
  c. Quotes are required.
16. Find the line that says `#private-key =`
  a. remove the `#` and add your private WIF we got from the wallet in step 10.
  b. eg. `private-key = xxxxxxxxxxxxxxxx`
  c. No quotes around the key.
17. Save and exit the config
  a. In nano: `ctrl + x` then `y` to save the press `enter` to execute.
18. `cd ..`
19. `./smoked`
20. Now the witness is running. Wait until you see the words "handled block" showing on the screen. Once you see them you can now enable your witness.
21. `ctrl+b 0` to go back to the screen with your wallet.
22. `update_witness "username" "url" "Public Key" {} true`
  a. Replace `username` and `url` with your information.
  b. The "Public Key" is the public key we got from the wallet in step 10.
  c. Copy and paste the command into the CLI_Wallet.
  d. Wait for it to broadcast. You will see some yellow words scroll by and then a group of grayish-white text.
23. Now you can go back to the feed with `ctrl+b 1` to see the blocks!

Congrats! You are a witness now!

#### To detach from the Docker:
1. `ctrl+b d` to set tmux to run in the background of the docker container.
2. `ctrl+h ` to detach the docker to the background of your server
3. To check and make sure the docker container did not exit use `docker container ps -a`. You should see something like `8753ea10189a jrswab/hotbox "/bin/bash" 22 minutes ago Up 22 minutes 0.0.0.0:20001->2001/tcp, 0.0.0.0:28090->8090/tcp hotbox`

#### To enter the detached Docker and see witness feed:
1. `./enterhotbox` (after typing this it may look like it hangs. Just press enter and you will see the docker prompt.)
2. `tmux a` - to enter your detached tmux session

---

Hope this docker is helpful in making running a witness more predictable and reliable. If you have any ideas on how to make this better please let me know.