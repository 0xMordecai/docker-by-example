FROM golang:1.22.2
WORKDIR /tmp

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
