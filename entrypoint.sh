#!/bin/sh
set -e

if [ "${HEADLESS}" = "true" ]; then
    Xvfb :99 -screen 0 1920x1080x24 &
    export DISPLAY=:99
    sleep 1
fi

if [ "$#" -eq 0 ]; then
    exec robot --outputdir /app/results --variable "HEADLESS:${HEADLESS:-true}" tests/smoke
fi

exec "$@"
