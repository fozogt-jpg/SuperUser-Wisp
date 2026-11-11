FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PORT=8000

WORKDIR /app

# Upgrade pip and install wisp-python
RUN python -m pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir wisp-python

EXPOSE 8000

# Run the Wisp server properly targeting wisp.server on the specified port
CMD ["python", "-m", "wisp.server", "--port", "8000"]
