FROM tianon/true
MAINTAINER Théo Satabin <theo.satabin@ign.fr>

WORKDIR /

ADD pyramids/LIMADM /pyramids/LIMADM

VOLUME /pyramids/LIMADM