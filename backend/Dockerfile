FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt -y update
RUN apt -y install python3
RUN apt -y install python3-pip
RUN pip3 install Flask
RUN apt-get -y install curl

RUN mkdir /service
COPY python/simple-backend.py /service/simple-backend.py

EXPOSE 5000

CMD ["python3", "/service/simple-backend.py"]