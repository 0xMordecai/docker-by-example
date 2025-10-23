FROM golang:1.22.2
WORKDIR /app
COPY app.go .
RUN go build -o app . && chmod +x ./app
CMD ["./app"]
