FROM jenkins/jenkins:lts

USER root
RUN apt-get update && \
  apt-get -y install apt-transport-https \
       ca-certificates \
       curl \
       gnupg2 \
       software-properties-common && \
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
  add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) \
     stable" && \
  apt-get update && \
  apt-get -y install docker-ce

RUN usermod -a -G docker jenkins
ADD ./entrypoint.sh /usr/local/bin/jenkins-with-docker.sh
RUN chmod +x /usr/local/bin/jenkins-with-docker.sh

# allow jenkins to execute docker command with root privileges
RUN echo 'jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker' >> /etc/sudoers

ENTRYPOINT /usr/local/bin/jenkins-with-docker.sh
