# Claude Guide

A comprehensive guide and best practices for using Claude Code effectively. This project contains documentation, examples, and resources for maximizing productivity with Claude Code.

## Project Structure

- `docs/` - Documentation and guides
- `examples/` - Code examples and patterns
- `.claude/` - Claude Code configuration and custom commands

## Getting Started

This project is designed to be used with Claude Code. The documentation covers:

- Best practices for prompting
- Custom commands and workflows
- Project organization strategies
- Advanced techniques and patterns

## Development

This project uses Python for development tooling and examples.

```bash
# Install dependencies with uv
uv sync

# Run development tools
uv run python main.py
```

## Presentation Setup

This project includes a presentation about Claude Code best practices using Marp.

### Install Marp CLI

```bash
# Install Marp CLI via npm
npm install -g @marp-team/marp-cli
```

### Serve the Presentation

```bash
# Start preview server (slides as presentation, other files as pages)
marp --server docs/

# Or export to HTML for sharing
marp --html docs/claude-best-practices-slides.md -o slides.html

# Export to PDF
marp --pdf docs/claude-best-practices-slides.md -o slides.pdf
```

### How it works

When you run the Marp server:
- **`claude-best-practices-slides.md`** → Rendered as slide presentation at `http://localhost:8080/claude-best-practices-slides.html`
- **Other `.md` files** → Rendered as regular scrollable web pages

### Quick start commands

```bash
# Live preview with hot reload
marp --server docs/ -w

# Convert to PowerPoint
marp --pptx docs/claude-best-practices-slides.md -o slides.pptx
```

### Using the provided script

```bash
# Use the serve script for convenience
./serve.sh server   # Start live server
./serve.sh watch    # Start server with auto-reload
./serve.sh html     # Export to HTML
./serve.sh pdf      # Export to PDF
```

## Docker/Podman Setup

You can run the Marp server in a container using Docker or Podman.

### Building the container

```bash
# Using Docker
docker build -t claude-guide-marp .

# Using Podman
podman build -t claude-guide-marp .
```

### Running the container

```bash
# Using Docker
docker run -p 8080:8080 -v $(pwd)/docs:/app/docs claude-guide-marp

# Using Podman
podman run -p 8080:8080 -v $(pwd)/docs:/app/docs claude-guide-marp
```

### Using Docker Compose

```bash
# Start the server (without auto-reload)
docker compose up marp-server

# Start with auto-reload
docker compose --profile watch up marp-watch

# Run in background
docker compose up -d marp-server

# Stop the server
docker compose down
```

### Using Podman Compose

```bash
# Install podman-compose if not already installed
pip install podman-compose

# Start the server (without auto-reload)
podman compose up marp-server

# Start with auto-reload
podman compose --profile watch up marp-watch

# Run in background
podman compose up -d marp-server

# Stop the server
podman compose down
```

### Container access

Once the container is running, access your slides at:
- **Slides**: http://localhost:8080/claude-best-practices-slides.html
- **Presenter view**: http://localhost:8080/claude-best-practices-slides.html?present=true
- **Other docs**: Any other markdown files in `docs/` will be available as web pages

### Volume mounting

The container mounts the `docs/` directory, so any changes to your markdown files will be reflected immediately (use the watch profile for auto-reload). The `dist/` directory is also mounted for any exported files.