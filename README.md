## Hotbox Version 1.0.1
**Scroll down to get the links on setting up a migrating your current witness.**

### Starting up a new witness:
For information on securing your server please read the [official documentation](https://cdn.discordapp.com/attachments/491080454372327435/495224522556047361/Smoke.io_Witness_Guide_v1.3.pdf) for Smoke witnesses.

If at anytime while using this guide, these instructions are unclear or you get stuck please message me on Discord. You can find be me in the [smoke.io Discord group](https://discord.gg/MpJH3qq) as "J. R. Swab".

For a video walk through check out [this Bitchute video](https://www.bitchute.com/video/-TDVmen14AM/)

The instructions for using this docker for a new witness can be found at [this Smoke post](https://smoke.io/witness/@jrswab/updated-witness-hotbox-install-directions)

### Moving an existing witness to the Hotbox:
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
8. `docker pull jrswab/hotbox:1.0.1`
8. `./runDocker.sh`
    * To specify ports just add them to the end eg. `./runDocker.sh 20001 28090`
    * If no ports are specified the script will expose port 2001 to 20001 and port 8090 to 28090.
    * If you have a firewall make sure to open the ports used.
8. `./enterHotbox.sh` to enter docker.
    * **Using the enterHotbox script is needed**
    * It is the only way to detatch from docker whil keeping it running with the commands below.
9. `tmux new -s hotbox`
10. `cd smoke`
11. `./smoked`
12. `ctrl+b c` to make a new Tmux window.
13. `cd smoke`
14. `./run_wallet.sh`
15. Unlock the wallet with your secret passphrase (it seems smoked will run fine even if the wallet is locked as well).
16. Re-enable your witness.

To get back to the smoked screen to see the blocks fall into place type `ctrl+b 0`.

### To detach from the Docker:
1. `ctrl+b c` to open a new Tmux window (needed to detach).
2. `ctrl+h ` to detach the docker to the background of your server

### To enter the detached Docker and see witness feed:
1. `./enterhotbox` (after typing this it may look like it hangs. Just press enter and you will see the docker prompt.)
2. `tmux a` - to enter your detached tmux session (if you detached tmux before exiting the docker)

### To check and make sure the docker container did not exit use:
* `docker container ps -a`.
  * You should see something like:
    * `8753ea10189a jrswab/hotbox "/bin/bash" 22 minutes ago Up 22 minutes 0.0.0.0:20001->2001/tcp, 0.0.0.0:28090->8090/tcp hotbox`

---

Hope this docker is helpful in making running a witness more predictable and reliable.

If you have any ideas on how to make this better please let me know or submit a pull request.