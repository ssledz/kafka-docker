#!/bin/bash
label="io.github.ssledz.service=kafka-ssl"
brokers=$(docker ps --filter "label=$label" --format "{{.Names}}" | sed s'/$/:9093/g' | tr '\n' ',' | sed 's/,$//')
network=$(docker ps --filter "label=$label" --format "{{.Networks}}")
docker run --rm --network $network \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ssl_kafka-ssl-config:/etc/kafka/config \
  -v ssl_kafka-ssl-secrets:/etc/kafka/secrets \
  -e BRL=$brokers \
  -e ZK=ssl_zookeeper_1:2181 \
  -it \
  wurstmeister/kafka:2.12-2.4.0 \
  /bin/bash
