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
That’s great! We have built our first image using a Dockerfile.

What if we wanted to customize the image according to our requirements? Practically speaking, no one would want an NGINX container just responding with the default Welcome to nginx! message, so let’s create an index page and use that instead:

```shell
    $ vim index.html
    Hello World! This is my first docker image!
```
This one outputs a custom message instead of the default **NGINX HTML** page.

We all know that the default **NGINX** directory containing the **index.html** file is **/var/www/html**. If we can copy the **index.html** file into this directory, it should sort out our problem.

So, modify the Dockerfile so that it includes the following:
```shell
    FROM ubuntu:25.04
    RUN apt update && apt install -y curl
    RUN apt update && apt install -y nginx
    WORKDIR /var/www/html/
    ADD index.html ./
    CMD ["nginx", "-g", "daemon off;"]
```

Here, we’ve added two directives to the file: WORKDIR and ADD. Let’s understand what each one does:

• `WORKDIR`: This defines the current working directory, which is **/var/www/html** in this case. The last **WORKDIR** in the Dockerfile also specifies the working directory when the container is executed. So, if you **exec** into a running container, you will land in the last defined **WORKDIR**. **WORKDIR** can be absolute as well as relative to the current working directory.

• `ADD`: This adds a local file to the container filesystem – the working directory, in this case. You can also use a **COPY** directive here instead of **ADD**, though **ADD** offers some more features, such as downloading files from a URL and using an archive such as a **TAR** or **ZIP** package.

When we build this file, we expect the **index.html** file to be copied to the **/var/www/html** directory within the container filesystem. Let’s have a look:

```shell
    docker build -t <your_dockerhub_user>/nginx-hello-world .
    [+] Building 1.6s (10/10) FINISHED
    => [internal] load build definition from Dockerfile 0.0s
    => => transferring dockerfile: 211B 0.0s
    => [internal] load .dockerignore 0.0s
    => => transferring context: 2B 0.0s
    => [internal] load metadata for docker.io/library/ubuntu:bionic 1.4s
    => [1/5] FROM docker.io/library/ubuntu:bionic@sha256:152dc042… 0.0s
    => [internal] load build context 0.0s
    => => transferring context: 81B 0.0s
    => CACHED [2/5] RUN apt update && apt install -y curl 0.0s
    => CACHED [3/5] RUN apt update && apt install -y nginx 0s
    => [4/5] WORKDIR /var/www/html/ 0.0s
    => [5/5] ADD index.html ./ 0.0s
    => exporting to image 0.0s
    => => exporting layers 0.0s
    => => writing image sha256:cb2e67bd… 0.0s
    => => naming to docker.io/<your_dockerhub_user>/nginx-hello-world
```

This time, **the build was much faster! When we executed the Docker build, it used a lot of layers from the cache**. That is one of the advantages of layered architecture; you only build the changing part and use the existing one the way it is.

# More directives

First, we haven’t explicitly documented **what port this container should expose**. This works perfectly fine, as we know that **NGINX runs on port 80**, **but what if someone wants to use your image and doesn’t know the port?** In that scenario, **it is best practice to define the port explicitly. We will use the EXPOSE directive for that**.

**Tip ------------------------------------------------------------------------------------------------------------------**

Always use the **EXPOSE** directive to give more clarity and meaning to your image.

**------------------------------------------------------------------------------------------------------------------------**

We also need to define the action to the container process if someone sends a `docker stop` command. While most processes take the hint and kill the process, it makes sense to explicitly specify what **STOPSIGNAL** the container should send on a `docker stop` command. We will use the **STOPSIGNAL** directive for that.

Now, while Docker monitors the container process and keeps it running unless it receives a **SIGTERM** or a **stop**, **what would happen if your container process hangs for some reason? While your application is in a hung state, Docker still thinks it is running as your process is still running**. Therefore, monitoring the application through an explicit health check would make sense. We will use the `HEALTHCHECK` directive for this.

`STOPSIGNAL` **helps your container shut down cleanly**.

`HEALTHCHECK` **helps Docker detect if your app is truly healthy, not just “running.”**

Let’s combine all these aspects and see what we get in the Dockerfile:

```Dockerfile
    FROM ubuntu:25.04
    RUN apt update && apt install -y curl
    RUN apt update && apt install -y nginx
    WORKDIR /var/www/html/
    ADD index.html ./
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]
    STOPSIGNAL SIGTERM
    HEALTHCHECK --interval=60s --timeout=10s --start-period=20s --retries=3 CMD curl -f
    localhost
```

While **EXPOSE** and **STOPSIGNAL** are self-explanatory, let’s look at the **HEALTHCHECK** directive. **The `HEALTHCHECK` directive runs a command (hence CMD) called curl -f localhost**. So,this container will report itself as healthy until the result of the curl command is a success.

The **HEALTHCHECK** directive also contains the following optional fields:

• `--interval (default: 30s)`: The interval between two subsequent health checks.

• `--timeout (default: 30s)`: The health check probe timeout. If the health check times out, it implies a health check failure.

• `--start-period (default: 0s)`: The time lag between starting the container and
the first health check. This allows you to ensure your container is up before a health check.

• `--retries (default: 3)`: The number of times the probe will retry before declaring an unhealthy status.

# Tip

**While using HEALTHCHECK is a great option, you should avoid using it to run your containers on Kubernetes or a similar container orchestrator. You should make use of liveness and readiness probes instead. Similarly, you can define health checks on Docker Compose if you are using it, so use that instead of baking the health check into the container image.**