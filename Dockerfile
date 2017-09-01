FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get install -y openjdk-6-jre && \
  apt-get clean

RUN mkdir -p /opt/hbase
ADD hbase-0.90.6-cdh3u6.tar.gz /opt/hbase/
COPY hbase-site.xml /opt/hbase/hbase-0.90.6-cdh3u6/conf/hbase-site.xml
COPY hbase-0.90.6-cdh3u6.jar /opt/hbase/hbase-0.90.6-cdh3u6/hbase-0.90.6-cdh3u6.jar

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

CMD /opt/hbase/hbase-0.90.6-cdh3u6/bin/hbase master start
