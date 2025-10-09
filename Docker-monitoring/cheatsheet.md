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
Monitoring metrics is a complex subject, and it would depend mostly on your use case. However, the following are some guidelines on what kind of metrics you might want to monitor.