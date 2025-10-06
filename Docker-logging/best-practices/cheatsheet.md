# Typical challenges and best practices with Docker logging
Most teams struggle to try to fit the `Docker logging` to behave the way `virtual machine logging` works. So, most teams will `send logs to the host filesystem`, and `the log analytics solution then consumes the data from there`. That is not ideal, and you should not make that mistake.

It might work if your container is `static`, but it becomes an issue if you have a `cluster of servers`

So, treating a container as an application running on a virtual machine is a mistake from a logging point of view. Instead, you should visualize the container as an entity – just like a virtual machine. It would be best if you never associated containers with a virtual machine.