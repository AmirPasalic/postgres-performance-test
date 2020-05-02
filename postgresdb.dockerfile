FROM postgres:12
MAINTAINER Amir Pasalic
WORKDIR .
COPY ./DatabaseScripts ./DatabaseScripts/
COPY ./Common ./Common/
EXPOSE 5432