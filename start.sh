#!/bin/bash

MEMORY=${MEMORY:-1G}

echo "Starting server with ${MEMORY} RAM"

# SSH 서버를 백그라운드에서 실행합니다.
/usr/sbin/sshd &

exec java -Xmx${MEMORY} -Xms${MEMORY} -jar paper.jar nogui
