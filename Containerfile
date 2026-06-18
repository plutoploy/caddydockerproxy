FROM docker.io/caddy:builder AS builder

RUN apk add --no-cache gcc musl-dev build-base

ENV CGO_ENABLED=1

RUN xcaddy build \
    --output /usr/bin/caddy \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/fvbommel/caddy-combine-ip-ranges \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/AnswerDotAI/caddy-sqlite-router


# Final stage
FROM docker.io/caddy:latest

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
