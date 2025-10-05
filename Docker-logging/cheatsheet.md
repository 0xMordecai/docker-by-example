# Docker logging and logging drivers
Docker not only changed how applications are deployed but also the workflow for log management. Instead of writing logs to files, containers write logs to the console (stdout/stderr). Docker then uses a logging driver to export container logs to chosen destinations.

# Container log management
Log management is an essential function within Docker, like any application. But, due to the transient nature of Docker workloads, it becomes more critical as we lose the filesystem and potentially logs as well when the container is deleted or faces any issue.

So,we should use log drivers to export the logs into a particular place and store and persist it.

# most commonly used Docker logging drivers, their purposes, and when to use each

1. json-file (Default)