FROM jiemakel/octavo

USER root

RUN apk add supervisor curl

RUN apk add netdata --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

COPY supervisord.conf /etc/

RUN ["find", "/var/log", "/run", "/var/cache", "/var/lib/netdata", "/opt/docker", "-type", "d", "-exec", "chmod", "a+rwx", "{}", ";"]

EXPOSE 19999

USER daemon

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]

