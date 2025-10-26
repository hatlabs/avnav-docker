# AvNav Docker - Developer Guide

Docker image for AvNav marine navigation software.

## Repository Purpose

This repository packages [AvNav](https://github.com/wellenvogel/avnav) into a Docker container for easy deployment on Raspberry Pi and other platforms. It's part of the HaLOS marine computing ecosystem.

## Structure

```
avnav-docker/
├── Dockerfile              # Multi-arch Docker image definition
├── .github/workflows/      # CI/CD automation
│   └── build.yml          # Build and publish workflow
├── README.md              # User documentation
├── LICENSE                # MIT License
└── CLAUDE.md              # This file
```

## Building

### Local Build

```bash
# Simple build for current architecture
docker build -t avnav:test .

# Multi-architecture build
docker buildx build --platform linux/amd64,linux/arm64 -t avnav:test .
```

### GitHub Actions

The workflow automatically builds and publishes images on:
- Push to `main` branch → `ghcr.io/hatlabs/avnav-docker:main`, `:latest`, `:20250822`
- Tags matching `v*` → `ghcr.io/hatlabs/avnav-docker:v1.0.0`, `:1.0`, etc.

## Testing

### Quick Test

```bash
# Run container
docker run -d --name avnav-test -p 3011:8080 avnav:test

# Check logs
docker logs avnav-test

# Test web interface
curl http://localhost:3011

# Clean up
docker rm -f avnav-test
```

### Full Test with Volumes

```bash
docker run -d \
  --name avnav-test \
  -p 3011:8080 \
  -v $(pwd)/test-data:/data \
  -v $(pwd)/test-charts:/charts \
  -v $(pwd)/test-config:/config \
  avnav:test
```

## Updating AvNav Version

1. Check for new releases at https://www.wellenvogel.net/software/avnav/downloads/release/
2. Update `AVNAV_VERSION` ARG in Dockerfile
3. Update version in README.md
4. Update version tag in `.github/workflows/build.yml`
5. Test build locally
6. Commit and push changes
7. Tag release: `git tag v20250822 && git push --tags`

## Integration with HaLOS

This repository is part of the `halos-distro` workspace and integrates with:
- **runtipi-marine-app-store**: App store entry for easy installation
- **halos-pi-gen**: Pre-loaded in HaLOS images

## Common Issues

### Build Failures

- Ensure AvNav .deb package URL is valid
- Check that Debian dependencies are available in trixie repository
- Verify multi-arch build has QEMU setup correctly

### Runtime Issues

- Check container logs: `docker logs <container-name>`
- Verify port 8080 is accessible inside container
- Ensure volumes have correct permissions
- For serial device access, verify `--device` mapping and permissions

## Contributing

1. Test changes locally first
2. Update documentation (README.md, CLAUDE.md)
3. Follow conventional commit format
4. Ensure GitHub Actions workflow passes
5. Update version numbers consistently

## Upstream

- **AvNav Project**: https://github.com/wellenvogel/avnav
- **AvNav Documentation**: https://www.wellenvogel.net/software/avnav/docs/
- **AvNav License**: MIT
