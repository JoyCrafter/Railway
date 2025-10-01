# Ubuntu base 이미지 사용
FROM ubuntu:22.04

# DEBIAN 프런트엔드를 비대화식으로 설정
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Seoul

# Ubuntu mirror를 Kakao로 변경
RUN sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

# systemd를 설치하고 활성화
ENV container docker

RUN apt-get update \
  && apt-get install -y systemd \
  && apt-get install -y build-essential \
    tzdata \
    vim curl \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/{apt,dpkg,cache,log} \
  && apt-get update 

# systemd 초기화 시스템 활성화를 위한 설정
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
