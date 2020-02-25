# Hotbox Version 2.0
The goal of this project is to make running a witness for smoke.io more predictable and reliable.

If you have any ideas on how to make this better please let me know or submit a pull request.

## Contents:
- [Starting a New Witness](#starting-a-new-witness)
- [Update a Current Hotbox](#updating-a-current-hotbox-instance)
- [Move a Non-Hotbox Witness to the Hotbox](#moving-a-non-hotbox-existing-witness-to-the-hotbox)
- [Detaching From the Hotbox](#to-detach-from-the-hotbox)
- [To enter the Hotbox](#to-enter-the-hotbox)
- [Check to make sure the Hotbox is running](#check-if-hotbox-is-running)

## Starting up a new witness
A video walkthrough can be found on [bitchute](https://www.bitchute.com/video/7E6cl7p1uTmt/).
The video and the walkthrough below assume you are using Ubuntu.
If at anytime while using this guide, these instructions are unclear or you get stuck please message me on Discord.
You can find be me in the [smoke.io Discord group](https://discord.gg/MpJH3qq) as "J. R. Swab".

### Pre-Hotbox Server Setup:
 - If you are on Windows, [download Putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) to connect to your server.
 - MacOS and Linux users use your terminal.
#### As The Root User:
1. Change Root Password:
   - Trust no one. Even your hosting service.
   - Run: `passwd`
1. Update your server:
   - `apt-get update`
   - `apt-get upgrade`
1. Install a Firewall
   - `apt-get install ufw`
   - `ufw allow ssh`
   - `ufw allow 2001` - Smoked uses this port
   - `ufw allow 8090` - Smoked uses this port
   - `ufw deny http`
   - `ufw deny https`
   - `ufw default deny incoming`
   - `ufw default allow outgoing`
   - `ufw limit OpenSSH` - Helps prevent brute force attacks
   - `ufw enable`
2. Open a new terminal or putty session
3. Try to login again to make sure you are not locked out.
1. Create user (replace new_username with something else):
   - `# adduser new_username`
2. Add your new_username to the SUDO group:
   - `# usermod -a -G sudo new_username`
3. Create a password for the new user:
   - `# passwd new_user`
3. Set up Docker group and add your new user:
   - `sudo groupadd docker`
   - `sudo usermod -aG docker new_username`
4. Open a new terminal or putty session
5. Login with your new username and password.
   - If successful only use this user from now on.

#### As Your Created User:
1. Disable Root Login (optional but recomended):
   - `sudo nano /ect/ssh/sshd_config`
   - Change "PermitRootLogin" to no.
6. Update Your Shared Memory:
   - `sudo nano /etc/fstab`
   - At the bottom add: `tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0`
   - Save the file.
   - Reboot: `sudo reboot now`
1. Once the server is rebooted log back in as your created user.
1. Install Git
   - Ubuntu `sudo apt-get install git`
1. Install Docker
   - [Use the official instructions from Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

### Installing the Hotbox:
!You need to run the following commands as the user you created above

!Do not run these as root or else the Hotbox will not have access to the files it needs
1. `cd`
1. `mkdir hotbox`
3. `cd hotbox`
4. `git init`
1. Clone the Hotbox Git repository: `git pull https://gitlab.com/jrswab/hotbox`
1. `cd hotbox`
1. `docker pull jrswab/hotbox`
2. `./run.sh`
    - To specify ports just add them directly after run.sh eg. `./run.sh 20001 28090`
    - If no ports are specified the script will expose port 2001 to 20001 and port 8090 to 28090.
3. `./wallet.sh`
4. `set_password *PickPassphrase*`
5. `unlock <password set with set_password>`
5. `import_key *Your Smoke Private Active Key*`
6. `suggest_brain_key`
    - This will give you three keys. A private brain key (all words), a private WIF, and a Public WIF in that order from top to bottom.
    - Save these in a safe place. If you can I recommend encrypting them.
7. `import_key *Private WIF*`
    - Use the private WIF from the suggested brain key command above.
8. `ctrl+b` `c` to open a new Tmux window
9. `./config.sh`
    - Vim is also included in the Docker if you prefer that editor. Use `./config.sh vim`
10. Find the line that says `#witness =`
    - remove the `#` and add your Smoke username
    - eg. witness = "jrswab"
    - Quotes are required.
11. Find the line that says `#private-key =`
    - remove the # and add your private WIF we got from the wallet in step 10.
    - eg. `private-key = xxxxxxxxxxxxxxxx`
    - No quotes around the key.
12. Save and exit the config
    - In nano: ctrl + x then y to save the press enter to execute.
13. `./smoked.sh`
    - Now the witness is running. Wait until you see `handled block ] Got 1 transactions on block` showing on the screen. Once you see them you can now enable your witness.
14. `ctrl+b 0` to go back to the screen with your wallet.
15. `update_witness "username" "url" "Public Key" {} true`
    - Replace username and url with your information.
    - The "Public Key" is the public key we got from the wallet in step 10.
    - Copy and paste the command into the CLI_Wallet.
    - Wait for it to broadcast. You will see some yellow words scroll by and then a group of grayish-white text.

Now you can go back to the feed with `ctrl+b 1` to see the blocks!
Congrats! You are a witness now!

## Updating a Current Hotbox Instance
***[Watch this Bitchute video!](https://www.bitchute.com/video/XyaHGHj7x9lV/)***

1. Disable your witness
    * `update_witness "username" "url" "SMK1111111111111111111111111111111114T1Anm" {} true`
    * Replace `username` and `url` with your information.
    * Copy and paste the command into the CLI_Wallet.
    * Wait for it to broadcast. You will see some yellow words scroll by and then a group of grayish-white text.
3. Close your wallet with `ctrl+d` if open.
4. Shut down smoked with `ctrl+c`.
5. Make a copy of your smoke directory:
    * `cp -r ~/hotbox/smoke ~/smokebackup`
6. Pull the Hotbox Git repository:
    * `cd` - this is to move into your home directory
    * Remove old rep `sudo rm -r ~/hotbox` (Make sure to double check that your config.ini file is backed up!)
    * `git clone https://gitlab.com/jrswab/hotbox`
8. `docker pull jrswab/hotbox`
8. `./run.sh`
    * To specify ports just add them to the end eg. `./run.sh 20001 28090`
    * If no ports are specified the script will expose port 2001 to 20001 and port 8090 to 28090.
    * If you have a firewall make sure to open the ports used.
11. `./smoked.sh`
12. `ctrl+b c` to make a new Tmux window.
14. `./wallet.sh`
15. Unlock the wallet with your secret passphrase.
16. Re-enable your witness.
17. Re-lock your wallet (it seems smoked will run fine even if the wallet is locked and it's safer)

## Moving a Non Hotbox Witness to the Hotbox
1. Disable your witness
    * `update_witness "username" "url" "SMK1111111111111111111111111111111114T1Anm" {} true`
    * Replace `username` and `url` with your information.
    * Copy and paste the command into the CLI_Wallet.
    * Wait for it to broadcast. You will see some yellow words scroll by and then a group of grayish-white text.
2. [Use the official instructions to install Docker for ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
3. Close your wallet with `ctrl+d` if open.
4. Shut down smoked with `ctrl+c`.
5. Make a copy of your smoke directory:
    * `cp -r ~/smoke ~/smokebackup`
6. Pull the Hotbox Git repository:
    * `cd` - this is to move into your home directory
    * `git clone https://gitlab.com/jrswab/hotbox`
7. Copy your smoke directory into hotbox:
    * `cp -r ~/smoke/* ~/hotbox/smoke`
8. `docker pull jrswab/hotbox:latest`
8. `./run.sh`
    * To specify ports just add them to the end eg. `./run.sh 20001 28090`
    * If no ports are specified the script will expose port 2001 to 20001 and port 8090 to 28090.
    * If you have a firewall make sure to open the ports used.
11. `./smoked.sh`
12. `ctrl+b c` to make a new Tmux window.
14. `./wallet.sh`
15. Unlock the wallet with your secret passphrase.
16. Re-enable your witness.
17. Relock your wallet (it seems smoked will run fine even if the wallet is locked and it's safer)

To get back to the smoked screen to see the blocks fall into place type `ctrl+b 0`.

## To detach from the Hotbox
1. `ctrl+b c` to open a new Tmux window (needed to detach).
2. `ctrl+h ` to detach the docker to the background of your server

## To enter the Hotbox
1. `./run.sh` (after typing this it may look like it hangs. Just press enter and you will see the docker prompt.)
2. If it looks like it hangs, if so just press enter to view the prompt

## Check if Hotbox is Running
* `docker container ps -a`.
* You should see something like:
  * `8753ea10189a jrswab/hotbox "/bin/bash" 22 minutes ago Up 22 minutes ...`
  * If you see the word "exited" your Hotbox is not running. To restart, run:
    * `docker rm hotbox`
    * `run.sh`
