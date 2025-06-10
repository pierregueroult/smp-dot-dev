FROM openjdk:21-slim

WORKDIR /minecraft

# COPY ./config /minecraft/config/
# COPY ./mods /minecraft/mods/
COPY ./server.jar /minecraft/server.jar
COPY ./eula.txt /minecraft/eula.txt
COPY ./server-icon.png /minecraft/server-icon.png
COPY ./launch.sh /minecraft/launch.sh

EXPOSE 25565
EXPOSE 24454/udp
EXPOSE 25575

RUN chmod +x /minecraft/launch.sh

CMD ["./launch.sh"]