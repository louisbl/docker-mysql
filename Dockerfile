FROM phusion/baseimage:0.9.11
MAINTAINER louisbl <louis@beltramo.me>

# Set correct environment variables.
ENV HOME /root

# Install packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server

RUN /usr/sbin/enable_insecure_key

ADD build/my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 664 /etc/mysql/conf.d/my.cnf

RUN mkdir /etc/service/mysql
ADD build/mysql.sh /etc/service/mysql/run

VOLUME ["/var/lib/mysql"]
EXPOSE 3306

CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
