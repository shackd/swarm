#! /bin/bash

# Traefik
cd traefik
if [ ! "$(docker network ls | grep traefik-net)" ]; then
  echo "Creating traefik-net network ..."
  docker network create traefik-net  --driver overlay
else
  echo "traefik-net network exists."
fi

echo "Creating treafik stack ..."
docker stack deploy -c ./docker-compose.yml traefik
cd ..

# Mosquitto
cd mosquitto
echo "Creating mosquitto stack ..."
if [ ! "$(docker network ls | grep mqtt-net)" ]; then
  echo "Creating mqtt-net network ..."
  docker network create mqtt-net --driver overlay
else
  echo "mqtt-net network exists."
fi
docker stack deploy -c ./docker-compose.yml mosquitto
cd ..

# Influx TICK stack (minus telegrag, created first ...)
cd influx
echo "Creating influx stack ..."
docker stack deploy -c ./docker-compose.yml influx
cd ..

# Owntracks
cd owntracks
echo "Creating owntracks stack ..."
docker stack deploy -c ./docker-compose.yml owntracks
cd ..