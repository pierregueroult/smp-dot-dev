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

# Changer les permissions du répertoire et des fichiers pour l'utilisateur minecraft
RUN chown -R minecraft:minecraft /minecraft && chmod -R 755 /minecraft

# Passer à l'utilisateur minecraft
USER minecraft

# Vérifier les fichiers avant de démarrer
RUN ls -la /minecraft

# Lancer le serveur Minecraft
CMD ["java", "-Xms4G", "-Xmx7G", "-jar", "/minecraft/server.jar", "nogui"]