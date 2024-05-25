FROM debian:bookworm

COPY scripts/provision-root.sh /provision-root.sh
RUN bash /provision-root.sh
RUN rm /provision-root.sh

COPY scripts/provision-docker.sh /tmp/provision-docker.sh
RUN bash /tmp/provision-docker.sh

USER compromyse
WORKDIR /home/compromyse

ENV USER=compromyse
ENV CONFIG=d
ENV TERM=screen-256color-bce

RUN mkdir ~/.ssh
RUN --mount=type=secret,id=id_rsa,required sudo cp /run/secrets/id_rsa ~/.ssh/id_rsa
RUN --mount=type=secret,id=id_rsa_pub,required sudo cp /run/secrets/id_rsa_pub ~/.ssh/id_rsa.pub
RUN sudo chown compromyse:compromyse ~/.ssh/id_rsa ~/.ssh/id_rsa.pub

COPY scripts/provision-user.sh /tmp/provision-user.sh
RUN bash /tmp/provision-user.sh

CMD [ "bash" ]
