FROM python:3.11-slim
RUN pip install hermes-agent
CMD ["hermes", "gateway"]

