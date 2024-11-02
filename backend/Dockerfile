#
# Simple backend demo server image
#

FROM ubuntu:20.04

RUN apt-get update; \
    apt-get install -y python3; \
    apt-get install -y python3-pip;
RUN pip3 install flask

COPY python /opt/backend

ENTRYPOINT [ "/usr/bin/python3", "/opt/backend/simple-backend.py" ]

# EOF
