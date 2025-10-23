FROM golang:1.22.2
WORKDIR /app
COPY go.mod .
COPY app.go .
RUN go mod tidy
ENV CGO_ENABLED=0
RUN go build -o app .
# Run it
CMD ["./app"]
