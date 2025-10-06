# Docker logging and logging drivers
Docker not only changed how applications are deployed but also the workflow for log management. Instead of writing logs to files, containers write logs to the console (stdout/stderr). Docker then uses a logging driver to export container logs to chosen destinations.

# Container log management
Log management is an essential function within Docker, like any application. But, due to the transient nature of Docker workloads, it becomes more critical as we lose the filesystem and potentially logs as well when the container is deleted or faces any issue.

So,we should use log drivers to export the logs into a particular place and store and persist it.

# Logging drivers
the following logging drivers are available:

• `none`: There are no logs available for the container, and therefore they are not stored anywhere.

• `local`: Logs are `stored locally` in a custom format and therefore minimizes overhead.

• `json-file`: The `log files` are stored in a `JSON` format, and this is the default Docker logging driver.

• `journald`: Uses `journald` to store Docker logs. You can use the journald command line to browse the container logs and the Docker daemon logs.

• `splunk`: Sends logs to `Splunk` using the HTTP Event Collector.

• `syslog`: Uses syslog for storing the Docker logs as well. This option makes sense when you use syslog as your default logging mechanism.

• `awslogs`: Sends logs to AWS CloudWatch.

• `gcplogs`: Sends logs to Google Cloud Logging.

And there is many more.

# Configuring logging drivers
Let's start by finding the current logging driver:

```shell
    docker info | grep "Logging Driver"
    Logging Driver: json-file
```

so currently, the default logging driver is set to `json-file`. If we want to use `journald` or `Splunk` as the default logging driver, we must configure the default logging driver in the `daemon.json` file.

Edit the `/etc/docker/daemon.json` file using an editor of your choice. If you use `vim`, run the following command:

```shell
    vim /etc/docker/daemon.json
```

Add the `log-driver` entry to the daemon.json configuration file:
```json
    {
        "log-driver": "journald"
    }
```
Then, restart the Docker service:
```shell
    sudo systemctl restart docker
```

Check the status of the Docker service:
```shell
    sudo systemctl status docker
```

Now, rerun docker info to see what we get:
```shell
    docker info | grep "Logging Driver"
    Logging Driver: journald
```

Right, as journald is now the default logging driver, let's launch a new NGINX container and visualize the logs:
```shell
    docker run --name nginx-journald -d nginx
```

Let's now look at the journald logs to see what we get:
```shell
    sudo journalctl CONTAINER_NAME=nginx-journald
        Oct 05 23:43:48 pc-name 80acf6e492af[12703]: /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform c>
        Oct 05 23:43:48 pc-name 80acf6e492af[12703]: /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
```

And we see the logs in the journal.

# using flags to determine different logging drivers for different container
You can also have different logging drivers for different containers, and you can do so by overriding the defaults by passing the `log-driver` and `log-opts` flags from the command line.

As our current configuration is `journald`, and we want to export data to a `JSON` file, we can specify `log-driver` as `json-file` while running the container. Let's have a look:

```shell
    docker run --name nginx-json-file --log-driver json-file \ 
    -d nginx
```

Right, so to visualize JSON logs, we need to look into the JSON log directory, that is, `/var/lib/docker/containers/<container_id>/<container_id>-json.log`.
```shell
    cat /var/lib/docker/containers/379eb8d0162d98614d53ae1\
    c81ea1ad154745f9edbd2f64cffc2279772198bb2379eb8d0162d9\
    8614d53ae1c81ea1ad154745f9edbd2f64cffc2279772198bb2-json.log
```