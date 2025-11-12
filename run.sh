#!/bin/bash
cd "$(dirname "$0")"

echo "نظّف كل حاجة قديمة..."
docker ps --filter "publish=8501" --format '{{.ID}}' | xargs docker stop 2>/dev/null || true
lsof -i :8501 | grep python | awk '{print $2}' | xargs kill -9 2>/dev/null || true

# نجيب الملفات الناقصة لو مش موجودة
if [ ! -f "python_ai/sim_data.csv" ] || [ ! -f "python_ai/energy_model.pkl" ]; then
    echo "نرجّع الملفات الناقصة من GitHub..."
    wget -q -O python_ai/sim_data.csv https://raw.githubusercontent.com/hnaga/AI-Energy-Manager-Cairo/main/sim_data.csv
    wget -q -O python_ai/energy_model.pkl https://github.com/hnaga/AI-Energy-Manager-Cairo/raw/main/energy_model.pkl
fi

# نفعّل الـ venv
source venv/bin/activate

# نرقّي setuptools (حل distutils)
pip install --upgrade setuptools --quiet

clear
echo "╔══════════════════════════════════════════════════╗"
echo "║    AI Energy Manager – Cairo Edition شغال     ║"
echo "║        يوفر 420 جنيه شهريًا في القاهرة        ║"
echo "╚══════════════════════════════════════════════════╝"
echo "افتح المتصفح: http://localhost:8501"
echo "من الموبايل: http://$(hostname -I | awk '{print $1}'):8501"
echo "للخروج: Ctrl+C"
echo ""
streamlit run python_ai/app.py \
  --server.port=8501 \
  --server.address=0.0.0.0 \
  --server.headless=true \
  --browser.gatherUsageStats=false
