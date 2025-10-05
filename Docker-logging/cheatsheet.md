# Docker logging and logging drivers
Docker not only changed how applications are deployed but also the workflow for log management. Instead of writing logs to files, containers write logs to the console (stdout/stderr). Docker then uses a logging driver to export container logs to chosen destinations.

# Container log management
Log management is an essential function within Docker, like any application. But, due to the transient nature of Docker workloads, it becomes more critical as we lose the filesystem and potentially logs as well when the container is deleted or faces any issue.

So,we should use log drivers to export the logs into a particular place and store and persist it.

# Logging drivers
the following logging drivers are available:

• `none`: There are no logs available for the container, and therefore they are not stored anywhere.

• `json-file`: The log files are stored in a JSON format, and this is the default Docker logging driver.