FROM golang:1.23-alpine
WORKDIR /app
COPY app.go .
RUN go build -o app . && chmod +x ./app
CMD ["./app"]
