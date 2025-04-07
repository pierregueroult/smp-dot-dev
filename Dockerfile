FROM openjdk:21-slim

# Créer un utilisateur minecraft avec un home directory
RUN useradd -ms /bin/bash minecraft

WORKDIR /minecraft

# Installer wget
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copier les fichiers nécessaires
COPY ./config /minecraft/config/
COPY ./mods /minecraft/mods/
COPY ./server.jar /minecraft/server.jar
COPY ./eula.txt /minecraft/eula.txt
COPY ./server-icon.png /minecraft/server-icon.png

# Exposer le port Minecraft
EXPOSE 25565

# Script de démarrage pour copier les fichiers meta au démarrage
RUN echo '#!/bin/bash \n\
cp -n /minecraft/meta/* /minecraft/ 2>/dev/null || true \n\
exec java -Xms4G -Xmx7G -jar server.jar nogui' > /minecraft/start.sh && \
chmod +x /minecraft/start.sh

# Changer les permissions du répertoire et des fichiers pour l'utilisateur minecraft
RUN chown -R minecraft:minecraft /minecraft && chmod -R 755 /minecraft

# Passer à l'utilisateur minecraft
USER minecraft

# Lancer le serveur Minecraft avec notre script de démarrage
CMD ["/minecraft/start.sh"]