FROM kafka:base

RUN mkdir -p /kafka/data/zookeeper

COPY . .

RUN mv zk_supervisor.conf /etc/supervisor/conf.d/zk_supervisor.conf && \
    chmod a+x Entrypoint.sh

ENTRYPOINT ["/kafka/Entrypoint.sh"]

CMD ["/usr/bin/supervisord"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s \
  CMD nc -vz localhost 2181 || exit 1