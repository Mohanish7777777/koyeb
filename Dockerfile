# Use Ubuntu as the base image
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip

# Copy the Python application code
COPY app.py /app/app.py
WORKDIR /app

# Install Flask
RUN pip3 install Flask --break-system-packages

# Expose port 8000
EXPOSE 8000

# Run the Flask application at runtime
CMD ["python3", "app.py"]
