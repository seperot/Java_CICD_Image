FROM centos:latest
LABEL maintainer="ijhdev <me@ijh.dev>"

RUN yum -y install git \
yum install -y java-1.8.0 java-1.8.0-openjdk-devel.x86_64 \
yum remove -y java-1.7.0-openjdk \
yum -y install openssh-clients \
yum -y install mysql \
wget https://services.gradle.org/distributions/gradle-4.4-bin.zip

RUN mkdir /opt/gradle \
unzip -d /opt/gradle/ gradle-4.4-bin.zip \
rm -rf gradle-4.4-bin.zip \
export PATH=$PATH:/opt/gradle/gradle-4.4/bin

RUN wget http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz \
cd /opt\
tar -xvzf ~/apache-maven-3.6.3-bin.tar.gz \
export M2_HOME="/opt/apache-maven-3.6.3" \
export PATH=$PATH:/opt/apache-maven-3.6.3/bin

RUN update-alternatives --install "/usr/bin/mvn" "mvn" "/opt/apache-maven-3.6.3/bin/mvn" 0
RUN update-alternatives --set mvn /opt/apache-maven-3.6.3/bin/mvn

RUN wget https://raw.github.com/dimaj/maven-bash-completion/master/bash_completion.bash --output-document /etc/bash_completion.d/mvn \ 
mvn --version

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN rm -f /etc/ssl/certs/java/cacerts; \
    /var/lib/dpkg/info/ca-certificates-java.postinst configure

