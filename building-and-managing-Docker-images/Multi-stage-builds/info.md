# Multi-stage builds

Let’s modify the Dockerfile according to the **multi-stage** build process and see what we get.

The following is the `Dockerfile`:

```Dockerfile
    FROM golang:1.20.5 AS build
    WORKDIR /tmp
    COPY app.go .
    RUN GO111MODULE=off GOOS=linux go build -a -installsuffix cgo -o app . && chmod +x ./app
    FROM alpine:3.18.0
    WORKDIR /tmp
    COPY --from=build /tmp/app .
    CMD ["./app"
```