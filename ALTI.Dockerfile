FROM tianon/true
MAINTAINER Théo Satabin <theo.satabin@ign.fr>

WORKDIR /

ADD pyramids/ALTI /pyramids/ALTI

VOLUME /pyramids/ALTI