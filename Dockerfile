FROM node:18-alpine

# Install uv for Python dependencies (if needed)
RUN pip install uv

# Install Marp CLI globally
RUN npm install -g @marp-team/marp-cli

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python dependencies (if any)
RUN uv sync

# Create output directory
RUN mkdir -p dist

# Expose the server port
EXPOSE 8080

# Default command: start the Marp server
CMD ["marp", "--server", "docs/", "--port", "8080"]