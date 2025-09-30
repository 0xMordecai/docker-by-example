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
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io

# To verify whether Docker is installed successfully, run the following:
sudo docker --version

# You should expect a similar output to the following:
# ---->	Docker version 28.4.0, build d8eb465

# So, now that Docker is fully set up on your machine, let's run a hello-world container to see for ourselves:

sudo docker run hello-world

#	 You should see the following output:
#	Unable to find image 'hello-world:latest' locally
#	latest: Pulling from library/hello-world
#	17eec7bbc9d7: Pull complete 
#	Digest: sha256:54e66cc1dd1fcb1c3c58bd8017914dbed8701e2d8c74d9262e26bd9cc1642d31
#	Status: Downloaded newer image for hello-world:latest

#	Hello from Docker!
#	This message shows that your installation appears to be working correctly.

