FROM python:3.12-slim

# Install curl and CA certificates to securely fetch the blocklist
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install wisp-server-python
RUN pip install --no-cache-dir wisp-server-python

# Download a community hosts-style blocklist, parse domains, and add custom entries
RUN curl -fsSL https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn/hosts \
    | grep -v '^#' \
    | awk '{print $2}' \
    | grep -E '^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' > /blacklist.txt \
    && printf "\ntiktok.com\ntiktokcdn.com\ntiktokv.com\nmusical.ly\ntwitch.tv\nttvnw.net\njtvnw.net\n" >> /blacklist.txt

EXPOSE 8000

CMD ["python3", "-m", "wisp.server", "--host", "0.0.0.0", "--port", "8000", "--blacklist", "/blacklist.txt"]
