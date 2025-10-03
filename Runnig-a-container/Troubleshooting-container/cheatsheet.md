# Troubleshooting containers
To see what's going on within the container, you can use the `docker logs` command.
But before using that, we need to know the container ID or container name to see the container's logs.
To get a list of containers running within the host, run the following command:
```shell
    docker ps
```
You can use either the container ID or the container name to interact with the container to list the logs. Let's use the container ID this time: