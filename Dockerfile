FROM ubuntu:22.04

# Install dependencies  
RUN apt update && \
    apt install -y software-properties-common wget curl git openssh-client tmux python3 && \
    apt clean

# Create a dummy index page to keep the service alive  
RUN mkdir -p /app && echo "Tmux Session Running..." > /app/index.html  
WORKDIR /app

# Expose a fake web port to trick Railway into keeping container alive  
EXPOSE 6080

# Set environment variables for SSH (optional, if SSH 접속 필요시)
# ENV SSH_PORT=2222

# Start a script that runs tmux and keeps the container alive  
COPY start.sh /start.sh  
RUN chmod +x /start.sh

CMD ["./start.sh"]
