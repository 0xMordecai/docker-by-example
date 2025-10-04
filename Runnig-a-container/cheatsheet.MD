# Running your first container
To run a Docker container, we will use the docker run command, which has the following structure:
```shell
    docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]
```

In its simplest form, you can use docker run by simply typing the following:
```shell
    docker run hello-world
```

# Running containers from versioned images
We can run nginx:1.18.0 using the following command:
```shell
    docker run nginx:1.18.0
```

# Running Docker containers in the background
To run a Docker container in the background as a daemon, you can use docker run in
detached mode using the `-d flag`:
```shell
    docker run -d nginx:1.18.0
```

# Putting it all together
```shell
docker run -d --name nginx --restart unless-stopped \
-p 80:80 --memory 1000M --memory-reservation 250M nginx:1.28.0
```
The following applies:

• -d: Run as a daemon in detached mode.

• --name nginx: Give the name nginx.

• --restart unless-stopped: Always automatically restart on failures unless explicitly stopped manually, and also start automatically on Docker daemon startup.Other options include no, on_failure, and always.