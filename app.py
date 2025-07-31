from flask import Flask, request, jsonify
import pytesseract
from PIL import Image
import requests
from io import BytesIO

app = Flask(__name__)

@app.route("/")
def index():
    return "Tesseract OCR API is running"

@app.route("/ocr", methods=["POST"])
def ocr():
    try:
        data = request.get_json()
        image_url = data.get("image_url")
        lang = data.get("lang", "eng")
        psm = data.get("psm", 6)

        if not image_url:
            return jsonify({"error": "Image URL is required."}), 400

        # Download the image
        response = requests.get(image_url)
        if response.status_code != 200:
            return jsonify({"error": "Failed to download image."}), 400

        image = Image.open(BytesIO(response.content))

        # Tesseract configuration
        config = f'--psm {psm}'

        # OCR extraction
        text = pytesseract.image_to_string(image, lang=lang, config=config)

        return jsonify({"text": text.strip()})

    except Exception as e:
        return jsonify({"error": str(e)}), 500
