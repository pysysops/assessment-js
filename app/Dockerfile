FROM centos:7

RUN yum update -y && yum install -y golang \
    && yum clean all && rm -f /etc/yum.repos.d/*
ADD . /app
WORKDIR /app
RUN go build -o http
EXPOSE 8484

ENTRYPOINT /app/http
