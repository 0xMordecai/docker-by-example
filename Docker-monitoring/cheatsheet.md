We've looked at the logging aspects of containers, but one of the essential elements of a DevOps engineer's role is monitoring.

# Docker monitoring with Prometheus

Monitoring Docker nodes and containers are an essential part of managing Docker. There are various tools available for monitoring Docker. While you can use traditional tools such as `Nagios`, `Prometheus` is gaining ground in cloud-native monitoring because of its simplicity and pluggable architecture.

`Prometheus` is a free, open source monitoring tool that provides a `dimensional data model`, efficient and straightforward querying using the `Prometheus query language(PromQL)`, efficient time-series databases, and modern alerting capabilities.

# Challenges with container monitoring

From a conceptual point of view, there is no difference between container monitoring and the traditional method. You would still need `metrics`, `logs`, `health checks`, and `service discovery`.The problem with containers is the abstraction that they bring with them; let's look at some of the problems:

• Containers behave like a `mini virtual machine`, but they are a `process running on aserver` in reality. However, they still have everything to monitor that we would do in a virtual machine. A container process will have many metrics very similar to virtual machines to be treated as separate entities altogether. `Most people make this mistake when dealing with containers when they map containers to a particular virtual machine`.

• `Containers running on clusters can move from one node(server) to another`. That adds another layer of complexity as your monitoring tool needs to know where your containers are to scrape metrics from it. Well, it should not matter with the more modern, container-optimized tools.

`Prometheus` helps us address these challenges as it is built from a distributed application's point of view.

# Resources:
Look at Prometheus Docs : `https://prometheus.io/docs/prometheus/3.5/getting_started/` 
# Metrics to monitor
Monitoring metrics is a complex subject, and it would `depend mostly on your use case`. However, the following are some guidelines on what kind of metrics you might want to monitor.

# Host metrics
You need to monitor your host metrics as your containers would run on them. Some of the metrics that you can watch are the following:

• `Host CPU`: It's good to know whether your host has sufficient CPU to run your containers. If not, it might terminate some of your containers to account for that. So, to ensure reliability, you need to keep this in check.

• `Host memory`: Like the host CPU, you need to watch the host memory to detect issues such as memory leaks and runaway memory.

• `Host disk space`: As Docker containers use the host filesystem to store the transient and persistent file, you need to monitor it.

# Docker container metrics

Docker container metrics are the next thing and you should look at the following:

• `Container CPU`: This metric will provide the amount of CPU used by the Docker container. You should monitor it to understand the usability pattern and decide where to place your container effectively.

• `Throttled CPU time`: This metric allows us to understand the total time when the CPU was throttled for a container. That enables us to know whether a particular container needs more CPU time than others, and you can adjust the CPU share constraint accordingly.

• `Container memory fail counters`: This metric will provide the number of times the container requested more than the allocated memory. It will help you understand what containers required more than the allocated memory, and you can plan to run the container accordingly.

• `Container memory usage`: This metric will provide the amount of memory used by the Docker container, and you can set memory limits according to the usage.

• `Container swap`: This metric will tell what containers were using the swap instead of the RAM. It will help us identify memory-hungry containers.

• `Container disk I/O`: This is an important metric and will help us understand containers' disk profiles. Spikes can indicate a disk bottleneck, or you might want to revisit your storage driver configuration.

• `Container network metrics`: This metric will tell us how much network bandwidth the containers are using and help us understand traffic patterns. You can use these to detect an unexpected network spike or a denial of service attack.