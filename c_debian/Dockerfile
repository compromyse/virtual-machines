FROM debian:bookworm

COPY scripts/provision-root.sh /provision-root.sh
RUN bash /provision-root.sh
RUN rm /provision-root.sh

COPY scripts/provision-docker.sh /tmp/provision-docker.sh
RUN bash /tmp/provision-docker.sh
RUN rm /tmp/provision-docker.sh

USER compromyse
WORKDIR /home/compromyse

ENV USER=compromyse
ENV CONFIG=d

COPY scripts/provision-user.sh /tmp/provision-user.sh
RUN bash /tmp/provision-user.sh
# RUN rm /tmp/provision-user.sh

CMD [ "cat" ]
