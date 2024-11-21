#
# Setup image with NGINX as frontend (proxy) server
#

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y epel-release
RUN apt-get install -y nginx
RUN rm -rf /usr/share/nginx/html

# COPY html /usr/share/nginx/html
# COPY config/backend-upstream.conf /etc/nginx/conf.d/backend-upstream.conf
# COPY config/backend-proxy.conf /etc/nginx/default.d/backend-proxy.conf
COPY config/backend-proxy.conf /etc/nginx/default.d/backend-proxy.conf

ENTRYPOINT [ "/usr/sbin/nginx && tail -F /var/log/nginx/access.log /var/log/nginx/error.log" ]
