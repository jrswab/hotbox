FROM ubuntu:16.04
LABEL Maintainer: @jrswab

RUN apt-get update \
	&& apt-get install -y \
		bash \ 
		wget \
		jq \ 
		vim \
		tmux \
		git \
		curl \
		libreadline6 \
		nano \
		autotools-dev \
		build-essential \
		g++ \
		libbz2-dev \
		libicu-dev \
		doxygen \
		python3-dev \
		python3-pip \
		libboost-all-dev \
	&& curl -sL https://deb.nodesource.com/setup_13.x | bash - \
	&& apt-get install -y nodejs \
	&& npm install -g yarn \
	&& apt-get clean -qy \
	&& useradd --create-home --shell /bin/bash witness \
	&& useradd -M node

# P2P port
EXPOSE 2001
# RPC port
EXPOSE 8090
# Webapp Port
EXPOSE 8080

USER witness
WORKDIR /home/witness/

COPY config/install.sh /home/witness/.config/
COPY config/*.ini /home/witness/.config/
COPY wallet.sh /home/witness/
COPY smoked.sh /home/witness/
COPY config.sh /home/witness/
COPY update.sh /home/witness/

#COPY --chown=node:root config/yarn /home/witness/.config/yarn/
#COPY --chown=node:root config/yarn/global /home/witness/.config/yarn/global/
#COPY --chown=node:root config/yarn/global/node_modules /home/witness/.config/yarn/global/node_modules/

CMD ["/home/witness/.config/install.sh"]
