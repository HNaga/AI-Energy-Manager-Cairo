# استخدم صورة EnergyPlus الرسمية الجاهزة (أحدث إصدار تلقائي)
FROM nrel/energyplus:latest

# تثبيت Python و pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# إعداد مجلد العمل
WORKDIR /app

# نسخ ملفات المشروع
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# نسخ باقي الكود
COPY . .

# تشغيل Streamlit
EXPOSE 8501
CMD ["streamlit", "run", "python_ai/app.py", "--server.port=8501", "--server.address=0.0.0.0"]
