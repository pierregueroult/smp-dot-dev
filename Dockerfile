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
COPY ./launch.sh /minecraft/launch.sh

EXPOSE 25565
EXPOSE 24454/udp

RUN chmod +x /minecraft/launch.sh

CMD ["./launch.sh"]