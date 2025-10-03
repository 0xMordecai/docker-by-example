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