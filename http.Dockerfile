FROM golang:latest AS builder

WORKDIR /build 

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o httpserver cmd/http_server/main.go 

FROM gcr.io/distroless/base

WORKDIR /app

COPY --from=builder /build/httpserver ./httpserver

EXPOSE 8000

CMD ["./httpserver"]



