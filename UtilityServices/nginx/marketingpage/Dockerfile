FROM index.docker.io/nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY content /usr/share/nginx/html
COPY conf /etc/nginx
VOLUME /usr/share/nginx/html
VOLUME /etc/nginx