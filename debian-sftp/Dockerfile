FROM debian:10

MAINTAINER Pau Barranca <paubarrancamon@gmail.com>

ENV SFTP_LOG_SYS=/var/log/auth.log
ENV SFTP_LOG_APP=/var/log/messages

# Install packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

    # Enforce SFTP to send logs to stdout
    && ln -sf /dev/stdout ${SFTP_LOG_SYS} \
    && ln -sf /dev/stdout ${SFTP_LOG_APP}

RUN mkdir -p /var/run/sshd /etc/ssh/keys

COPY /content/sshd_config /etc/ssh/sshd_config
 
# COPY /content/entrypoint.sh /root/entrypoint.sh
# RUN chmod 755 /usr/local/bin/entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/root/entrypoint.sh"]