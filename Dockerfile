FROM ubuntu:22.04

# 패키지 설치  
RUN apt update && \
    apt install -y openssh-server tmux python3 && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    apt clean

# 포트 노출  
EXPOSE 22

# 컨테이너 시작 시 실행될 명령어  
CMD /bin/bash -c "\  
    /usr/sbin/sshd; \
    SESSION='my_session'; \
    if ! tmux has-session -t $SESSION 2>/dev/null; then \
        tmux new-session -d -s $SESSION; \
        tmux send-keys -t $SESSION 'python3 -m http.server 6080' C-m; \
    fi; \
    tmux attach-session -t $SESSION"
