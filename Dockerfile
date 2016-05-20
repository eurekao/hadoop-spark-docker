FROM sequenceiq/hadoop-docker:2.7.1
MAINTAINER subjectwa@gmail.com

RUN curl -s http://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz | tar -xz -C /usr/local/ && mv /usr/local/spark-1.6.1-bin-hadoop2.6 /usr/local/spark
RUN curl -s http://downloads.lightbend.com/scala/2.10.6/scala-2.10.6.tgz | tar -xz -C /usr/lib/ && mv /usr/lib/scala-2.10.6 /usr/lib/scala

ENV SPARK_HOME /usr/local/spark
ENV SCALA_HOME /usr/lib/scala
ENV SPARK_LIBARY_PATH .:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$HADOOP_PREFIX/lib/native
ENV PATH $PATH:$SCALA_HOME/bin:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

# update boot script
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

EXPOSE 8020 9000

CMD ["/etc/bootstrap.sh", "-d"]