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