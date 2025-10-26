# AvNav Docker

Docker image for [AvNav](https://www.wellenvogel.net/software/avnav/docs/), an open-source marine navigation software for Raspberry Pi.

## Overview

AvNav is a navigation software that turns your Raspberry Pi into a powerful marine navigation computer. This Docker image packages AvNav for easy deployment and integration with other marine software like Signal K.

## Features

- Multi-architecture support (ARM64 for Raspberry Pi, AMD64 for development)
- Pre-configured Signal K integration
- Persistent storage for charts, data, and configuration
- Health checks built-in
- Based on Debian Trixie

## Quick Start

```bash
docker run -d \
  --name avnav \
  -p 3011:8080 \
  -v avnav-data:/data \
  -v avnav-charts:/charts \
  -v avnav-config:/config \
  --device=/dev:/dev \
  ghcr.io/hatlabs/avnav-docker:latest
```

Access AvNav at `http://localhost:3011`

## Volumes

- `/data` - AvNav data directory (tracks, logs, etc.)
- `/charts` - Chart storage directory
- `/config` - Configuration files

## Ports

- `8080` - Web interface (map to external port of your choice, e.g., 3011)

## Environment Variables

Currently, no environment variables are required. Configuration is managed through AvNav's web interface or configuration files in `/config`.

## Signal K Integration

The image is pre-configured to connect to Signal K on `localhost:3000`. If Signal K is running in a separate container, update the configuration through the AvNav web interface or mount a custom configuration file.

## Hardware Access

For serial port access (NMEA 0183/2000 devices):

```bash
docker run -d \
  --name avnav \
  -p 3011:8080 \
  -v avnav-data:/data \
  -v avnav-charts:/charts \
  --device=/dev:/dev \
  --privileged \
  ghcr.io/hatlabs/avnav-docker:latest
```

**Note:** `--privileged` flag may be required for full hardware access.

## Building Locally

```bash
docker build -t avnav:local .
```

For multi-architecture builds:

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t avnav:local .
```

## Versions

- AvNav Version: 20250822
- Base Image: debian:trixie-slim

## Documentation

- [AvNav Official Documentation](https://www.wellenvogel.net/software/avnav/docs/)
- [AvNav GitHub Repository](https://github.com/wellenvogel/avnav)

## License

This Docker image is licensed under the MIT License, matching the upstream AvNav project. See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please open an issue or pull request on the [GitHub repository](https://github.com/hatlabs/avnav-docker).

## Support

For issues with this Docker image, please open an issue on GitHub. For AvNav-specific questions, refer to the [AvNav documentation](https://www.wellenvogel.net/software/avnav/docs/) or [AvNav GitHub repository](https://github.com/wellenvogel/avnav).
