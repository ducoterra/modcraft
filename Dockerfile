FROM openjdk:8-slim

WORKDIR /mc_server
COPY server .
RUN java -jar forge-1.12.2-14.23.5.2847-installer.jar --installServer && rm forge-1.12.2-14.23.5.2847-installer.jar
COPY mods ./mods

WORKDIR /mc_data
RUN groupadd -r minecraft && useradd --no-log-init -m -r -g minecraft minecraft
RUN chown -R minecraft:minecraft .
USER minecraft
# 1. Remove the old mods folder and replace with new mods
# 2. Copy files only if they don't yet exist (server.jar, server.properties, etc)
# 3. Start the server
CMD rm -rf mods && \
for file in $(ls /mc_server); do if test ! -s $file; then echo "copying $file" && cp -r /mc_server/$file .; fi; done && \
java -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads="$THREADS" -XX:+AggressiveOpts -Xmx"$MAX_RAM"G -Xms"$MIN_RAM"G -jar forge-1.12.2-14.23.5.2847-universal.jar nogui