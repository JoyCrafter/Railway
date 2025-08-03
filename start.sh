#!/bin/bash

# --- 1. SSH 서버 시작 ---
# -D 옵션은 SSH 데몬이 백그라운드에서 실행되도록 합니다.
# 이렇게 해야 스크립트가 다음 명령어들을 계속 실행할 수 있습니다.
echo "Starting SSH server..."
/usr/sbin/sshd -D &

# --- 2. 마인크래프트 EULA 동의 파일 생성 ---
# 마인크래프트 서버는 처음 실행 시 'eula.txt' 파일에 동의(eula=true)해야만 시작됩니다.
# 파일이 없으면 새로 만들고, 이미 있다면 건너뜁니다.
if [ ! -f eula.txt ]; then
  echo "eula=true" > eula.txt
  echo "EULA file created."
fi

# --- 3. tmux 세션 내에서 마인크래프트 서버 시작 ---
# 'minecraft_server'라는 이름의 tmux 세션을 백그라운드(-d)로 생성하고,
# 그 안에서 마인크래프트 서버(paper.jar)를 실행합니다.
# -Xmx, -Xms: 마인크래프트 서버에 할당할 최대/최소 RAM (예: 4G = 4기가바이트)
# 🚨 Railway에서 제공하는 RAM 리소스에 맞춰 조절해야 합니다. (예: 2GB라면 -Xmx2G -Xms2G)
# nogui: 그래픽 인터페이스 없이 서버를 실행하여 메모리 사용량을 줄입니다.
echo "Starting Minecraft server in a tmux session..."
tmux new -s minecraft_server -d "java -Xmx1G -Xms1G -jar paper.jar --nogui"

echo "Minecraft server started in 'minecraft_server' tmux session."
echo "To access the server console, SSH to your Railway instance and then run: tmux attach -t minecraft_server"

# --- 4. 컨테이너가 종료되지 않도록 유지 ---
# tmux 세션은 백그라운드에서 실행되므로, 이 명령어가 없으면 start.sh 스크립트가 끝나고 컨테이너도 종료됩니다.
# 'tail -f /dev/null'은 아무 작업도 하지 않고 무한히 실행되며, 컨테이너가 계속 유지되도록 합니다.
tail -f /dev/null
