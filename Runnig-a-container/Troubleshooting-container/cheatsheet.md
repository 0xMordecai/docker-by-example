# Troubleshooting containers
To see what's going on within the container, you can use the `docker logs` command.
But before using that, we need to know the container ID or container name to see the container's logs.
To get a list of containers running within the host, run the following command:
```shell
    docker ps
```
You can use either the container ID or the container name to interact with the container to list the logs. Let's use the container ID this time:
```shell
    docker logs [container ID]
```

Practically speaking, you would be using docker logs 90% of the time unless you need to debug something with BusyBox. BusyBox is a lightweight shell container that can help you troubleshoot and debug issues with your container – mostly network issues.

Let's now make BusyBox echo Hello World! for us:
```shell
    docker run busybox echo 'Hello World!'
```
and we got:
```shell
    Unable to find image 'busybox:latest' locally
    latest: Pulling from library/busybox
    9758c28807f2: Pull complete
    Digest:
    sha256:a9286defaba7b3a519d585ba0e37d0b2cbee74ebfe590960b0b1
    d6a5e97d1e1d
    Status: Downloaded newer image for busybox:latest
    Hello World!
```
As we see, Docker pulls the latest busybox image from Docker Hub and runs the `echo
'Hello World'` command.

# BusyBox in nteractive Mode

You can also use BusyBox in interactive mode by using the `-it flag`, which will help you run a series of commands on the BusyBox shell. It is also a good idea to add a `--rm flag` to it to tell Docker to clean up the containers once we have exited from the shell, like this:

```shell
    docker run -it --rm busybox /bin/sh
```