FROM centos:centos7
MAINTAINER sudhakar@au1.ibm.com

# Pass in the location of the RLKS install zip
ARG ARTIFACT_DOWNLOAD_URL
#Install supervisord
RUN \
  yum update -y && \
  yum install -y epel-release && \
  yum install -y iproute python-setuptools hostname inotify-tools yum-utils which jq unzip wget redhat-lsb-core.i686 && \
  yum clean all && \
  easy_install supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD RLKSinstall.rsp /tmp/RLKSinstall.rsp
ADD startup.sh /opt/startup.sh
#Install RLKS
RUN cd /tmp && wget -q $ARTIFACT_DOWNLOAD_URL && unzip -q IBM_Rational_License_Key_Server_Linux_x86_ZIP.zip \
    && /tmp/RLKSSERVER_SETUP_LINUX_X86/disk1/InstallerImage_linux_gtk_x86_64/installc -acceptLicense input /tmp/RLKSinstall.rsp -log /tmp/rlks.log \
    && rm -rf /tmp/* \
    && chmod +x /opt/startup.sh

EXPOSE 27000
#this assumes the license file will have a port setting like:
#VENDOR ibmratl port=27001
EXPOSE 27001

ENTRYPOINT ["/opt/startup.sh"]
CMD []
