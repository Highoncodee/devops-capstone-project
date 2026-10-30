# Use a lightweight Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Prevent Python from writing bytecode and enable unbuffered logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PORT=8080

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY . .

# Expose application port
EXPOSE 8080

# Start the Customer Accounts service using Gunicorn
CMD ["sh", "-c", "gunicorn --workers=1 --bind 0.0.0.0:${PORT} --log-level=info service:app"]
