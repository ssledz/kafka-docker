#!/bin/bash
set -x
brokers=$(docker ps --filter name=kafka_kafka --format "{{.Names}}" | sed s'/$/:9092/g' | tr '\n' ',' | sed 's/,$//')
docker run --rm --network kafka_default -v /var/run/docker.sock:/var/run/docker.sock -e BRL=$brokers -e ZK=kafka_zookeeper_1:2181 -it wurstmeister/kafka /bin/bash
