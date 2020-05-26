#!/bin/bash

set -e

envsubst < /opt/mirrormaker/producer.template > /var/run/mirrormaker/producer.config
envsubst < /opt/mirrormaker/consumer.template > /var/run/mirrormaker/consumer.config

/opt/bitnami/kafka/bin/kafka-mirror-maker.sh \
    --abort.on.send.failure true \
    --new.consumer \
    --producer.config /var/run/mirrormaker/producer.config \
    --consumer.config /var/run/mirrormaker/consumer.config \
    --num.streams "${NUM_STREAMS:-1}" \
    --whitelist "${WHITELIST}"
