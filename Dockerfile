FROM rocker/shiny-verse:latest

# System deps
RUN apt-get update && apt-get install -y \
    pandoc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
  && rm -rf /var/lib/apt/lists/*

# Work inside Shiny server directory
WORKDIR /srv/shiny-server

# Copy your whole repo into the image
COPY . /srv/shiny-server/

# Install R packages etc.
RUN R -e "source('prep.R')"

# Fix permissions (you are already root; no sudo needed)
RUN chown -R shiny:shiny /srv/shiny-server

EXPOSE 3838

CMD ["/usr/bin/shiny-server"]
