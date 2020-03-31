FROM gitpod/workspace-full


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
   stable" && sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io 
 
   
#installing docker-compose
RUN echo "***installing docker-compose***" && \
	sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" \
	-o /usr/local/bin/docker-compose \
	&& sudo chmod +x /usr/local/bin/docker-compose
	
#installing vscode
RUN	cd /bin && \
	sudo wget https://github.com/cdr/code-server/releases/download/2.1698/code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz && \
	sudo tar -xvzf code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz && \
	sudo rm -r code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz && \
	sudo mv code-server2.1698-vsc1.41.1-linux-x86_64/ vscode/ && \
	cd /home/gitpod
 
