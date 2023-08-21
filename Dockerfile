# Use a lightweight base image with Python 3
FROM python:3.9-slim-buster

# Update the system and install required dependencies
RUN apt-get update -y && \
    apt-get install -y \
    build-essential \
    wget \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    libcurl4-gnutls-dev \
    libssl-dev \
    unzip \
    tabix \
    git

# Install bcftools
RUN wget https://github.com/samtools/bcftools/releases/download/1.13/bcftools-1.13.tar.bz2 && \
    tar -xjf bcftools-1.13.tar.bz2 && \
    cd bcftools-1.13 && \
    make && \
    make install && \
    cd .. && \
    rm -rf bcftools-1.13 bcftools-1.13.tar.bz2

# Install VCFtools
RUN git clone https://github.com/vcftools/vcftools.git && \
    cd vcftools && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf vcftools

# Install Python packages
RUN pip install --no-cache-dir \
    polars \
    numpy \
    geopy \
    scipy

# Clean up to reduce the image size
RUN apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
