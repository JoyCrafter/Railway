FROM eclipse-temurin:21-jre

WORKDIR /server

# 필요한 패키지 (tmux, curl, openssh-server)를 설치합니다.
# tmux를 설치하여 서버 콘솔에 접근할 수 있게 합니다.
RUN apt-get update && \
    apt-get install -y curl openssh-server tmux && \
    rm -rf /var/lib/apt/lists/*

# SSH 서버를 설정합니다.
# PermitRootLogin no: 보안을 위해 루트 로그인 비활성화
# useradd: 'minecraft'라는 사용자를 생성하고 비밀번호를 'password'로 설정합니다. (🚨 나중에 꼭 강력한 비밀번호로 바꾸세요!)
RUN mkdir -p /var/run/sshd && \
    useradd -ms /bin/bash minecraft && echo "minecraft:password" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Paper 서버 JAR 파일을 다운로드합니다. (예시: Paper 1.21.1)
# 🚨 이 URL은 PaperMC 공식 사이트(https://papermc.io/downloads)에서 최신 버전을 확인하고 복사하는 것이 가장 정확합니다.
RUN curl -o paper.jar https://fill-data.papermc.io/v1/objects/4bee8c5b1418418bbac3fa82be2bb130d8b224ac9f013db8d48823225cf6ed0a/paper-1.21.8-21.jar

# 서버 시작 스크립트 (start.sh)를 컨테이너에 복사하고 실행 권한을 부여합니다.
COPY start.sh .
RUN chmod +x start.sh

# 마인크래프트 포트(25565)와 SSH 포트(22)를 외부에 노출합니다.
EXPOSE 19132 22

# 컨테이너가 시작될 때 start.sh 스크립트를 실행하도록 지시합니다.
CMD ["./start.sh"]
