FROM nginx:1.25.2-bookworm

RUN apt update \
        && apt install -y \
            procps

COPY ./.docker/pro/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./src /app
