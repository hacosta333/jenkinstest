FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install python python-pip -y


RUN mkdir -p /opt/apps
COPY src/* /opt/apps/

COPY requirements.txt /opt/apps/
RUN pip install -r /opt/apps/requirements.txt

COPY docker-entrypoint.sh /
ENTRYPOINT "/docker-entrypoint.sh"
