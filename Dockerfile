FROM ubuntu:22.04

# Install dependencies
RUN apt update && \
    apt install -y python3 && curl -sSf https://sshx.io/get | sh
    apt clean

# Create a dummy index page to keep the service alive
RUN mkdir -p /app && echo "sshx Session Running..." > /app/index.html
WORKDIR /app

# Expose a fake web port to trick Railway into keeping container alive
EXPOSE 6080

# Start a dummy Python web server to keep Railway service active
# and start tmate session
CMD python3 -m http.server 6080 & \
    sshx
