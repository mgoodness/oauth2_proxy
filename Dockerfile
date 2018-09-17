FROM golang:1.11 AS builder
WORKDIR /go/src/github.com/bitly/oauth2_proxy

RUN go get github.com/golang/dep/cmd/dep
COPY . .
RUN dep ensure -v -vendor-only

RUN CGO_ENABLED=0 GOOS=linux go install -ldflags="-w -s" -v .

FROM gcr.io/distroless/base
COPY --from=builder /go/bin/oauth2_proxy /

CMD ["/oauth2_proxy"]
