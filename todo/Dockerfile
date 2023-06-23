FROM golang

ARG GITHUB_TOKEN
ENV GITHUB_TOKEN=$GITHUB_TOKEN
ENV GO111MODULE=on
ARG APP_DIR=/go/src/github.com/pmtabe1/go.microservices.api/demomicro_api/todo
RUN mkdir -p  $APP_DIR
ADD . $APP_DIR
WORKDIR $APP_DIR
COPY . ${APP_DIR}
COPY go.mod go.sum  ${APP_DIR}
RUN if [ ! -f $APP_DIR/go.mod ] || [ ! -f $APP_DIR/go.sum ]; then \
    cp go.mod go.sum $APP_DIR/; \
    fi
# Download the Go module dependencies
RUN if [ ! -f go.mod ]; then go mod init ${APP_MODULE}; fi
RUN go mod tidy 
RUN go mod download
RUN go get  -t -v ./...
RUN go get  github.com/canthefason/go-watcher
# RUN go get  github.com/canthefason/go-watcher
RUN go install github.com/canthefason/go-watcher/cmd/watcher

# RUN curl https://glide.sh/get | sh
# RUN go get  github.com/canthefason/go-watcher
# RUN go install github.com/canthefason/go-watcher/cmd/watcher
# RUN cd /go/src/github.com/kujtimiihoxha/demomicro_api && glide install

ENTRYPOINT  watcher -run github.com/pmtabe1/demomicro_api/todo/cmd -watch github.com/pmtabe1/demomicro_api/todo
