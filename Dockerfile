FROM openjdk-21-jdk

WORKDIR /server

# 필요한 패키지 및 sshx를 설치합니다.
RUN apt-get update && apt-get install -y curl tar nano ca-certificates && rm -rf /var/lib/apt/lists/*
RUN curl -sSf https://sshx.io/get | sh

# PufferPanel을 다운로드합니다.
RUN curl -L -o pufferpanel.tar.gz https://github.com/PufferPanel/PufferPanel/releases/latest/download/pufferpanel-v2-linux-amd64.tar.gz
RUN tar -xvzf pufferpanel.tar.gz
RUN rm pufferpanel.tar.gz
RUN chmod +x pufferpanel

# PufferPanel 설정을 위한 디렉토리를 수동으로 만듭니다.
RUN mkdir -p /var/lib/pufferpanel/data /etc/pufferpanel

# PufferPanel 포트를 노출합니다.
EXPOSE 19132 8080

# 서버 시작 스크립트를 컨테이너에 복사합니다.
COPY start.sh .
RUN chmod +x start.sh

# 컨테이너가 시작될 때 start.sh 스크립트를 실행합니다.
CMD ["./start.sh"]
