# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
LDFLAGS=-ldflags="-s -w"
OPTIONS=-a -installsuffix cgo
BINARY_NAME=whatsipp
BINARY_LINUX=$(BINARY_NAME)_linux
BINARY_WINDOWS=$(BINARY_NAME).exe
DOCKER_NAME=unstab1e/whatsipp

# Targets
all: build
build:
	$(GOBUILD) $(LDFLAGS) -o $(BINARY_NAME) -v
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(BINARY_LINUX)
	rm -f $(BINARY_WINDOWS)
run:
	$(GOBUILD) -o $(BINARY_NAME) -v .
	./$(BINARY_NAME)

# Cross compilation
linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) $(LDFLAGS) $(OPTIONS) -o $(BINARY_NAME) -v .
windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(GOBUILD) $(LDFLAGS) $(OPTIONS) -o $(BINARY_WINDOWS) -v .
docker: linux
	upx -9 $(BINARY_NAME)
	docker build -t $(DOCKER_NAME) .
	docker run --rm -it -p 80:8080 $(DOCKER_NAME)
