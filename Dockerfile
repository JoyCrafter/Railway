FROM eclipse-temurin:17-jre-focal

WORKDIR /server

# 필요한 패키지(curl)와 sshx를 설치합니다.
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN curl -sSf https://sshx.io/get | sh

# 마인크래프트 서버용 포트를 노출합니다.
EXPOSE 19132

# 컨테이너가 시작되면 sshx를 실행합니다.
CMD ["sshx"]
