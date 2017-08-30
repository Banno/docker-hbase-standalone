FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get install -y openjdk-6-jre && \
  apt-get clean

RUN mkdir -p /opt/hbase
COPY hbase-0.90.0.tar.gz /opt/hbase/hbase-0.90.0.tar.gz
WORKDIR /opt/hbase
RUN tar xfvz hbase-0.90.0.tar.gz
COPY hbase-site.xml /etc/hbase/conf/hbase-site.xml

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

CMD /opt/hbase/hbase-0.90.0/bin/hbase master start
