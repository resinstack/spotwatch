FROM golang:1.16-alpine as build
WORKDIR /spotwatch-src
COPY . .
RUN go mod vendor && \
        CGO_ENABLED=no go build -tags netgo -ldflags '-s -w' -o /spotwatch .

FROM scratch
LABEL org.opencontainers.image.source https://github.com/resinstack/spotwatch
COPY --from=build /spotwatch /spotwatch
ENTRYPOINT ["/spotwatch"]
