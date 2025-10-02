Open a command prompt/terminal or use built-in terminal in Code using the **Terminal/New Terminal** menu or the **Ctrl-Shift-T** .

Type the following Docker commands:

## Displays system information

    docker info

## Displays the system’s version

    docker version

## Log in to Docker Hub

    docker login

## Log in to Docker Hub

    docker login

# Docker CLI Cheat Sheet – Running and Stopping

| Command                              | Description                        |
|--------------------------------------|------------------------------------|
| `docker pull [imageName]`            | Pull an image from a registry      |
| `docker run [imageName]`             | Run containers                     |
| `docker run -d [imageName]`          | Run containers in detached mode    |
| `docker start [containerName]`       | Start stopped containers           |
| `docker ps`                          | List running containers            |
| `docker ps -a`                       | List running and stopped containers|
| `docker stop [containerName]`        | Stop containers                    |
| `docker kill [containerName]`        | Kill containers                    |
| `docker image inspect [imageName]`   | Get image info                     |

# Docker CLI Cheat Sheet - Limits

`docker run --memory="256m" nginx`    | Setting Max memory

`docker run --cpus=".5" nginx`        | Setting Max 

# List the existing storage driver