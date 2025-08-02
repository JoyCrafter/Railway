FROM eclipse-temurin:21-jre

WORKDIR /server

# 필요한 패키지(curl, openssh-server)를 설치합니다.
RUN apt-get update \
    && apt-get install -y curl openssh-server \
    && rm -rf /var/lib/apt/lists/*

# SSH 서버를 설정합니다.
RUN mkdir /var/run/sshd
RUN useradd -ms /bin/bash minecraft && echo "minecraft:password" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Paper 서버 JAR 파일을 다운로드합니다. (최신 1.20.1 버전 예시)
RUN curl -o paper.jar https://fill-data.papermc.io/v1/objects/4bee8c5b1418418bbac3fa82be2bb130d8b224ac9f013db8d48823225cf6ed0a/paper-1.21.8-21.jar

# 서버 시작 스크립트를 컨테이너에 복사합니다.
COPY start.sh .
RUN chmod +x start.sh

# 마인크래프트 포트와 SSH 포트(22)를 노출합니다.
EXPOSE 25565 22

# 컨테이너가 시작될 때 start.sh 스크립트를 실행합니다.
CMD ["./start.sh"]
