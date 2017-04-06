FROM debian:testing
MAINTAINER Diego Diez <diego10ruiz@gmail.com>

# Update the repository sources list.
RUN apt-get update

## Add general tools.
RUN apt-get install -y build-essential

## Install MEME suite.
# Download and untar.
ADD http://mafft.cbrc.jp/alignment/software/mafft-7.310-with-extensions-src.tgz /tmp
RUN cd /tmp && tar zxvf mafft-7.310-with-extensions-src.tgz

# Compile.
WORKDIR /tmp/mafft-7.310-with-extensions/core
RUN make clean
RUN make
RUN make install

# Cleanup.
#WORKDIR /tmp
#RUN rm -rf mafft-7.310-with-extensions

# Add /opt/bin to PATH.
ENV PATH /opt/bin:$PATH

# Set user.
RUN useradd -ms /bin/bash biodev
RUN echo 'biodev:biodev' | chpasswd
USER biodev
WORKDIR /home/biodev
