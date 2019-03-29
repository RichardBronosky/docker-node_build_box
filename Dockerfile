FROM debian:stretch

# This container is designed for running `npm install` in preparation for running in node:11, node:latest, node:stretch-slim, etc.
# Therefore, you ought to be able to use either of the following FROMs and remove the "Install NodeJS" step below
#FROM node:11-stretch-slim
#FROM node:11

# This is the right way to allow bashisms in your provisioning steps
SHELL ["/bin/bash", "-c"]

# Install build tools
RUN apt-get update && \
    apt-get install -y build-essential rsyslog curl git vim tmux

# Install NodeJS v11 latest
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
    apt-get install -y nodejs

# Configuration
RUN { \
	echo '--- /etc/rsyslog.conf 19:21:14.604753000 +0000' && \
	echo '+++ /etc/rsyslog.conf 19:22:07.409934000 +0000' && \
	echo '@@ -9,12 +9,12 @@' && \
	echo ' #################' && \
	echo '' && \
	echo ' module(load="imuxsock") # provides support for local system logging' && \
	echo '-module(load="imklog")   # provides kernel logging support' && \
	echo '-#module(load="immark")  # provides --MARK-- message capability' && \
	echo '+#module(load="imklog")   # provides kernel logging support' && \
	echo '+module(load="immark")  # provides --MARK-- message capability' && \
	echo '' && \
	echo ' # provides UDP syslog reception' && \
	echo '-#module(load="imudp")' && \
	echo '-#input(type="imudp" port="514")' && \
	echo '+module(load="imudp")' && \
	echo '+input(type="imudp" port="514")' && \
	echo '' && \
	echo ' # provides TCP syslog reception' && \
	echo ' #module(load="imtcp")'; \
	} | patch -p0 -d / && \
    echo "[[ -f /var/log/syslog ]] || rsyslogd" >> ~/.bashrc && echo "alias ll='ls -la --color=auto'" >> ~/.bashrc
