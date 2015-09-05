FROM golang:1.4-cross 

RUN \
  git clone \
    --branch develop \
    https://github.com/concourse/concourse \
    /root/concourse

WORKDIR /root/concourse

RUN git submodule update --init --recursive

ENV GOPATH /root/concourse

RUN go build -o /usr/sbin/atc github.com/concourse/atc/cmd/atc && \
    cp -a src/github.com/concourse/atc/web/templates /tmp/templates && \
    cp -a src/github.com/concourse/atc/web/public /tmp/public

RUN mkdir -p /usr/bin/linux/amd64
RUN GOOS=linux GOARCH=amd64 \
    go build -a -tags netgo -installsuffix netgo \
    -o /usr/bin/linux/amd64/fly \
    github.com/concourse/fly

RUN mkdir -p /usr/bin/darwin/amd64
RUN GOOS=darwin GOARCH=amd64 \
    go build -a -tags netgo -installsuffix netgo \
    -o /usr/bin/darwin/amd64/fly \
    github.com/concourse/fly

RUN mkdir -p /usr/bin/windows/amd64
RUN GOOS=windows GOARCH=amd64 \
    go build -a -tags netgo -installsuffix netgo \
    -o /usr/bin/windows/amd64/fly \
    github.com/concourse/fly

RUN rm -rf /root/concourse

WORKDIR /

EXPOSE 8080

ADD scripts/atc /sbin/atc
RUN chmod +x /sbin/atc
CMD /sbin/atc
