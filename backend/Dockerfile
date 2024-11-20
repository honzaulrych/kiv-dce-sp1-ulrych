FROM ubuntu:20.04

LABEL maintainer="ulrych@students.zcu.cz" \
      org.opencontainers.image.source="https://github.com/honzaulrych/hello-microservice.git"

ENV DEBIAN_FRONTEND noninteractive

RUN apt -y update
RUN apt -y install python3
RUN apt -y install python3-pip
RUN pip3 install Flask
RUN apt-get -y install curl

RUN mkdir /service
COPY hello-service.py /service/hello-service.py

EXPOSE 5123

CMD ["python3", "/service/hello-service.py"]