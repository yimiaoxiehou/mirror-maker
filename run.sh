#!/bin/bash

set -e

envsubst < /producer.template > /producer.config
envsubst < /consumer.template > /consumer.config

/opt/bitnami/kafka/bin/kafka-mirror-maker.sh --abort.on.send.failure true --new.consumer --producer.config /producer.config --consumer.config /consumer.config --whitelist ${WHITELIST}
