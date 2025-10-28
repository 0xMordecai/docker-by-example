# Flattening Docker images

Docker inherently uses a layered filesystem, and we have already discussed why it is necessary and how it is beneficial in depth. However, in some particular use cases, Docker practitioners have observed that a Docker image with fewer layers performs better. You can reduce layers in an image by flattening it. However, it is still not a best practice, and you need to do this only if you see a performance improvement, as this would result in a filesystem overhead.

**To flatten a Docker image, follow these steps:**

**1.Run a Docker container with the usual image.**

**2.Do a `docker export` of the running container to a `.tar` file.**

**3.Do a `docker import` of the `.tar` file into another image.**

Let’s use the **go-hello-world** image to flatten it and export it to another image; that is, **`<your_dockerhub_user>/go-hello-world:flat`**.

**Before we move on, let’s get the history of the latest image:**
```shell
    $ docker history <your_dockerhub_user>/nginx-hello-world:latest
    IMAGE          CREATED      CREATED BY                SIZE            COMMENT
    bba3123dde01   2 hours ago  HEALTHCHECK &
                                {["CMD-SHELL"
                                "curl -f localhos…        0B              buildkit.dockerfile.v0
    <missing>      2 hours ago  STOPSIGNAL                0B
                                SIGTERM                   0B              buildkit.dockerfile.v0
    <missing>      2 hours ago  CMD ["nginx"
                                "-g" "daemon off;"]       0B              buildkit.dockerfile.v0
    <missing>      2 hours ago  EXPOSE map[80/
                                tcp:{}]                   0B              buildkit.dockerfile.v0
    <missing>      2 hours ago  ADD index.html ./ #
                                buildkit                  44B             buildkit.dockerfile.v0
    <missing>      2 hours ago  WORKDIR /var/www/
                                html/                     0B              buildkit.dockerfile.v0
    <missing>      2 hours ago  RUN /bin/sh -c apt
                                update && apt             57.2MB          buildkit.dockerfile.v0
                                install -y…
    <missing>      2 hours ago  RUN /bin/sh -c apt
                                update && apt             59.8MB          buildkit.dockerfile.v0
                                install -y…
    <missing>      10 days ago  /bin/sh -c #(nop)         0B
                                CMD ["/bin/bash"]
    <missing>      10 days ago  /bin/sh -c #(nop) ADD     63.2MB
                                file:3c74e7e08cbf9a876…
    <missing>      10 days ago  /bin/sh -c #(nop)  LABEL  0B
                                org.opencontainers.…
    <missing>      10 days ago  /bin/sh -c #(nop)  LABEL  0B
                                org.opencontainers.…
    <missing>      10 days ago  /bin/sh -c #(nop)  ARG    0B
                                LAUNCHPAD_BUILD_ARCH
    <missing>      10 days ago  /bin/sh -c #(nop)         0B
                                ARG RELEASE        
```

**Now, let’s run a Docker image with the latest image:**
```shell
    $ docker run -d --name nginx <your_dockerhub_user>/nginx-hello-world:latest
```

**Next, let’s take an export out of the running container:**
```shell
    $ docker export nginx > nginx-hello-world-flat.tar
```

**Import `nginx-hello-world-flat.tar` to a new image; that is, `<your_dockerhub_user>/nginx-hello-world:flat`:**

```shell
    $ cat nginx-hello-world-flat.tar | \
    docker import - <your_dockerhub_user>/nginx-hello-world:flat
```

**Now, let’s list the images and see what we get:**

```shell
    $ docker images
    REPOSITORY              TAG     IMAGE ID      CREATED     SIZE
    <your_dockerhub_user>/  flat    57bf5a9ada46  34 seconds  177MB
    nginx-hello-world                             ago
    <your_dockerhub_user>/  latest  bba3123dde01  2 hours
    nginx-hello-world                             ago         180MB
```