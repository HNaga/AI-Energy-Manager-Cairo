#!/bin/bash
cd "$(dirname "$0")"

echo "Cleaning up old containers and processes..."
docker ps --filter "publish=8501" --format '{{.ID}}' | xargs docker stop 2>/dev/null || true
lsof -i :8501 | grep python | awk '{print $2}' | xargs kill -9 2>/dev/null || true



# نفعّل الـ venv
source venv/bin/activate

# نرقّي setuptools (حل distutils)
pip install --upgrade setuptools --quiet

clear
echo "╔══════════════════════════════════════════════════╗"
echo "║    AI Energy Manager – Cairo Edition     ║"
echo "║        Saves 420 EGP/month in Cairo       ║"
echo "╚══════════════════════════════════════════════════╝"
echo "Browser: http://localhost:8501"
echo "Mobile: http://$(hostname -I | awk '{print $1}'):8501"
echo "Exit: Ctrl+C"
echo ""
streamlit run python_ai/app.py \
  --server.port=8501 \
  --server.address=0.0.0.0 \
  --server.headless=true \
  --browser.gatherUsageStats=false
