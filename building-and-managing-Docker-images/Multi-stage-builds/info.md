#   Multi-stage builds

Let’s modify the Dockerfile according to the **multi-stage** build process and see what we get.

The following is the `Dockerfile`:

```Dockerfile
FROM golang:1.22.2 AS build
WORKDIR /app
COPY go.mod .
COPY app.go .
RUN go mod tidy
RUN GO111MODULE=off GOOS=linux go build -a -installsuffix cgo -o app . && chmod +x ./app


FROM alpine:3.18.0
WORKDIR /app
COPY --from=build /app .
CMD ["./app"]
```

The `Dockerfile` contains two **FROM** directives: `FROM golang:1.22.2 AS build` and `FROM alpine:3.18.0`. The first **FROM** directive also includes an **AS** directive that declares the stage and names it build. Anything we do after this **FROM** directive can be accessed using the build term until we encounter another **FROM** directive, which would form the second stage. Since the second stage is the one we want to run our image from, we are not using an **AS** directive.

#   first stage

**In the first stage, we build our Golang code to generate the binary using the golang base image.**

#   second stage

**In the second stage, we use the Alpine base image and copy the `/app` file from the build stage into our current stage. This is the only file we need to run in the container. The rest were only required to build and bloat our container during runtime.**

Let’s build the image and see what we get:

```shell
    docker build -t <your_dockerhub_user>/go-hello-world:multi_stage
```

Now, let’s run the container:

```shell
    docker run <your_dockerhub_user>/go-hello-world:multi_stage .
    Hello, World!
```

We get the same output, but this time with a minimal footprint. Let’s look at the image to confirm this:

```shell
docker images
REPOSITORY              TAG          IMAGE ID      CREATED        SIZE
<your_dockerhub_user>
/go-hello-world         multi_stage  e4b793b39a8e  5 minutes ago  9.17MB
```

This one **occupies just 9.17 MB instead of the huge 803 MB**. This is a massive improvement! We have

**reduced the image size by almost 100 times. That is how we increase efficiency within our container image. Building efficient images is the key to running production-ready containers, and most professional images you find on Docker Hub use multi-stage builds to create efficient images.**

# **Tip**

**Use multi-stage builds where possible to include minimal content within your image. Consider using an Alpine base image if possible.**