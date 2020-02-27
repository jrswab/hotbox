#!/bin/sh

green='\033[0;32m'
nc='\033[0m' # No Color

# Change root password (optional):
printf "%s""${green}"
printf "Would you like to change the Root password? (Recomended if the server is new) [y|n]"
printf "If your server already had you do this type n and press enter%s""${nc}"
read -r chgRoot
if [ "$chgRoot" = "y" ]; then
    passwd
fi

printf "%s""${green}"
printf "Updating Your Operating System:%s""${nc}"
sleep 2;
apt-get update && apt-get upgrade;

printf "%s""${green}"
printf "Installing firewall:%s""${nc}";
sleep 2;
apt-get install ufw;
ufw allow ssh &&
ufw allow 2001 &&
ufw allow 8090 &&
ufw deny http &&
ufw deny https && 
ufw default deny incoming &&
ufw default allow outgoing &&
ufw limit openssh &&
# User will be asked:
# Command may disrupt existing ssh connections. Proceed with operation (y|n)?
# Add to the updated walkthrough
ufw enable;

printf "%s""${green}"
printf "Open a new terminal or putty session."
printf "Try to login again as root with your new password to make sure you are not locked out."
printf "Were you able to log back in? [y|n]%s""${nc}"
read -r access
if [ "$access" = "n" ]; then
    ufw disable;
    printf "%s""${green}"
    printf "Disabled Firewall"
    printf "Try to login again as root with your new password to make sure you are not locked out."
    printf "Were you able to log back in? [y|n]%s""${nc}"
    read -r access2
    if [ "$access2" = "n" ]; then
        printf "%s""${green}"
        printf "Please check your Root password and try again."
        printf "If the problem persists, leave this SSH session open and message the support channel in the Hotbox Discord server.%s""${nc}"
    fi
    exit 1
fi

# Install Docker:
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl enable docker

# user has access:
printf "%s""${green}"
printf "The Hotbox can not be run as root."
printf "So let's create a new user."
printf ""
printf "Choose a user name."
read -r username
if [ "$username" = "" ]; then
   printf "No name entered; please enter a name:%s""${nc}"
   read -r username
fi

adduser --gecos "" "$username"
usermod -a -G sudo "$username"
groupadd docker
usermod -aG docker "$username"

printf "%s""${green}"
printf "Open a new terminal or putty session"
printf "Login with your new username and password."
printf "Was the login successful? (y|n)%s""${nc}"
read -r userLogin

# disable root login and updat fstab
if [ "$userLogin" = "y" ]; then
    # deleting with sed and appending with printf due to differences between OSes
    sed -i '/PermitRootLogin yes/c\' /etc/ssh/sshd_config
    printf "PermitRootLogin no" >> /etc/ssh/sshd_config

    printf "%s""${green}"
    printf "Root login over ssh has been disabled for server saftey.%s""${nc}"
fi

printf "tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0" >> /etc/fstab

# Check if the hotbox directory exists on the server.
# If not change to the home directory
if [ ! -d /home/"$username"/hotbox ]; then
	cd /home/"$username"/ &&
	runuser -l "$username" -c 'mkdir hotbox' &&
	runuser -l "$username" -c 'touch hotbox/run.sh' &&
	runuser -l "$username" -c 'wget --output-document=hotbox/run.sh https://github.com/jrswab/hotbox/releases/download/v2.0.5/run.sh' &&
	runuser -l "$username" -c 'chmod 550 hotbox/run.sh';
	runuser -l "$username" -c 'docker pull jrswab/hotbox'
fi

printf "%s""${green}"
printf "Only use the newly created user from now on."
printf "Server reboot required. Once rebooted login as your new user.%s""${nc}"