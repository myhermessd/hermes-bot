FROM python:3.11-slim

RUN apt-get update && apt-get install -y git curl nodejs npm

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

ENV PATH="/root/.local/bin:$PATH"

RUN git clone https://github.com/NousResearch/hermes-agent.git /hermes
WORKDIR /hermes
RUN uv venv venv --python 3.11 && \
    . venv/bin/activate && \
    uv pip install -e ".[all]"

CMD mkdir -p ~/.hermes && \
    printf "KIMI_API_KEY=%s\nTELEGRAM_BOT_TOKEN=%s\nTELEGRAM_ALLOWED_USERS=%s\n" \
    "$KIMI_API_KEY" "$TELEGRAM_BOT_TOKEN" "$TELEGRAM_ALLOWED_USERS" > ~/.hermes/.env && \
    /hermes/venv/bin/hermes gateway --provider kimi-coding --model moonshot-v1-auto
