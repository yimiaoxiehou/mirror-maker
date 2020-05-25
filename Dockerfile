FROM bitnami/kafka:2
USER root
RUN install_packages gettext

ADD ./consumer.config /consumer.template
ADD ./producer.config /producer.template
ADD ./run.sh /
RUN chmod +x /run.sh

ENV WHITELIST *
ENV DESTINATION "localhost:6667"
ENV SOURCE "localhost:6667"
ENV SECURITY "PLAINTEXT"
ENV GROUPID "_mirror_maker"

USER noroot
CMD /run.sh
