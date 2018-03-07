FROM kjbreil/lgsm

LABEL maintainer="Kjell Breiland <kjell.breiland@gmail.com>"

ENV TERM xterm

ENV IP "0.0.0.0"
ENV RCON_PASSWORD "iamstupid"
ENV BRANCH "stable"

RUN bash linuxgsm.sh fctrserver && \
  /home/server/fctrserver update-lgsm && \
  /home/server/fctrserver auto-install && \
  /home/server/fctrserver update

EXPOSE 27015/tcp 34197/udp

COPY entrypoint.sh entrypoint.sh

VOLUME ["/home/server/log", "/home/server/serverfiles/data/"]

ENTRYPOINT ["bash", "entrypoint.sh"]

CMD ["start"]
