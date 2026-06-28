
CC = clang
CFLAGS = -std=c99 -O3 -Wall -Wextra
TARGET = helper
SOURCES = helper.c
HEADERS = cpu.h sketchybar.h

# Default target
all: $(TARGET)

# Build the helper binary
$(TARGET): $(SOURCES) $(HEADERS)
	@echo "Compiling $(TARGET)..."
	$(CC) $(CFLAGS) $(SOURCES) -o $(TARGET)
	@echo "Compilation successful!"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -f $(TARGET)
	@echo "Clean complete!"

# Rebuild from scratch
rebuild: clean all

# Check if all dependencies are available
check:
	@echo "Checking dependencies..."
	@which $(CC) >/dev/null || (echo "Error: $(CC) not found" && exit 1)
	@echo "Dependencies OK!"

# Install (copy to a system location if needed)
install: $(TARGET)
	@echo "Helper binary is ready at: $(PWD)/$(TARGET)"

.PHONY: all clean rebuild check install
