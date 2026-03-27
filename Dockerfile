FROM python:3.11-slim
RUN apt-get update && apt-get install -y git curl nodejs npm
RUN curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
CMD ["hermes", "gateway"]
