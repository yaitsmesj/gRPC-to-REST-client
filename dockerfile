# builder stage
FROM golang as builder

ENV GO111MODULE=on

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o grpc-to-rest-client

# final stage
FROM scratch

COPY --from=builder /app/grpc-to-rest-client /app

CMD [ "/app" ]