#!/usr/bin/env bash
rm -f docker-compose.yaml
mv docker-compose-new.yml docker-compose.yml
sed -i "s~explodingcamera~ELESTIO~g" start.sh
docker buildx build . --output type=docker,name=elestio4test/pleroma:latest | docker load
