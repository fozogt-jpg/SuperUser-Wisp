FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PORT=8000

WORKDIR /app

# Upgrade pip and install wisp-python
RUN python -m pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir wisp-python

EXPOSE 8000

# Bind to 0.0.0.0 so external health checks can reach port 8000
CMD ["python", "-m", "wisp.server", "--host", "0.0.0.0", "--port", "8000"]
