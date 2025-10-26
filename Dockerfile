FROM debian:trixie-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install AvNav
ARG AVNAV_VERSION=20250822
RUN wget https://www.wellenvogel.net/software/avnav/downloads/release/${AVNAV_VERSION}/avnav_${AVNAV_VERSION}_all.deb \
    && apt-get update \
    && apt-get install -y ./avnav_${AVNAV_VERSION}_all.deb \
    && rm avnav_${AVNAV_VERSION}_all.deb \
    && rm -rf /var/lib/apt/lists/*

# Create directories for volumes
RUN mkdir -p /data /charts /config

# Create a default configuration that points to Signal K
RUN mkdir -p /home/avnav/.avnav \
    && echo '<?xml version="1.0" encoding="UTF-8" ?>' > /home/avnav/.avnav/avnav_server.xml \
    && echo '<AVNConfig>' >> /home/avnav/.avnav/avnav_server.xml \
    && echo '  <AVNHttpServer port="8080"/>' >> /home/avnav/.avnav/avnav_server.xml \
    && echo '  <SignalKConnector enabled="true" host="localhost" port="3000"/>' >> /home/avnav/.avnav/avnav_server.xml \
    && echo '</AVNConfig>' >> /home/avnav/.avnav/avnav_server.xml

# Expose the web interface port
EXPOSE 8080

# Set working directory
WORKDIR /home/avnav

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8080/ || exit 1

# Start AvNav
CMD ["avnav"]
