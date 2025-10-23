FROM golang:1.23
WORKDIR /tmp
COPY app.go .
ENV CGO_ENABLED=0
RUN GOOS=linux go build -a -installsuffix cgo -o app . && chmod +x ./app
CMD ["./app"]