#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

echo "Cleaning up old containers and processes..."
docker ps --format '{{.ID}} {{.Ports}}' | awk '/8501->/ {print $1}' | xargs -r docker stop 2>/dev/null || true
lsof -i :8501 | grep python | awk '{print $2}' | xargs kill -9 2>/dev/null || true



if [ ! -d venv ]; then
  python3 -m venv venv
fi
source venv/bin/activate

if ! python -c "import streamlit" >/dev/null 2>&1; then
  pip install -r requirements.txt --quiet
fi

if [ ! -f python_ai/energy_model.pkl ] || [ ! -f python_ai/sim_data.csv ]; then
  python python_ai/model.py
fi

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
