FROM rocker/rstudio

RUN apt update && apt install -y \
    openssh-client libxt-dev\
    # Python
    python3 python3-pip

# R Package
RUN R -e "install.packages(c('renv'))"

# Julia
ENV JULIA_MINOR_VERSION=1.10
ENV JULIA_PATCH_VERSION=2

RUN wget https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_MINOR_VERSION}/julia-${JULIA_MINOR_VERSION}.${JULIA_PATCH_VERSION}-linux-x86_64.tar.gz && \
    tar xvf julia-${JULIA_MINOR_VERSION}.${JULIA_PATCH_VERSION}-linux-x86_64.tar.gz && \
    rm julia-${JULIA_MINOR_VERSION}.${JULIA_PATCH_VERSION}-linux-x86_64.tar.gz && \
    ln -s $(pwd)/julia-$JULIA_MINOR_VERSION.$JULIA_PATCH_VERSION/bin/julia /usr/bin/julia

# DVC Path
ENV PATH $PATH:~/.cache/pip/bin

# Package Cahce & Permission
RUN cd /home/rstudio && mkdir .cache .TinyTeX && \
    chown rstudio:rstudio .cache .TinyTeX
