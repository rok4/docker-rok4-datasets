FROM debian:buster
MAINTAINER Théo Satabin <theo.satabin@ign.fr>

WORKDIR /
ADD layers /layers
ADD pyramids /pyramids