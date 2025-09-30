# Install the supporting tools that Docker would need to run:
sudo apt install apt-transport-https ca-certificates curl \
gnupg-agent software-properties-common

# Download the Docker gpg key and add it to the apt package manager:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-\
keyring.gpg
