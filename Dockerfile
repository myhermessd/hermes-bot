FROM python:3.11-slim

RUN apt-get update && apt-get install -y git curl nodejs npm

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

ENV PATH="/root/.local/bin:$PATH"

RUN git clone https://github.com/NousResearch/hermes-agent.git /hermes
WORKDIR /hermes
RUN uv venv venv --python 3.11 && \
    . venv/bin/activate && \
    uv pip install -e .

ENV TELEGRAM_BOT_TOKEN=""
ENV TELEGRAM_USER_ID=""
ENV OPENROUTER_API_KEY=""

CMD ["/hermes/venv/bin/hermes", "gateway"]
