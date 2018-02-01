#! /bin/sh

# For an update to each service in the swarm
# This will redistribute services to nodes
docker service ls -q > /tmp/dkr_svcs && for i in `cat /tmp/dkr_svcs`; do docker service update "$i" --detach=false --force ; done
