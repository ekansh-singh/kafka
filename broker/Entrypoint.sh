#!/bin/bash
set -ex;

#Create server.properties file
rm /kafka/config/server.properties || echo "Good to go!"
cat /kafka/server.properties.template | sed \
    -e "s/__BROKER_ID__/${__BROKER_ID__:-1}/g" \
    -e "s@__BROKER_ADVERTISED_LISTENERS__@${__BROKER_ADVERTISED_LISTENERS__:-"PLAINTEXT://kafka1:9092"}@g" \
    -e "s/__BROKER_DELETE_TOPIC_ENABLE__/${__BROKER_DELETE_TOPIC_ENABLE__:-true}/g" \
    -e "s@__BROKER_LOG_DIRS__@${__BROKER_LOG_DIRS__:-"/kafka/data/broker"}@g" \
    -e "s/__BROKER_DEFAULT_NO_OF_PARTITION__/${__BROKER_DEFAULT_NO_OF_PARTITION__:-8}/g" \
    -e "s/__BROKER_DEFAULT_REPLICATION_FACTOR__/${__BROKER_DEFAULT_REPLICATION_FACTOR__:-3}/g" \
    -e "s/__BROKER_MIN_INSYNC_REPLICAS__/${__BROKER_MIN_INSYNC_REPLICAS__:-2}/g" \
    -e "s/__BROKER_LOG_RETENTION_HOURS__/${__BROKER_LOG_RETENTION_HOURS__:-168}/g" \
    -e "s/__BROKER_LOG_SEGMENT_BYTES__/${__BROKER_LOG_SEGMENT_BYTES__:-1073741824}/g" \
    -e "s/__BROKER_LOG_RETENTION_CHECK_INTERVAL_MS__/${__BROKER_LOG_RETENTION_CHECK_INTERVAL_MS__:-300000}/g" \
    -e "s@__BROKER_ZOOKEEPER_CONNECT_STRING__@${__BROKER_ZOOKEEPER_CONNECT_STRING__:-"zookeeper1:2181,zookeeper2:2181,zookeeper3:2181/kafka"}@g" \
    -e "s/__BROKER_ZOOKEEPER_CONNECTION_TIMEOUT_MS__/${__BROKER_ZOOKEEPER_CONNECTION_TIMEOUT_MS__:-6000}/g" \
    -e "s/__BROKER_AUTO_CREATE_TOPICS_ENABLE__/${__BROKER_AUTO_CREATE_TOPICS_ENABLE__:-true}/g" \
    > /kafka/config/server.properties

echo "Exiting entrypoint..."
exec $@