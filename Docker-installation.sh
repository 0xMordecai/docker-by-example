# Install the supporting tools that Docker would need to run:
sudo apt install apt-transport-https ca-certificates curl \
gnupg-agent software-properties-common

# Download the Docker gpg key and add it to the apt package manager:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-\
keyring.gpg

# You then need to add the Docker repository to your apt config so that you can download packages from there:
echo "deb [arch=amd64 signed-by=/usr/share/\
keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt\
/sources.list.d/docker.list > /dev/null

# Now, finally, install the Docker engine by using the following commands:
$ sudo apt update -y
$ sudo apt install -y docker-ce docker-ce-cli containerd.io

# To verify whether Docker is installed successfully, run the following:
sudo docker --version
