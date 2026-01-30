FROM python:3.11-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

COPY pyproject.toml uv.lock README.md ./
COPY src/ ./src/
COPY .github/core/ ./.github/core/

RUN uv sync --frozen

ENV PATH="/app/.venv/bin:$PATH"

# For cloud deployment with HTTP transport
CMD ["alpaca-mcp-server", "serve", "--transport", "streamable-http", "--host", "0.0.0.0", "--port", "8000", "--allowed-hosts", "alpaca-mcp-server-production-05b4.up.railway.app"]
