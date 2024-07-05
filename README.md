1. `./sql-client.sh`

In the client:

```
CREATE TABLE KafkaTable2 (
  `Message` STRING,
  `Time` BIGINT
) WITH (
  'connector' = 'kafka',
  'topic' = 'Example4',
  'properties.bootstrap.servers' = 'kafka:9092',
  'value.format' = 'avro-confluent',
  'value.avro-confluent.url' = 'http://apicurio:8080/apis/ccompat/v6',
  'scan.startup.mode' = 'earliest-offset'
);

SELECT * FROM KafkaTable2;
```

Then to check we can write to an avro table:

```
CREATE TABLE KafkaSink (
  `Message` STRING
) WITH (
  'connector' = 'kafka',
  'topic' = 'Example5',
  'properties.bootstrap.servers' = 'kafka:9092',
  'value.format' = 'avro-confluent',
  'value.avro-confluent.url' = 'http://apicurio:8080/apis/ccompat/v6',
  'scan.startup.mode' = 'earliest-offset'
);

INSERT INTO KafkaSink SELECT `Message` from KafkaTable2;
```

Then `curl http://localhost:8080/apis/ccompat/v6/subjects/` to see that there has been an Example5-value schema registered.

And:

```
SELECT * FROM KafkaSink;
```

to see that it's got some contents
