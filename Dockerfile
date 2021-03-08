FROM ubi7/ubi:7.7
ENV NEXUS_VERSION "2.14.3-02"
ENV NEXUS_HOME "/opt/nexus"
COPY ./training.repo /etc/yum.repos.d/
RUN yum install -y --setopt=tsflags=nodocs java-1.8.0-openjdk-devel && yum clean all -y
RUN groupadd -r nexus -f -g 1001
RUN useradd -u 1001 -r -g nexus -m -d ${NEXUS_HOME} -s /sbin/nologin/ -c "Nexus User" nexus
ADD ./nexus-2.14.3-02-bundle.tar.gz ${NEXUS_HOME}
COPY ./nexus-start.sh ${NEXUS_HOME}
RUN ln -s ${NEXUS_HOME}/nexus-${NEXUS-VERSION} ${NEXUS_HOME}/nexus2
RUN chown -r nexus:nexus ${NEXUS_HOME}
RUN mkdir ${NEXUS_HOME}/sonatype-work && chown nexus:nexus ${NEXUS_HOME/sonatype-work}
USER nexus
WORKDIR ${NEXUS_HONE}
ENTRYPOINT ["${NEXUS_HOME}/nexus-start.sh"]

