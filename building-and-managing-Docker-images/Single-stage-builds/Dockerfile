FROM golang:1.23
WORKDIR /app
COPY app.go .
ENV CGO_ENABLED=0
RUN GOOS=linux go build -o app . && chmod +x ./app
CMD ["./app"]
