# mirror-maker

A mirror-maker container based on [bitnami/kafka](https://hub.docker.com/r/bitnami/kafka/) and
 [srotya/docker-kafka-mirror-maker](https://github.com/srotya/docker-kafka-mirror-maker).  

### Build
This image is available from Docker hub however, if you would like to build it yourself here are the steps:

```
git clone https://github.com/srotya/docker-kafka-mirror-maker.git
cd docker-kafka-mirror-maker
docker build -t mirror-maker:latest .
```

**Note: Docker is expected to be installed where you run the build**

### Environment Variables
|    Variable Name    |                   Description                |   Defaults |
|---------------------|----------------------------------------------|------------|
|    DESTINATION      | bootstrap.servers for the Destination Kafka Cluster |localhost:6667|
|      SOURCE         | bootstrap.servers for the Source Kafka Cluster |localhost:6667|
|     WHITELIST       | Topics to mirror     | * |
|     GROUPID         | Consumer group id for Kafka consumer | _mirror_maker |

#### Docker usage
```
docker run -it -e DESTINATION=xxx.xxx.com:9092 -e SOURCE=xxx.xxx.com:9092 -e WHITELIST=<TOPIC NAME> mirror-maker:latest
```

#### Docker-compose usage

```
version: '2'

services:
  zookeeper:
    image: 'bitnami/zookeeper:3'
    ports:
      - '2181:2181'
    volumes:
      - 'zookeeper_data:/bitnami'
    environment:
      - ALLOW_ANONYMOUS_LOGIN=yes
  kafka:
    image: 'bitnami/kafka:2'
    ports:
      - '9092:9092'
    volumes:
      - 'kafka_data:/bitnami'
    environment:
      - KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181
      - ALLOW_PLAINTEXT_LISTENER=yes
      - KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
    depends_on:
      - zookeeper
  mirrormaker:
    image: 'wpietri/mirror-maker:2'
    depends_on:
      - kafka
    environment:
      - SOURCE=mysourcekafka.example.com:9092
      - DESTINATION=kafka:9092
      - WHITELIST=Topic1,Topic2


volumes:
  zookeeper_data:
    driver: local
  kafka_data:
    driver: local

```

### License

Apache 2.0
