#!/bin/bash
set -ex;

#Create Zookeeper ID
ZOOKEEPER_ID=${__ZK_ID__:-1}
ZOOKEEPER_DATA_DIRECTORY=${__ZK_DATA_DIR__:-"/kafka/data/zookeeper"}
ZOOKEEPER_ID_FILE_PATH="${ZOOKEEPER_DATA_DIRECTORY}/myid"
if [ -e "$ZOOKEEPER_ID_FILE_PATH" ] && [ -f "$ZOOKEEPER_ID_FILE_PATH" ];then
    echo "myid already exist"
    cat $ZOOKEEPER_ID_FILE_PATH
else
    echo "myid not found. Setting it up..."
    echo "$ZOOKEEPER_ID" > $ZOOKEEPER_ID_FILE_PATH
fi

#Create zookeeper.properties file from template
rm /kafka/config/zookeeper.properties || echo "Good to go"
cat /kafka/zookeeper.properties.template | sed \
    -e "s@__ZK_DATA_DIR__@"${ZOOKEEPER_DATA_DIRECTORY}"@g"  \
    -e "s/__ZK_CLIENT_PORT__/${__ZK_CLIENT_PORT__:-2181}/g" \
    -e "s/__ZK_MAX_CLIENT_CNXNS__/${__ZK_MAX_CLIENT_CNXNS__:-0}/g" \
    -e "s/__ZK_TICK_TIME__/${__ZK_TICK_TIME__:-2000}/g" \
    -e "s/__ZK_INIT_LIMIT__/${__ZK_INIT_LIMIT__:-10}/g" \
    -e "s/__ZK_SYNC_LIMIT__/${__ZK_SYNC_LIMIT__:-5}/g" \
    > /kafka/config/zookeeper.properties

#Add Zookeeper server nodes
SERVER_INDEX=1
for i in ${ZK_NODES[@]}
do
    SERVER_STRING="server.${SERVER_INDEX}=${i}"
    echo "$SERVER_STRING" >> /kafka/config/zookeeper.properties
    SERVER_INDEX=$((SERVER_INDEX + 1))
done
echo "Exiting entrypoint..."
exec $@