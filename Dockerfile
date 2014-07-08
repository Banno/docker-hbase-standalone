## -*- docker-image-name: "banno/hbase-standalone" -*-
FROM ubuntu:12.04
MAINTAINER Nic Grayson nic.grayson@banno.com

# install add-apt-repository
RUN \
  apt-get update && \
  apt-get install -y python-software-properties curl

# install java
RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer

# install hbase master
RUN mkdir /opt/hbase
RUN wget -q https://github.com/Banno/docker-hbase-standalone/raw/master/hbase-0.94.15-cdh4.7.0.tar.gz -O /opt/hbase/hbase-0.94.15-cdh4.7.0.tar.gz
RUN tar xfvz /opt/hbase/hbase-0.94.15-cdh4.7.0.tar.gz
ADD hbase-site.xml /etc/hbase/conf/hbase-site.xml

# need this for hbase to run
ENV JAVA_HOME /usr

# zookeeper
EXPOSE 2181
# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

CMD /opt/hbase/hbase-0.94.15-cdh4.7.0/bin/hbase master start
