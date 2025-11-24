# (current Dockerfile in BSTApp repo, simplified)
FROM rocker/shiny-verse:latest

RUN apt-get update && apt-get install -y \
  sudo \
  pandoc \
  pandoc-citeproc \
  libcurl4-gnutls-dev \
  libcairo2-dev \
  libxt-dev \
  libssl-dev \
  libssh2-1-dev

# copy everything into Shiny Server directory
COPY /. /srv/shiny-server/

# install all R packages etc.
RUN R -e "source('/srv/shiny-server/prep.R')"

EXPOSE 3838
RUN sudo chown -R shiny:shiny /srv/shiny-server
CMD ["/usr/bin/shiny-server"]