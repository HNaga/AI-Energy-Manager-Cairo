# AI Energy Simulation لشقة 100م² في القاهرة

## التشغيل:
1. docker build -t ai-energy .
2. docker run -p 8501:8501 ai-energy

## تطوير:
- أضف بيانات طقس حقيقية من energyplus.net.
- تدريب النموذج: python model.py
- مشاهدة: localhost:8501

متوسط التوفير: 28% (بناءً على OpenEMS وEnergym).
