FROM rocker/verse

RUN apt update && apt install -y gnupg openssh-client libpoppler-cpp-dev

# DVC
RUN wget \
       https://dvc.org/deb/dvc.list \
       -O /etc/apt/sources.list.d/dvc.list && \
    wget -qO - https://dvc.org/deb/iterative.asc | apt-key add - && \
    apt update && \
    apt install -y dvc 

# R Packages
RUN R -e "install.packages(c('languageserver', 'renv'))"

# Rstudio Global Options
COPY --chown=rstudio:rstudio .config/rstudio/rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json