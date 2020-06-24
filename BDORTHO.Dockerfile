FROM tianon/true
MAINTAINER Théo Satabin <theo.satabin@ign.fr>

WORKDIR /

ADD pyramids/BDORTHO /pyramids/BDORTHO

VOLUME /pyramids/BDORTHO