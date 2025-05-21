# Detect architecture and set Homebrew path
if [ "$(uname -m)" = "arm64" ]; then
    # Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Run Message of the Day script
[ -x "$HOME/motd.sh" ] && "$HOME/motd.sh"
