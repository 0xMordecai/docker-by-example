# Managing Docker images

In modern DevOps practices, Docker images are primarily built either on a developer machine or a CI/CD pipeline. The images are stored in a container registry and then deployed to multiple staging environments and production machines. They might run Docker or a container orchestrator, such as Kubernetes, on top of them.

To efficiently use images, we must understand how to tag them.

Primarily, Docker pulls the image once when you do a Docker run. This means that once an image with a particular version is on the machine, Docker will not attempt to pull it on every run unless you explicitly pull it.

To pull the image explicitly, you can use the docker pull command:

```shell
    docker pull nginx
```

Now, if we attempt to launch a container using this image, it will instantly launch the container without pulling the image:

```shell
    docker run nginx
```

So, using the latest tag on an image is a bad idea, and the best practice is to use semantic versions as your tag. There are two primary reasons for this:

• If you build the latest image every time, orchestrators such as Docker Compose and Kubernetes will assume the image is already on your machine and will not pull your image by default. Using an image pull policy such as Always on Kubernetes or a script to pull the image is a waste of network bandwidth. It is also important to note that Docker Hub limits the number of pulls you can make on open source images, so you must limit your pulls to only when necessary.

• Docker tags allow you to roll out or roll back your container deployment quickly. If you always use the latest tag, the new build overrides the old one, so there is no way you can roll back a faulty container to the last known good version. Using versioned images in production is also a good idea to ensure your container’s stability. If, for some reason, you lose the local image and decide to rerun your container, you may not get the same version of the software you were already running, as the latest tag changes frequently. So, it’s best to use a particular container version in production for stability.

Images comprise multiple layers, and most of the time, there is a relationship between various versions of containers that run on your server. With time, new versions of images roll out in your production environment, so removing the old images by doing some housekeeping is best. This will reclaim some valuable space the container images occupy, resulting in a cleaner filesystem.

To remove a particular image, you can use the docker rmi command:

```shell
    $ docker rmi nginx
    Error response from daemon: conflict: unable to remove repository reference "nginx" (mustforce) - container d5c84356116f is using its referenced image f9c14fe76d50
```
Oh! We get an error, but why? It’s because we have a container running and using this image.

# TIP
**You cannot remove images currently used by a running container.**

First, you will have to stop and remove the container. Then, you can remove the image using the preceding command. If you want to do everything at once, you can force removal by using the -f flag, which will stop the container, remove it, and then remove the image. So, unless you know what you are doing, do not use the -f flag:

```shell
    docker rmi -f nginx
```

We built our container many times, but what should we do if we need to push it to Docker Hub or other registries? But before we do that, we will have to authenticate it with Docker Hub using the following command:

```shell
    docker login
```

Now, you can push the image to Docker Hub using the following command:
```shell
    docker push <your_dockerhub_user>/go-hello-world:multi_stage
    The push refers to repository [docker.io/<your_dockerhub_user>/go-hello-world]
d10e0340acf3: Pushed 
0c517899a3b6: Pushed 
bb01bd7e32b5: Mounted from library/alpine 
```
