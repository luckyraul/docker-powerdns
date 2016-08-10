FROM mygento/puppet

MAINTAINER nikita@mygento.ru

EXPOSE 53
VOLUME ["/var/lib/powerdns"]

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD [ "/entrypoint.sh"]
