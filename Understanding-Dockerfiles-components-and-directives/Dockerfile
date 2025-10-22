FROM kasmweb:core-ubuntu-bionic
RUN apt update && apt install -y curl
RUN apt update && apt install -y nginx
CMD [ "nginx","-g","daemon off;" ]