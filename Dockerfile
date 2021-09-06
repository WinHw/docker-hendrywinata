FROM nginx:stable-alpine
LABEL org.opencontainers.image.source https://github.com/WinHw/docker-hendrywinata
COPY . /usr/share/nginx/html
