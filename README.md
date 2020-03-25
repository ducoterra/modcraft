# Modcraft

## Getting forge

Grab your preferred version from <http://files.minecraftforge.net/>

## Running Locally

```bash
docker-compose build modcraft
docker-compose up modcraft
```

## Uploading to Docker Hub

In docker-compose.yaml, update the image tag to:

```yaml
...
services:
  modcraft:
    build: .
    image: <your_username>/modcraft:<version>-1
    ports:
...
```

then run

```bash
docker-compose push
```

## Running in kubernetes

In k8s/deploy.yaml, edit the deploy

```yaml
...
    spec:
      containers:
      - name: modcraft
        image: <your image from above>
        ports:
...
```

Then run the following

```bash
kubectl apply -f k8s/pvc
kubectl apply -f k8s
```

Your modcraft server will be available on port 25565

## Create a Backup

```bash
kubectl cp <pod_name>:/mc_data <backup>
```

## Restore from Backup

```bash
kubectl cp <backup> <pod_name>:/mc_data
```
