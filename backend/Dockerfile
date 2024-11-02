#
# Simple backend demo server image
#

FROM ubuntu:20.04

RUN apt update
RUN apt install python3
RUN pip3 install flask

COPY python /opt/backend

CMD /usr/bin/python3 /opt/backend/simple-backend.py

# EOF
