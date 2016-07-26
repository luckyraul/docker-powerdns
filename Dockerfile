FROM mygento/puppet

MAINTAINER nikita@mygento.ru

EXPOSE 53

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD [ "/entrypoint.sh"]