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