#!/bin/ash

# Generate host keys if not found
if ls /ssh/ssh_host_* 1> /dev/null 2>&1; then
	echo "Found host keys! :)"
else
    ssh-keygen -A
    mv /etc/ssh/ssh_host_* /ssh/
fi

# Fix permissions
if [ -w /ssh ]; then
    chown root:root /ssh && chmod 700 /ssh/
fi
if [ -w /ssh/authorized_keys ]; then
    chown root:root /ssh/authorized_keys
    chmod 600 /ssh/authorized_keys
fi

# unlock root account
sed -i s/root:!/"root:*"/g /etc/shadow

# run sshd
/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config