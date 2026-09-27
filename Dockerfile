FROM python:3.14-alpine AS builder

WORKDIR /build
COPY pyproject.toml .
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir .

FROM python:3.14-alpine

WORKDIR /app

RUN apk add --no-cache \
    chromium \
    chromium-chromedriver \
    xvfb

COPY --from=builder /opt/venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    HEADLESS=true \
    SE_CHROMEDRIVER=/usr/bin/chromedriver \
    CHROME_BIN=/usr/bin/chromium-browser \
    DISPLAY=:99

COPY . .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
