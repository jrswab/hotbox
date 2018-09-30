FROM ubuntu:16.04
LABEL Maintainer: @jrswab

RUN apt-get update \
	&& apt-get install -y \
		bash \ 
		wget \
		jq \ 
		git \ 
		vim \
		tmux \
		libreadline6 \
		nano \
	#&& apt-get install -y gcc-4.9 g++-4.9 cmake make \
	#	libbz2-dev libdb++-dev libdb-dev \
	#&& apt-get install -y libssl-dev openssl libreadline-dev \
	#	autoconf libtool git gdb liblz4-tool jq virtualenv \
	#	libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev \
	&& apt-get install -y autotools-dev build-essential g++ \
		libbz2-dev libicu-dev doxygen python3-dev \
		python3-pip libboost-all-dev curl \
	&& apt-get clean -qy \
	&& useradd --create-home --shell /bin/bash witness

# P2P port
EXPOSE 2001
# RPC port
EXPOSE 8090

USER witness
WORKDIR /home/witness/

#COPY tools/ /home/witness/tools/
COPY config/ /home/witness/config/
COPY install.sh /home/witness/
#COPY run.sh /home/witness/
#COPY wallet.sh /home/witness/
ENTRYPOINT ["tmux", "new", "-s", "HotBox"]
