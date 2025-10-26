FROM golang:1.22.2 AS build
WORKDIR /app

# Copy files
COPY go.mod .
COPY app.go .

# Download dependencies
RUN go mod tidy

# Build the Go app
RUN GO111MODULE=off GOOS=linux go build -a -installsuffix cgo -o app . && chmod +x ./app


FROM alpine:3.18.0
WORKDIR /app
COPY --from=build /app .
CMD ["./app"]