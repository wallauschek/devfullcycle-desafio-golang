FROM golang:alpine AS builder

WORKDIR $GOPATH/src/mypackage/myapp/
COPY . .

RUN go get -d -v
# RUN go build -o /go/bin/hello
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/hello

FROM scratch
COPY --from=builder /go/bin/hello /go/bin/hello
ENTRYPOINT ["/go/bin/hello"]