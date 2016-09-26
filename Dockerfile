FROM owlab/golang-arm64:1.7.1

MAINTAINER Hun Jae Lee <hunjae.lee@gmail.com>
ENV SWARM_VERSION v1.2.5

RUN apt-get update && apt-get install -y git \
	&& go get github.com/tools/godep \
	&& go get github.com/golang/lint/golint \
	&& mkdir -p $GOPATH/src/github.com/docker \
	&& cd $GOPATH/src/github.com/docker \
	&& git clone https://github.com/docker/swarm.git \
	&& cd swarm \
	&& git checkout $SWARM_VERSION \
	&& go install . \
	&& rm -rf .git \
	&& apt-get remove -y git \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

ENV SMARM_HOST :2375

EXPOSE 2375

VOLUME $HOME/.swarm

ENTRYPOINT ["swarm"]
CMD ["--help"]
