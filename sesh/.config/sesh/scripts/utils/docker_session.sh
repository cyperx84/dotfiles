#!/usr/bin/env bash
# Docker session: start colima, wait for docker daemon, then launch lazydocker

# Start colima with recovery logic, wait for docker, then run lazydocker
tmux send-keys '
start_colima() {
    if colima status &>/dev/null; then
        echo "✓ Colima already running"
        return 0
    fi
    echo "Starting colima..."
    if colima start 2>&1; then
        return 0
    fi
    echo "⚠ Start failed, attempting recovery..."
    colima delete --force 2>/dev/null
    colima start
}

wait_for_docker() {
    echo "Waiting for docker daemon..."
    local max_attempts=30
    local attempt=0
    while ! docker info &>/dev/null; do
        attempt=$((attempt + 1))
        if [ $attempt -ge $max_attempts ]; then
            echo "✗ Docker daemon not ready after ${max_attempts}s"
            return 1
        fi
        sleep 1
    done
    echo "✓ Docker daemon ready"
    return 0
}

start_colima && wait_for_docker && lazydocker
' Enter
