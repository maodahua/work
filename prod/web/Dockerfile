FROM nginx:latest

RUN apt-get update && apt-get install -y \
	unzip \
	&& rm -rf /var/lib/apt/lists/*

COPY web.zip /tmp/
COPY default.conf /etc/nginx/conf.d/default.conf
RUN unzip -od /usr/share/nginx/html/  /tmp/web.zip \
	&& rm -rf /tmp/web.zip

