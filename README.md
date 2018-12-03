# Hotbox Version 2.0
- [Update a Current Hotbox](## Updating a Current Hotbox Instance:)
- [Move a Non-Hotbox Witness to the Hotbox](## Moving an existing witness to the Hotbox:)

## Starting up a new witness:
For information on securing your server please read the [official documentation](https://cdn.discordapp.com/attachments/491080454372327435/495224522556047361/Smoke.io_Witness_Guide_v1.3.pdf) for Smoke witnesses.

If at anytime while using this guide, these instructions are unclear or you get stuck please message me on Discord. You can find be me in the [smoke.io Discord group](https://discord.gg/MpJH3qq) as "J. R. Swab".

For a video walk through check out [this Bitchute video](https://www.bitchute.com/video/-TDVmen14AM/)

The instructions for using this docker for a new witness can be found at [this Smoke post](https://smoke.io/witness/@jrswab/updated-witness-hotbox-install-directions)

## Updating a Current Hotbox Instance:
1. Disable your witness
    * `update_witness "username" "url" "SMK1111111111111111111111111111111114T1Anm" {} true`
    * Replace `username` and `url` with your information.
    * Copy and paste the command into the CLI_Wallet.
    * Wait for it to broadcast. You will see some yellow words scroll by and then a group of grayish-white text.
3. Close your wallet with `ctrl+d` if open.
4. Shut down smoked with `ctrl+c`.
5. Make a copy of your smoke directory:
    * `cp -r ~/smoke ~/smokebackup`
6. Pull the Hotbox Git repository:
    * `cd` - this is to move into your home directory
    * `git clone https://gitlab.com/jrswab/hotbox`
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


## Moving an existing witness to the Hotbox:
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

## To detach from the Docker:
1. `ctrl+b c` to open a new Tmux window (needed to detach).
2. `ctrl+h ` to detach the docker to the background of your server

## To enter the detached Docker and see witness feed:
1. `./run.sh` (after typing this it may look like it hangs. Just press enter and you will see the docker prompt.)
2. `tmux a` - to enter your detached tmux session (if you detached tmux before exiting the docker)

## To check and make sure the docker container did not exit use:
* `docker container ps -a`.
  * You should see something like:
    * `8753ea10189a jrswab/hotbox "/bin/bash" 22 minutes ago Up 22 minutes 0.0.0.0:20001->2001/tcp, 0.0.0.0:28090->8090/tcp hotbox`

---

Hope this docker is helpful in making running a witness more predictable and reliable.

If you have any ideas on how to make this better please let me know or submit a pull request.