#!/bin/bash

# Install Tesseract OCR
apt-get update && apt-get install -y tesseract-ocr

# Continue with normal pip install
pip install -r requirements.txt
