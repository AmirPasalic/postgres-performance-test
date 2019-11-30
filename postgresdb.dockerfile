FROM postgres:12
MAINTAINER Amir Pasalic
WORKDIR .
COPY ./DatabaseScripts ./DatabaseScripts/
EXPOSE 5432