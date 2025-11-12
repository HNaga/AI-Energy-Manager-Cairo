#!/bin/bash
# بناء السيميوليشن
python3 python_ai/model.py
# تشغيل EnergyPlus (افترض IDF جاهز)
energyplus -w energyplus_simulation/Cairo.epw building_model/Cairo_Home_100m2.idf
# شغّل اللوحة
streamlit run python_ai/app.py
