FROM gitpod/workspace-full

#installing vscode
ARG BUILD_DATE
ARG VERSION
ARG CODE_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"
ENV HOME="/config"

RUN \
 apt-get update && \
 apt-get install -y \
	git \
	jq \
	nano \
	net-tools \
	sudo && \
 echo "**** install code-server ****" && \
 if [ -z ${CODE_RELEASE+x} ]; then \
	CODE_RELEASE=$(curl -sX GET "https://api.github.com/repos/cdr/code-server/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 CODE_URL=$(curl -sX GET "https://api.github.com/repos/cdr/code-server/releases/tags/${CODE_RELEASE}" \
	| jq -r '.assets[] | select(.browser_download_url | contains("linux-x86_64")) | .browser_download_url') && \
 curl -o \
	/tmp/code.tar.gz -L \
	"${CODE_URL}" && \
 tar xzf /tmp/code.tar.gz -C \
	/usr/bin/ --strip-components=1 \
	--wildcards code-server*/code-server && \
 echo "**** clean up ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# ports and volumes
EXPOSE 8443
 
 #installing docker in docker
 
RUN echo "***installing docker***" && \
sudo apt-get update  && sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
    sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" && sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io \
   && service docker start
   
#installing docker-compose
RUN echo "***installing docker-compose***" && \
	sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" \
	-o /usr/local/bin/docker-compose \
	&& sudo chmod +x /usr/local/bin/docker-compose
	
