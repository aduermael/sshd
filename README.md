# sshd
A small container running sshd.

### How to run

```shell
docker run -ti -d --rm -p 22:22 \
--name sshd \
-v /ssh:/ssh \
aduermael/sshd
```
(use `-v` to mount other volumes)