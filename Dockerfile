# Base on the OpenJDK 11 image
FROM openjdk:8-jdk

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl

RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN	wget http://apache.mirror.anlx.net/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
    tar -zxf apache-maven-3.6.3-bin.tar.gz && \
    cp -R apache-maven-3.6.3 /usr/local && \
    ln -s /usr/local/apache-maven-3.6.3/bin/mvn /usr/bin/mvn && \
    apt-get install git;\
    \
	apt-get purge -y --auto-remove $fetchDeps

#Add the script that will do the work
ADD container/clean-volume.sh /home/wfcore/clean-volume.sh
ADD container/do-release.sh /home/wfcore/do-release.sh
ADD container/file-util.sh /home/wfcore/file-util.sh

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
