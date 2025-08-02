FROM eclipse-temurin:21-jre

WORKDIR /server

# 필요한 패키지(curl, openssh-server)를 설치합니다.
RUN apt-get update \
    && apt-get install -y curl openssh-server \
    && rm -rf /var/lib/apt/lists/*

# SSH 서버 설정을 준비합니다.
RUN mkdir /var/run/sshd
RUN useradd -ms /bin/bash minecraft && echo "minecraft:password" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 서버 시작 스크립트를 컨테이너에 복사합니다.
COPY start.sh .
RUN chmod +x start.sh

# 마인크래프트 포트와 SSH 포트(22)를 노출합니다.
EXPOSE 25565 22

# 컨테이너가 시작될 때 start.sh 스크립트를 실행합니다.
CMD ["./start.sh"]
