# specify parent image
FROM ubuntu:jammy

#__________________________________

## environment variables  
ENV USER=ubuntu
ENV PASS=password
ENV TIMEZONE=Europe/Zurich

#__________________________________

# set apt to noninteractive
ARG DEBIAN_FRONTEND=noninteractive

# Update the image to the latest packages
RUN apt-get update && apt-get upgrade -y

# install packages
RUN apt-get install -y \ 
                nano \
                wget \
                gnupg \
                tzdata \
                sudo \
                apt-transport-https \
                software-properties-common

# install and set locales
RUN apt-get install -y locales \ 
    && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# set timezone
RUN apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

# create user and set password
RUN useradd ${USER}
RUN echo "${USER}:pass" | chpasswd

# set users default bash
RUN usermod -s /bin/bash ${USER}

# add to sudo group
RUN usermod -aG sudo $USER

# create userhome
RUN mkdir /home/${USER}
RUN chmod -R 700 /home/${USER}
RUN chown -R ${USER}:${USER} /home/${USER}

# configure group sudo to use sudo without password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists /tmp/* /var/tmp/*