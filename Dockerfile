# Use Ubuntu as the base image
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    python3-venv

# Download the script and make it executable
RUN curl -sSf https://sshx.io/get -o /sshx_script.sh && chmod +x /sshx_script.sh

# Copy the Python application code
COPY app.py /app/app.py
WORKDIR /app

# Create a virtual environment and install Flask
RUN python3 -m venv /app/venv && \
    . /app/venv/bin/activate && \
    pip install Flask

# Expose port 8000
EXPOSE 8000

# Run the Flask application in the virtual environment
CMD ["/app/venv/bin/python", "app.py"]
