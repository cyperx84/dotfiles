#!/usr/bin/env bash

# Smart session starter - detects project type and runs appropriate command
# Used by sesh to intelligently start sessions based on project context

SESSION_PATH="$1"
SESSION_NAME="$2"

# Expand tilde in path
SESSION_PATH="${SESSION_PATH/#\~/$HOME}"

# Change to session directory
cd "$SESSION_PATH" 2>/dev/null || exit 1

# Detect project type and run appropriate command
detect_and_start() {
    # Node.js project
    if [ -f "package.json" ]; then
        # Check for common dev scripts
        if grep -q '"dev"' package.json 2>/dev/null; then
            echo "🚀 Node.js project detected - running npm run dev"
            npm run dev
        elif grep -q '"start"' package.json 2>/dev/null; then
            echo "🚀 Node.js project detected - running npm start"
            npm start
        else
            echo "📝 Node.js project - opening editor"
            nvim .
        fi
        return
    fi

    # Rust project
    if [ -f "Cargo.toml" ]; then
        # Check if cargo-watch is available
        if command -v cargo-watch &>/dev/null; then
            echo "🦀 Rust project detected - running cargo watch"
            cargo watch -x run
        else
            echo "🦀 Rust project - opening editor"
            nvim .
        fi
        return
    fi

    # Python project
    if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
        # Activate venv if present
        if [ -d "venv" ]; then
            echo "🐍 Python project detected - activating venv"
            source venv/bin/activate
        elif [ -d ".venv" ]; then
            echo "🐍 Python project detected - activating .venv"
            source .venv/bin/activate
        fi

        # Check for common entry points
        if [ -f "main.py" ]; then
            echo "🐍 Running main.py"
            python main.py
        elif [ -f "app.py" ]; then
            echo "🐍 Running app.py"
            python app.py
        else
            echo "🐍 Python project - opening editor"
            nvim .
        fi
        return
    fi

    # Go project
    if [ -f "go.mod" ]; then
        # Check for main.go
        if [ -f "main.go" ]; then
            echo "🐹 Go project detected - running go run"
            go run main.go
        else
            echo "🐹 Go project - opening editor"
            nvim .
        fi
        return
    fi

    # Docker Compose project
    if [ -f "docker-compose.yml" ] || [ -f "docker-compose.yaml" ]; then
        echo "🐳 Docker Compose project detected - running docker compose up"
        docker compose up
        return
    fi

    # Makefile project
    if [ -f "Makefile" ]; then
        # Check for common targets
        if grep -q "^dev:" Makefile 2>/dev/null; then
            echo "🔨 Makefile detected - running make dev"
            make dev
        elif grep -q "^run:" Makefile 2>/dev/null; then
            echo "🔨 Makefile detected - running make run"
            make run
        else
            echo "🔨 Makefile project - opening editor"
            nvim .
        fi
        return
    fi

    # Default: just open neovim
    echo "📝 Opening editor in: $SESSION_PATH"
    nvim .
}

# Run detection and start
detect_and_start
