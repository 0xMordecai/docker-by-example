FROM golang:1.22.2
WORKDIR /tmp

# Copy files
COPY go.mod .
COPY app.go .

# Download dependencies
RUN go mod tidy

# Build the Go app
RUN GO111MODULE=off GOOS=linux go build -a -installsuffix cgo -o app . && chmod +x ./app

