# Building our first container

Building a container image is very simple. It is actually a one-line command: `docker build -t <image-name>:version <build_context>`.

let's first build the dockerfile :
```shell
    $ docker build -t <your_dockerhub_user>/nginx-hello-world .
        [+] Building 50.0s (7/7) FINISHED
        => [internal] load .dockerignore 0.0s
        => => transferring context: 2B 0.0s
        => [internal] load build definition from Dockerfile 0.1s
        => => transferring dockerfile: 171B 0.0s
        => [internal] load metadata for docker.io/library/ubuntu:bionic 2.4s
        => [1/3] FROM docker.io/library/ubuntu:bionic@sha256:152dc042… 2.8s
        => => resolve docker.io/library/ubuntu:bionic@sha256:152dc04… 0.0s
        => => sha256:152dc042… 1.33kB / 1.33kB 0.0s
        => => sha256:dca176c9… 424B / 424B 0.0s
        => => sha256:f9a80a55… 2.30kB / 2.30kB 0.0s
        => => sha256:7c457f21… 25.69MB / 25.69MB 1.0s
        => => extracting sha256:7c457f21… 1.6s
        => [2/3] RUN apt update && apt install -y curl 22.4s
        => [3/3] RUN apt update && apt install -y nginx 21.6s
        => exporting to image 0.6s
        => => exporting layers 0.6s
        => => writing image sha256:9d34cdda… 0.0s
        => => naming to docker.io/<your_dockerhub_user>/nginx-hello-world
```
You might have noticed that the name of the container had a prefix in front of it. That is your Docker Hub account name. The name of the image has a structure of `<registry-url>/<account-name>/<container-image-name>:<version>`.

Here, we have the following:

• `registry-url`: The URL to the Docker registry – defaults to `docker.io`

• `account-name`: The user or account that owns the image

• `container-image-name`: The container image’s name

• `version`: The image version

Now, let’s create a container out of the image using the following command:

```shell
    $ docker run -d -p 80:80 <your_dockerhub_user>/nginx-hello-world
    092374c4501560e96a13444ce47cb978b961cf8701af311884bfe…
    $ docker ps
    CONTAINER ID  IMAGE            COMMAND       CREATED     STATUS   PORTS               NAMES
    092374c45015  <your_dockerhub  "nginx -g     28 seconds  Up 27   0.0.0.0:80->80/     loving_
                  _user>/nginx-    'daemon of…"  ago         seconds  tcp, :::80->80/tcp  noether
                  hello-world                                                                    
```

Here, we can see that the container is up and running.

If we run `curl localhost`, we get the default nginx html response:

```shell
    $ curl localhost
    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    ...
    </body>
    </html>
```