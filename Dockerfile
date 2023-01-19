# Build the Go Binary.
FROM golang:1.19 as builder
ENV CGO_ENABLED 0
ARG BUILD_VERSION
ARG BUILD_DATE

RUN mkdir /binver
COPY go.* /binver/
WORKDIR /binver
RUN go mod download

# Copy the source code into the container.
COPY . /binver

# Build the binver binary.
RUN go build -ldflags "-s -X main.buildTime=${BUILD_DATE} -X main.version=${BUILD_VERSION}" -o binver ./main.go

# Run the Go Binary in Alpine.
FROM alpine:3.17.1
ARG BUILD_VERSION
ARG BUILD_DATE
COPY --from=builder /binver /usr/local/bin
ENTRYPOINT [ "binver" ]
CMD ["-h"]

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
  org.opencontainers.image.title="binver-demo" \
  org.opencontainers.image.authors="Gustavo Castillo <gcdcoder@gmail.com>" \
  org.opencontainers.image.source="https://github.com/gustavocd/binver" \
  org.opencontainers.image.revision="${BUILD_VERSION}" \
  org.opencontainers.image.vendor="Gustavo Castillo"
