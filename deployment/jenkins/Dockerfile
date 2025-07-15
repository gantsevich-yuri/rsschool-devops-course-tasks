FROM jenkins/inbound-agent:3309.v27b_9314fd1a_4-6

USER root
RUN apt-get update && \
    apt-get install -y \
        docker.io \
        python3 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*
USER jenkins