#!/bin/bash
kafka_label="io.github.ssledz.service=kafka"
zookeeper_label="io.github.ssledz.service=zookeeper"
kafka_name=$(docker ps --filter "label=$kafka_label" --format "{{.Names}}")
zookeeper_name=$(docker ps --filter "label=$zookeeper_label" --format "{{.Names}}")
kafka_port=$(docker port $(echo "$kafka_name" | head -1) | sed  -r 's/(.*)\/.*/\1/g')
zookeper_port=$(docker port "$zookeeper_name" | sed  -r 's/(.*)\/.*/\1/g')
brokers=$(echo "$kafka_name" | sed s'/$/:'"$kafka_port"'/g' | tr '\n' ',' | sed 's/,$//')
zookeeper="zookeeper:$zookeper_port"
network=$(docker ps --filter "label=$kafka_label" --format "{{.Networks}}" | head -1)
echo "brokers: $brokers"
echo "zookeeper: $zookeeper"
echo "network: $network"

docker run --rm --network "$network" --link "$zookeeper_name:zookeeper" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e BRL="$brokers" \
  -e ZK="$zookeeper" \
  -it \
  wurstmeister/kafka:2.12-2.4.0 \
  /bin/bash
