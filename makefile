# Get version from git hash
git_hash := $(shell git rev-parse --short HEAD || echo 'development')

# Get current date
current_time = $(shell date +"%Y-%m-%d:T%H:%M:%S")

# Add linker flags
linker_flags = '-s -X main.buildTime=${current_time} -X main.version=${git_hash}'

# Build binaries for current OS and Linux
.PHONY:
build:
	@echo "Building binaries..."
	@go build -ldflags=${linker_flags} -o=./bin/binver ./main.go
	@GOOS=linux GOARCH=amd64 go build -ldflags=${linker_flags} -o=./bin/linux_amd64/binver ./main.go
	@echo "Done!"

# Build docker image
.PHONY:
docker:
	@echo "Building docker image..."
	@docker build \
		-t binver:$(git_hash) \
		--build-arg BUILD_VERSION=$(git_hash) \
		--build-arg BUILD_DATE=$(current_time) \
		.
	@echo "Done!"
