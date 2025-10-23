FROM golang:1.23
WORKDIR /tmp
COPY go.mod .
COPY app.go .
RUN go mod tidy
RUN GOOS=linux go build -a -installsuffix cgo -o app . && chmod +x ./app
CMD ["./app"]