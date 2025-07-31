FROM python:3.10-slim

# Install Tesseract
RUN apt-get update && \
    apt-get install -y tesseract-ocr libtesseract-dev libleptonica-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy code
COPY . /app

# Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose port (Render uses 0.0.0.0:$PORT)
EXPOSE 8000

# Start app with gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]
