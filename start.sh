#!/bin/bash

MEMORY=${MEMORY:-1G}

echo "Starting server with ${MEMORY} RAM"

sshx &

exec java -Xmx${MEMORY} -Xms${MEMORY} -jar purpur.jar nogui
