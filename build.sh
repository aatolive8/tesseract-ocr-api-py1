#!/bin/bash

echo "🔧 Installing Tesseract OCR and system libraries..."

apt-get update && apt-get install -y \
  tesseract-ocr \
  libtesseract-dev \
  libleptonica-dev \
  libjpeg-dev \
  zlib1g-dev \
  libpng-dev \
  build-essential \
  gcc

echo "✅ Tesseract version:"
tesseract --version

# Install Python requirements
pip install --upgrade pip
pip install -r requirements.txt
