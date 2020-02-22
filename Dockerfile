FROM jgoerzen/debian-base-security:buster
MAINTAINER Peter Bartkowski. <pbartko@verizon.net>
COPY setup/ /tmp/setup/
ENV WEEWX_VERSION 3.9.1
# The font file is used for the generated images
RUN echo testprint
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y --no-install-recommends install ssh rsync fonts-freefont-ttf python-dev python-pip && \
    /tmp/setup/setup.sh && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled && \
    mkdir -p /var/www/html/weewx && \
RUN echo testprint
RUN pip install pyephem
	
COPY weewx.conf /etc/weewx/weewx.conf
VOLUME ["/var/lib/weewx", "/var/www/html/weewx"]
CMD ["/usr/local/bin/boot-debian-base"]
