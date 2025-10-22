#!/bin/bash

# Slide serving script for Claude Code presentation
# Usage: ./serve.sh [html|pdf|server|watch]

set -e

SLIDE_FILE="docs/claude-best-practices-slides.md"
OUTPUT_DIR="dist"

MODE=${1:-server}

case $MODE in
    "html")
        echo "🚀 Exporting slides to HTML..."
        mkdir -p $OUTPUT_DIR
        marp --html $SLIDE_FILE -o $OUTPUT_DIR/slides.html
        echo "✅ Slides exported to $OUTPUT_DIR/slides.html"
        echo "🌐 Open with: open $OUTPUT_DIR/slides.html"
        ;;
    "pdf")
        echo "🚀 Exporting slides to PDF..."
        mkdir -p $OUTPUT_DIR
        marp --pdf $SLIDE_FILE -o $OUTPUT_DIR/slides.pdf
        echo "✅ Slides exported to $OUTPUT_DIR/slides.pdf"
        echo "📄 Open with: open $OUTPUT_DIR/slides.pdf"
        ;;
    "server")
        echo "🚀 Starting Marp live server..."
        echo "🌐 Slides will be available at http://localhost:8080/claude-best-practices-slides.html"
        echo "🎯 Presenter view: Add ?present=true to the URL for presenter mode"
        echo "📄 Other markdown files will be available as scrollable pages"
        echo "⏹️  Press Ctrl+C to stop the server"
        marp --server docs/ --port 8080
        ;;
    "watch")
        echo "🚀 Starting Marp in watch mode..."
        echo "🌐 Slides will be available at http://localhost:8080/claude-best-practices-slides.html"
        echo "🎯 Presenter view: Add ?present=true to the URL for presenter mode"
        echo "📄 Other markdown files will be available as scrollable pages"
        echo "🔄 Auto-reload enabled - changes to markdown will refresh slides"
        echo "⏹️  Press Ctrl+C to stop"
        marp --server docs/ --port 8080 --watch
        ;;
    *)
        echo "❌ Invalid mode: $MODE"
        echo "Usage: $0 [html|pdf|server|watch]"
        echo ""
        echo "Modes:"
        echo "  server - Start live preview server (default)"
        echo "  watch  - Start server with auto-reload"
        echo "  html   - Export to HTML file"
        echo "  pdf    - Export to PDF file"
        exit 1
        ;;
esac