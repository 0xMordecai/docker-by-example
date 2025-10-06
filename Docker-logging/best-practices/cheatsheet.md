# Typical challenges and best practices with Docker logging
Most teams struggle to try to fit the `Docker logging` to behave the way `virtual machine logging` works. So, most teams will `send logs to the host filesystem`, and `the log analytics solution then consumes the data from there`. That is not ideal, and you should not make that mistake.

It might work if your container is `static`, but it becomes an issue if you have a `cluster of servers`

So, `treating a container as an application running on a virtual machine` is a mistake from a logging point of view. Instead, `you should visualize the container as an entity – just like a virtual machine`. It would be best if you `never associated containers with a virtual machine`.

One solution can be to use the logging driver to forward the logs to a log analytics solution directly. But then the logging becomes heavily dependent on the availability of the log analytics solution. So, it might not be the best thing to do. People have faced issues when their services running on Docker went down because the log analytics solution was not available or there were some network issues.

Well, the best way to approach this problem is to use JSON files to store the logs
temporarily in your virtual machine and use another container to push the logs to
your chosen log analytics solution using the old-fashioned way. That way, you decouple
dependency on an external service to run your application.

You can use the logging driver that exports log directly to your log analytics solution within the log forwarder container. There are many logging drivers available that support many log targets. Always mark the logs in such a way that the containers appear as an entity on their own. That will disassociate containers with virtual machines, and you can then make the best use of a distributed container-based architecture.