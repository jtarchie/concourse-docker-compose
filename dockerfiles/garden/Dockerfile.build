FROM golang:1.4.2

RUN apt-get update && apt-get -y install btrfs-tools iptables ulogd zip

ADD garden-linux-release/src/ /tmp/garden/src

ENV GOPATH /tmp/garden
ENV PATH /tmp/garden/bin:$PATH

RUN go install -tags daemon github.com/cloudfoundry-incubator/garden-linux
RUN cd $GOPATH/src/github.com/cloudfoundry-incubator/garden-linux && make

EXPOSE 7777

ADD scripts/ /tmp/garden/scripts
CMD /tmp/garden/scripts/garden-linux-worker
