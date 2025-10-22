FROM ubuntu:25.04
RUN apt update && apt install -y curl
RUN apt update && apt install -y nginx
WORKDIR /var/www/html/
ADD index.html ./
CMD [ "nginx","-g","daemon off;" ]