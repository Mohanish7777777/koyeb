# Use Ubuntu as the base image
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip

# Download the script and make it executable
RUN curl -sSf https://sshx.io/get -o /sshx_script.sh && chmod +x /sshx_script.sh

# Copy the Python application code
COPY app.py /app/app.py
WORKDIR /app

# Install Flask to serve the output on port 8000
RUN pip3 install Flask

# Expose port 8000
EXPOSE 8000

# Run the Flask application at runtime
CMD ["python3", "app.py"]
