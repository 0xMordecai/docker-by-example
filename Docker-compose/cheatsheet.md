# Declarative container management with Docker Compose

`Docker Compose helps you manage multiple containers in a declarative way`. You can create a YAML file and specify what you want to build, what containers you want to run, and how the containers interact with each other. You can define mounts, networks, port mapping, and many different configurations in the YAML file.

After that, you can simply run `docker compose up` to run your entire containerized application.

`Declarative management` is quickly gaining ground because of its power and simplicity. Now, sysadmins don’t need to remember what commands they had run or write lengthy scripts or playbooks to manage containers. Instead, they can simply declare what they want in a YAML file, and docker compose or other tools can help them achieve that state. We installed Docker Compose when we installed Docker, so let’s see it in action with a sample application.

# Deploying a sample application with Docker Compose


![alt text](image.png)