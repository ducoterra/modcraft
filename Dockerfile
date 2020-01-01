FROM openjdk:latest

WORKDIR /mc_server
COPY ./server .

WORKDIR /mc_data
CMD cp -r /mc_server/* . && java -Xmx1024M -Xms1024M -XX:ParallelGCThreads=2 -jar server.jar nogui