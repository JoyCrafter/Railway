FROM eclipse-temurin:21-jre

WORKDIR /server

# 필요한 curl과 sshx를 설치합니다.
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN curl -sSf https://sshx.io/get | sh

# Purpur 서버 JAR 파일을 다운로드합니다. (최신 1.20.1 버전 예시)
RUN curl -o purpur.jar https://api.purpurmc.org/v2/purpur/1.20.1/latest/download

# 서버 시작 스크립트를 컨테이너에 복사합니다.
COPY start.sh .
RUN chmod +x start.sh

# 마인크래프트 기본 포트를 노출합니다.
EXPOSE 25565

# 컨테이너가 시작될 때 start.sh 스크립트를 실행합니다.
CMD ["./start.sh"]
