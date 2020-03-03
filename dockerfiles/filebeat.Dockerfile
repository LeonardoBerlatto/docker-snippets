FROM docker.elastic.co/beats/filebeat:7.5.0

USER root
# Create a directory to map volume with all docker log files
RUN mkdir /usr/share/filebeat/dockerlogs
RUN chown -R root /usr/share/
RUN chmod -R go-w /usr/share/