FROM centos:centos7.4.1708

RUN yum install -y java-1.8.0-openjdk && \
    yum install -y openssh-server && \
    yum install -y initscripts && \
    yum install -y zip && \
    yum install -y unzip && \
    yum clean all
RUN sed -i -e 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    sed -i -e 's/#Port 22/Port 22/g' /etc/ssh/sshd_config && \
    sed -i -e 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config
RUN echo "root:root" | chpasswd
RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key

CMD [ "/usr/sbin/sshd", "-D"]

EXPOSE 22
