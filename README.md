# Hotbox Version 2.0
![hotbox-2](https://cloudflare-ipfs.com/ipfs/QmeCnxqWL8mZzdQ3aaC5dXothJ2utX9G2Kg7iwkGHoqozg)
## Contents:
- [Starting a New Witness](#starting-a-new-witness)
- [Update a Current Hotbox](#updating-a-current-hotbox-instance)
- [Move a Non-Hotbox Witness to the Hotbox](#moving-a-non-hotbox-existing-witness-to-the-hotbox)
- [Detaching From the Hotbox](#to-detach-from-the-hotbox)
- [To enter the Hotbox](#to-enter-the-hotbox)
- [Check to make sure the Hotbox is running](#check-if-hotbox-is-running)

## Starting up a new witness
For information on securing your server please read the [official documentation](https://cdn.discordapp.com/attachments/421494316301811725/528077336944443402/Smoke.io_Witness_Guide_v1.4.pdf)
If at anytime while using this guide, these instructions are unclear or you get stuck please message me on Discord. You can find be me in the [smoke.io Discord group](https://discord.gg/MpJH3qq) as "J. R. Swab".

1. [Use the official instructions to install Docker for ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
1. Clone the Hotbox Git repository: `git clone https://gitlab.com/jrswab/hotbox`
1. `cd hotbox`
1. `docker pull jrswab/hotbox`
2. `./run.sh`
    - To specify ports just add them directly after run.sh eg. `./run.sh 20001 28090`
    - If no ports are specified the script will expose port 2001 to 20001 and port 8090 to 28090.
3. `./wallet.sh`
4. `set_password *PickPassphrase*`
5. `unlock *YourPassphrase*`
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
    - Now the witness is running.
    - Wait until you see `handled block ] Got 1 transactions on block` showing on the screen.
    - Once you see them you can now enable your witness.
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
  * You should see something like: `8753ea10189a jrswab/hotbox "/bin/bash" 22 minutes ago Up 22 minutes 0.0.0.0:20001->2001/tcp, 0.0.0.0:28090->8090/tcp hotbox`
  * If you see the work "exited" your Hotbox is not running. To restart, run:
    * `docker rm hotbox`
    * `run.sh`

---

Hope this docker is helpful in making running a witness more predictable and reliable.

If you have any ideas on how to make this better please let me know or submit a pull request.