FROM rocker/shiny-verse:latest

# Work inside Shiny server directory
WORKDIR /srv/shiny-server

# Install full C++ toolchain for rstan
RUN apt-get update && apt-get install -y \
    g++ \
    build-essential \
    make \
    && rm -rf /var/lib/apt/lists/*

# rstan needs extra configuration
RUN mkdir -p ~/.R/ && \
    echo "CXX14FLAGS=-O3 -march=native -mtune=native" >> ~/.R/Makevars && \
    echo "CXX14=g++" >> ~/.R/Makevars

# Install rstan and StanHeaders first
RUN R -e "install.packages(c('StanHeaders', 'rstan'), dependencies=TRUE, repos='https://cloud.r-project.org')"

# Now copy your app
COPY . /srv/shiny-server/

# Install the rest of your packages
RUN R -e "source('prep.R')"

# Fix permissions
RUN chown -R shiny:shiny /srv/shiny-server

EXPOSE 3838

CMD ["/usr/bin/shiny-server", "/etc/shiny-server/shiny-server.conf"]

