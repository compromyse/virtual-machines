FROM debian:bookworm

COPY scripts/provision-root.sh /provision-root.sh
RUN bash /provision-root.sh
RUN rm /provision-root.sh

USER compromyse
WORKDIR /home/compromyse

COPY scripts/provision-user.sh /tmp/provision-user.sh
RUN bash /tmp/provision-user.sh
RUN rm /tmp/provision-user.sh

CMD [ "cat" ]
