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
In the first stage, we build our Golang code to generate the binary using the golang base image.

#   second stage
In the second stage, we use the Alpine base image and copy the /tmp/app file from the build stage into our current stage. This is the only file we need to run in the container. The rest were only required to build and bloat our container during runtime.