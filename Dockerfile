FROM alpine:3.11.6

RUN apk update && \
	apk add openssh && \
	rm -rf /var/cache/apk/*

# Dir to store host keys and authorized keys
RUN mkdir /ssh && \
touch /ssh/authorized_keys

# Update sshd_config
RUN sed -ri 's/#Port 22/Port 22/g' /etc/ssh/sshd_config && \
sed -ri 's/.ssh\/authorized_keys/\/ssh\/authorized_keys/g' /etc/ssh/sshd_config && \
sed -ri 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config && \
sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config && \
sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
