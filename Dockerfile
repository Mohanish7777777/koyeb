# Use the official Ubuntu base image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Run the SSHX command and save the output to index.html
RUN curl -sSf https://sshx.io/get | sh -s run > index.html

# Create a startup script to run the HTTP server
RUN echo 'python3 -m http.server 8000 --directory . &' > /start.sh
RUN chmod +x /start.sh

# Expose port 8000
EXPOSE 8000

# Run the startup script
CMD ["bash", "/start.sh"]
