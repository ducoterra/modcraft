FROM openjdk:8-slim

WORKDIR /mc_server
COPY server .
RUN java -jar forge-1.12.2-14.23.5.2847-installer.jar --installServer && rm forge-1.12.2-14.23.5.2847-installer.jar
COPY mods ./mods

WORKDIR /mc_data
CMD rm -rf mods && cp -r /mc_server/* . && java -Xmx"$MAX_RAM"G -Xms"$MIN_RAM"G -jar forge-1.12.2-14.23.5.2847-universal.jar nogui