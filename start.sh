#!/bin/bash

# --- 1. SSH 서버 시작 ---
# -D 옵션은 SSH 데몬이 백그라운드에서 실행되고, 현재 셸 세션과 연결되지 않도록 합니다.
echo "Starting SSH server..."
/usr/sbin/sshd -D &

# --- 2. EULA 동의 파일 생성 ---
# 마인크래프트 서버는 처음 실행 시 eula.txt 파일에 동의해야 합니다.
# 이미 파일이 있다면 덮어쓰지 않습니다.
if [ ! -f eula.txt ]; then
  echo "eula=true" > eula.txt
  echo "EULA file created."
fi

# --- 3. tmux 세션 내에서 마인크래프트 서버 시작 ---
# 'minecraft_server'라는 이름의 tmux 세션을 생성하고 그 안에서 Java 명령어를 실행합니다.
# -Xmx, -Xms: 마인크래프트 서버에 할당할 최대/최소 RAM (Railway 리소스에 맞춰 조절)
# nogui: GUI 없이 서버를 실행하여 메모리 사용량을 줄입니다.
echo "Starting Minecraft server in a tmux session..."
tmux new -s minecraft_server -d "java -Xmx512M -Xms512M -jar paper.jar nogui"

echo "Minecraft server started in 'minecraft_server' tmux session."
echo "You can attach to the session via SSH: ssh minecraft@YOUR_RAILWAY_IP, then 'tmux attach -t minecraft_server'"

# 컨테이너가 계속 실행되도록 유지합니다.
# tmux 세션은 백그라운드에서 실행되므로, 이 명령어가 없으면 스크립트가 종료되고 컨테이너도 종료됩니다.
# tail -f /dev/null 은 컨테이너를 종료하지 않고 무한정 실행되도록 하는 일반적인 방법입니다.
tail -f /dev/null
