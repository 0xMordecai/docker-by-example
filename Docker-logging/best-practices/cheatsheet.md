# Typical challenges and best practices with Docker logging
Most teams struggle to try to fit the `Docker logging` to behave the way `virtual machine logging` works. So, most teams will `send logs to the host filesystem`, and `the log analytics solution then consumes the data from there`. That is not ideal, and you should not make that mistake.

It might work if your container is `static`, but it becomes an issue if you have a `cluster of servers`