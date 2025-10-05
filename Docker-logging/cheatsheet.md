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