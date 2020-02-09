```bash
./kafka-shell
$KAFKA_HOME/bin/kafka-console-consumer.sh --topic=topic --bootstrap-server $BRL \
  --consumer.config /etc/kafka/config/host.consumer.ssl.config
```

```bash
./kafka-shell
$KAFKA_HOME/bin/kafka-console-producer.sh --topic=topic --broker-list $BRL \
  --producer.config /etc/kafka/config/host.producer.ssl.config
```