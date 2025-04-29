#!/bin/bash

echo "📦 Setting up the virtual environment..."
python3 -m venv .venv
source .venv/bin/activate

echo "⬇️ Installing dependencies..."
pip install -r requirements.txt

echo "🚀 Running Streamlit app..."
streamlit run london_map_app.py