#! /bin/bash

# Traefik
if [ ! "$(docker network ls | grep traefik-net)" ]; then
  echo "Creating traefik-net network ..."
  docker network create traefik-net  --driver overlay
else
  echo "traefik-net network exists."
fi

echo "Creating treafik stack ..."
docker stack deploy -c traefik/docker-compose.yml traefik

# Mosquitto
echo "Creating mosquitto stack ..."
if [ ! "$(docker network ls | grep mqtt-net)" ]; then
  echo "Creating mqtt-net network ..."
  docker network create mqtt-net --driver overlay
else
  echo "mqtt-net network exists."
fi
docker stack deploy -c mosquitto/docker-compose.yml mosquitto

# Influx TICK stack (minus telegrag, created first ...)
echo "Creating influx stack ..."
docker stack deploy -c influx/docker-compose.yml influx

# Owntracks
echo "Creating owntracks stack ..."
docker stack deploy -c owntracks/docker-compose.yml owntracks
