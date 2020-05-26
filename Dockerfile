FROM bitnami/kafka:2
USER root
RUN install_packages gettext

ADD ./consumer.config /opt/mirrormaker/consumer.template
ADD ./producer.config /opt/mirrormaker/producer.template
ADD ./run.sh /opt/mirrormaker/run.sh
RUN chmod +x /opt/mirrormaker/run.sh

RUN mkdir -p /var/run/mirrormaker
RUN chown 1001 /var/run/mirrormaker

ENV WHITELIST *
ENV DESTINATION "localhost:6667"
ENV SOURCE "localhost:6667"
ENV SECURITY "PLAINTEXT"
ENV GROUPID "_mirror_maker"
ENV NUM_STREAMS "1"

USER 1001
CMD /opt/mirrormaker/run.sh
