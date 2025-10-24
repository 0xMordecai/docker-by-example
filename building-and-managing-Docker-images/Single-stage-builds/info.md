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