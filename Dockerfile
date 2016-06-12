# for binder
FROM andrewosh/binder-base

USER root

ENV PACKAGES python-dev zlib1g git python-setuptools g++ make ca-certificates
ENV KHMER_VERSION master
ENV SOURMASH_VERSION master

# khmer scripts will be installed in /usr/local/bin
# khmer sandbox will be in /home/khmer/sandbox/

### don't modify things below here for version updates etc.

WORKDIR /home

RUN apt-get update && \
    apt-get install -y --no-install-recommends ${PACKAGES} && \
    apt-get clean

RUN cd /home && \
    git config --global http.sslVerify false && \
    git clone https://github.com/dib-lab/khmer.git -b ${KHMER_VERSION} && \
    cd khmer && \
    python setup.py install

RUN cd /home && \
    git clone https://github.com/dib-lab/sourmash.git -b ${KHMER_VERSION} && \
    cd sourmash && \
    python setup.py install

USER main
