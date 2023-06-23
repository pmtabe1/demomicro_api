# FROM golang
FROM golang:1.19

# Define the GITHUB_TOKEN argument and set it as an environment variable
ARG GITHUB_TOKEN
ENV GITHUB_TOKEN=$GITHUB_TOKEN

# Enable Go modules
ENV GO111MODULE=on

# Set the APP_DIR variable to the desired directory path
# ARG APP_DIR=/go/src/github.com/pmtabe1/go.microservices.api/demomicro_api/todo
# ARG APP_DIR=/go/src/app
ENV APP_DIR="/go/src/app"


# Create the APP_DIR directory
# RUN mkdir -p $APP_DIR
RUN mkdir -p ${APP_DIR}


# Set the working directory to the APP_DIR
# WORKDIR $APP_DIR
WORKDIR ${APP_DIR}

# Copy the project files to the container's APP_DIR
COPY . .

# Copy the go.mod and go.sum files to the APP_DIR
COPY go.mod go.sum $APP_DIR/

# If go.mod or go.sum files are not present in APP_DIR, copy them from the current directory
RUN if [ ! -f $APP_DIR/go.mod ] || [ ! -f $APP_DIR/go.sum ]; then \
    cp go.mod go.sum $APP_DIR/; \
    fi

# Initialize Go module if go.mod file doesn't exist
RUN if [ ! -f go.mod ]; then go mod init ${APP_MODULE}; fi

# Tidy the Go module to ensure proper dependencies
RUN go mod tidy 

# Download the Go module dependencies
RUN go mod download

# Vendor the dependencies
RUN go mod vendor

# Get test dependencies
RUN go get -t -v ./...

RUN go install github.com/swaggo/swag/cmd/swag@latest

ENV CGO_ENABLED=0
ENV GOARCH=amd64
ENV GOOS=linux

# Build the Go application with CGO disabled and for Linux
# RUN CGO_ENABLED=0 GOOS=linux go build -mod vendor -o server ${APP_DIR}/cmd/main.go
# RUN CGO_ENABLED=0 GOOS=linux go build -mod vendor -o server  ./cmd/main.go
# RUN CGO_ENABLED=0 GOOS=linux go build  -v -o server  /go/src/github.com/pmtabe1/go.microservices.api/demomicro_api/todo/cmd/main.go

# COPY ./cmd/main.go /go/src/github.com/pmtabe1/go.microservices.api/demomicro_api/todo/cmd/main.go

# Check if main.go file exists
RUN if [ -f "cmd/main.go" ]; then \
    go build -o app -v ./cmd/main.go && \
    mv app /usr/local/bin/; \
    else \
    echo "Error: main.go file not found. Build failed."; \
    exit 1; \
    fi

# RUN  go build -o server -v  /go/src/github.com/pmtabe1/go.microservices.api/demomicro_api/todo/cmd/main.go

# Set the entrypoint command to run the built executable
CMD ["app" ]
