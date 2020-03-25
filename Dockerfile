FROM openjdk:8-slim

# Install rsync for backups
RUN apt update && apt install -y rsync

# Create mc_server dir and copy new stuff into it
WORKDIR /mc_server
COPY ./server .

# Install forge and copy mods
COPY forge-1.12.2-14.23.5.2847-installer.jar forge.jar
RUN java -jar forge.jar --installServer && rm forge.jar
COPY mods ./mods

# Create minecraft user
RUN groupadd -r minecraft && useradd --no-log-init -m -r -g minecraft minecraft

# Create persistent folder to hold our minecraft data
WORKDIR /mc_data
RUN chown -R minecraft:minecraft .

USER minecraft
# 1. Copy new server files
# 2. Start the server
CMD cp -r /mc_server/. . && \
java -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads="$THREADS" -XX:+AggressiveOpts -Xmx"$MAX_RAM"G -Xms"$MIN_RAM"G -jar $(ls forge*.jar) nogui