
FROM mariadb:10.1

ENV BUILD_DEPS wget

RUN apt-get update && apt-get install -y locales $BUILD_DEPS \
    && localedef -i sv_SE -c -f UTF-8 -A /usr/share/locale/locale.alias sv_SE.UTF-8 \
    && wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb \
    && dpkg -i dumb-init_*.deb \
    && rm dumb-init_*.deb \
    && apt-get remove -y $BUILD_DEPS \
    && rm -rf /var/lib/apt/lists/*

ENV LANG sv_SE.utf8

COPY create-user.sh /create-user.sh
RUN chmod +x /create-user.sh

ENTRYPOINT ["dumb-init", "--", "docker-entrypoint.sh"]

CMD ["mysqld"]
