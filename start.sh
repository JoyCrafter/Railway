#!/bin/bash

# 시작할 tmux 세션 이름  
SESSION="Server"

# tmux 세션이 이미 존재하는지 체크  
if ! tmux has-session -t $SESSION 2>/dev/null; then  
    # 새 세션 생성 및 실행  
    tmux new-session -d -s $SESSION

    # 세션 안에서 명령 실행  
    tmux send-keys -t $SESSION "python3 -m http.server 6080" C-m  
fi

# 포트 포워딩 또는 SSH 접속 세팅이 필요하면 여기서 설정

# tmux 세션 유지  
tmux attach-session -t $SESSION
