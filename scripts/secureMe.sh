#!/bin/sh

# Change root password (optional):
echo "Would you like to change the Root password? (Recomended if the server is new) [y|n]"
echo "If your server already had you do this press n"
read -r chgRoot
if [ "$chgRoot" = "y" ]; then
    passwd
fi

echo ""
echo "Updating Your Operating System:"
sleep 2;
apt-get update && apt-get upgrade;

echo ""
echo "Installing firewall:";
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

echo ""
echo "Open a new terminal or putty session."
echo "Try to login again as root with your new password to make sure you are not locked out."
echo "Were you able to log back in? [y|n]"
read -r access
if [ "$access" = "n" ]; then
    ufw disable;
    echo "Disabled Firewall"
    echo "Try to login again as root with your new password to make sure you are not locked out."
    echo "Were you able to log back in? [y|n]"
    read -r access2
    if [ "$access2" = "n" ]; then
        echo "Please check your Root password and try again."
        echo "If the problem persists, leave this SSH session open and message the support channel in the Hotbox Discord server."
    fi
    exit 1
fi

# Install Docker:
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl enable docker

# user has access:
echo "The Hotbox can not be run as root."
echo "So let's create a new user."
echo ""
echo "Choose a user name."
read -r username
if [ "$username" = "" ]; then
   echo "No name entered; please enter a name:"
   read -r username
fi

adduser --gecos "" "$username"
usermod -a -G sudo "$username"
groupadd docker
usermod -aG docker "$username"

echo "Open a new terminal or putty session"
echo "Login with your new username and password."
echo "Was the login successful? (y|n)"
read -r userLogin

# Check if the hotbox directory exists on the server.
# If not change to the home directory
if [ ! -d /home/"$username"/hotbox ]; then
	cd /home/"$username"/
	runuser -l "$username" -c 'mkdir hotbox' &&
	cd /home/"$username"/hotbox &&
	runuser -l "$username" -c 'wget https://github.com/jrswab/hotbox/releases/download/v2.0.5/run.sh' &&
	runuser -l "$username" -c 'chmod 550 run.sh';
	runuser -l "$username" -c 'docker pull jrswab/hotbox'
fi

# disable root login and updat fstab
if [ "$userLogin" = "y" ]; then
    # deleting with sed and appending with echo due to differences between OSes
    sed -i '/PermitRootLogin yes/c\' /etc/ssh/sshd_config
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config

    echo "tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0" >> /etc/fstab

    echo ""
    echo "Only use the newly created user from now on."
    echo ""
    echo "Server reboot required. Once rebooted login as your new user."
    echo "Root login over ssh has been disabled for server saftey."
fi