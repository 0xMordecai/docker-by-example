# Managing Docker images

In modern DevOps practices, Docker images are primarily built either on a developer machine or a CI/CD pipeline. The images are stored in a container registry and then deployed to multiple staging environments and production machines. They might run Docker or a container orchestrator, such as Kubernetes, on top of them.

To efficiently use images, we must understand how to tag them.

Primarily, Docker pulls the image once when you do a Docker run. This means that once an image with a particular version is on the machine, Docker will not attempt to pull it on every run unless you explicitly pull it.

To pull the image explicitly, you can use the docker pull command:

```shell
    docker pull nginx
```

Now, if we attempt to launch a container using this image, it will instantly launch the container without pulling the image: