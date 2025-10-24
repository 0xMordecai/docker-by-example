# Single-stage builds

Let’s containerize a simple Go application that prints Hello, World! on the screen. While I am using Golang in this application, this concept is applicable universally, irrespective of the programming language.

Let’s look at the Go application file, app.go, first:

```go
    package main
    import "fmt"
    func main() {
        fmt.Println("Hello, World!")
    }
```

The Dockerfile appears as follows:

```Dockerfile
    FROM golang:1.22.2
    WORKDIR /app

    # Copy files
    COPY go.mod .
    COPY app.go .

    # Download dependencies
    RUN go mod tidy

    # Build the Go app
    ENV CGO_ENABLED=0
    RUN go build -o app .

    # Run it
    CMD ["./app"]

```

This is standard stuff. We take the golang:1.22.2 base image, declare a WORKDIR /tmp, copy app.go from the host filesystem to the container, and build the Go application to generate a binary. Finally, we use the CMD directive with the generated binary to be executed when we run the container.

Let’s build the Dockerfile:

```shell
    docker build -t <your_dockerhub_user>/go-hello-world:single_stage .
```

Now, let’s run the Docker image and see what we get:
```Shell
    docker run <your_dockerhub_user>/go-hello-world:single_stage
    Hello, World!
```
We get the expected response back. Now, let’s run the following command to list the image:
```shell
    docker images
    REPOSITORY              TAG           IMAGE ID      CREATED        SIZE
    <your_dockerhub_user>
    /go-hello-world         single_stage  3fd3d26111a1  3 minutes ago  803MB
```

This image is huge! It takes 803 MB to print Hello, World! on the screen. This is not the most efficient way of building Docker images.