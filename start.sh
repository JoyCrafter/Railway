#!/bin/bash

MEMORY=${MEMORY:-512M}

echo "Starting server with ${MEMORY} RAM"

sshx &

exec java -Xmx${MEMORY} -Xms${MEMORY} -jar paper.jar nogui
