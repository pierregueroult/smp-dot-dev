FROM openjdk:21-slim

WORKDIR /minecraft

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./config /minecraft/config/
COPY ./mods /minecraft/mods/
COPY ./server.jar /minecraft/server.jar
COPY ./eula.txt /minecraft/eula.txt
COPY ./server-icon.png /minecraft/server-icon.png

EXPOSE 25565
EXPOSE 24454/udp

RUN echo '#!/bin/bash \n\
cp -n /minecraft/meta/* /minecraft/ 2>/dev/null || true \n\
exec java -Xms4G -Xmx5G -jar server.jar nogui' > /minecraft/start.sh && \
chmod +x /minecraft/start.sh

CMD ["/minecraft/start.sh"]