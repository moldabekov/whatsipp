# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
LDFLAGS=-ldflags="-s -w"
OPTIONS=-a -installsuffix cgo
BINARY_NAME=main
BINARY_LINUX=$(BINARY_NAME)_linux
DOCKER_NAME=whatsipp

# Targets
all: build
build:
	$(GOBUILD) $(LDFLAGS) -o $(BINARY_NAME) -v
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(BINARY_UNIX)
run:
	$(GOBUILD) -o $(BINARY_NAME) -v .
	./$(BINARY_NAME)

# Cross compilation
linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) $(LDFLAGS) $(OPTIONS) -o $(BINARY_NAME) -v .
docker: linux
	docker build -t $(DOCKER_NAME) .
	docker run --rm -it -p 80:8080 $(DOCKER_NAME)
