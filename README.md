## Cluster Setup

```
docker-compose up
```

to start a cluster with two brokers

```
docker-compose scale kafka=2
```

## Testing

```
$KAFKA_HOME/bin/kafka-topics.sh --create --topic topic --partitions 4 --zookeeper $ZK --replication-factor 2
$KAFKA_HOME/bin/kafka-topics.sh --describe --topic topic --zookeeper $ZK
$KAFKA_HOME/bin/kafka-console-producer.sh --topic=topic --broker-list $BRL
```

```
$KAFKA_HOME/bin/kafka-console-consumer.sh --topic=topic --bootstrap-server $BRL
```

## Resources
* [Kafka Docker](http://wurstmeister.github.io/kafka-docker/)
