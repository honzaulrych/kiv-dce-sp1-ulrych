#
# Simple backend demo server image
#

FROM ubuntu:20.04

RUN sudo apt-get update; \
    sudo apt-get install -y python3; \
    sudo apt-get install -y python3-pip;
RUN sudo pip3 install flask

COPY python /opt/backend

CMD /usr/bin/python3 /opt/backend/simple-backend.py

# EOF
