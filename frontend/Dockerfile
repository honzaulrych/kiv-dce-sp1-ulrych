# #
# # Setup image with NGINX as frontend (proxy) server
# #

# FROM ubuntu:20.04

# ENV DEBIAN_FRONTEND noninteractive

# # RUN apt-get install -y epel-release; \
# #     apt-get install -y nginx; \
# #     rm -rf /usr/share/nginx/html;

# RUN apt-get -y update && apt-get -y install nginx

# # COPY html /usr/share/nginx/html
# # COPY config/backend-upstream.conf /etc/nginx/conf.d/backend-upstream.conf
# # COPY config/backend-proxy.conf /etc/nginx/default.d/backend-proxy.conf
# COPY config/backend-proxy.conf /etc/nginx/default.d/backend-proxy.conf

# CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

FROM nginx
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf