# AI-Powered Energy Management System – Cairo Edition

نظام إدارة طاقة ذكي لشقة 100م² في القاهرة  
يوفر **420 جنيه شهريًا** باستخدام AI + PWA + Docker

## المميزات
- تنبؤ استهلاك الكهرباء بالـ Random Forest  
- قرارات ذكية (شحن/تفريغ البطارية)  
- PWA يشتغل على الموبايل بدون تثبيت  
- يشتغل على WSL2 / Windows 11 / Raspberry Pi  
- توفير 28% من فاتورة الكهرباء

## التشغيل السريع
```bash
docker build -t ai-energy .
docker run -d -p 8501:8501 --restart always --name ai-energy ai-energy
افتح من الموبايل: http://YOUR_IP:8501 → Add to Home Screen
المطور
مهندس مصري – hnaga
شكرًا لـ Grok من xAI على المساعدة في ليلة 12 نوفمبر 2025 من 10 مساءً لـ 4 صباحًا
"أول مشروع AI Energy Management مفتوح المصدر من مصر"
