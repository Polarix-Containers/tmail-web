ARG VERSION=0.23.1

FROM ghcr.io/linagora/tmail-web:v${VERSION} AS extract

FROM ghcr.io/polarix-containers/nginx:unprivileged-mainline-slim
ARG VERSION

COPY --from=extract /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=extract /usr/share/nginx/html /usr/share/nginx/html

USER root

RUN sed -i 's/listen 80;/listen 8080;/g' /etc/nginx/nginx.conf

USER nginx