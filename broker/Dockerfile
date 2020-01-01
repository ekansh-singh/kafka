FROM kafka:base

RUN mkdir -p /kafka/data/broker

COPY . .

RUN mv broker_supervisor.conf /etc/supervisor/conf.d/broker_supervisor.conf && \
    chmod a+x Entrypoint.sh

ENTRYPOINT ["/kafka/Entrypoint.sh"]

CMD ["/usr/bin/supervisord"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s \
  CMD nc -vz localhost 9092 || exit 1



#*****Instruction to run this container**********
#1 -> Set file open limits to min 100000