FROM geertvb/java

RUN \
  groupadd sonatype && \
  useradd -d /home/nexus -m -s /bin/bash nexus -g sonatype

ADD http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz /home/nexus/nexus-latest-bundle.tar.gz

RUN chown nexus:sonatype /home/nexus/nexus-latest-bundle.tar.gz

USER nexus

WORKDIR /home/nexus

RUN \
  tar -xzvf /home/nexus/nexus-latest-bundle.tar.gz -C /home/nexus && \
  rm -rf /home/nexus/nexus-latest-bundle.tar.gz && \
  ln -s /home/nexus/nexus-* /home/nexus/nexus
  
RUN mkdir -p /home/nexus/sonatype-work
  
VOLUME /home/nexus/sonatype-work

EXPOSE 8081
  
CMD /home/nexus/nexus/bin/nexus console
