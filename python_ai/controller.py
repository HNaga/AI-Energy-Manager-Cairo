import joblib
import numpy as np

model = joblib.load('energy_model.pkl')

def ai_controller(temp, hour, solar, battery_soc, price):
    load_pred = model.predict([[temp, hour, 0]])[0]  # تنبؤ الاستهلاك
    
    if solar > load_pred * 1.2 and battery_soc < 0.9:
        return "شحن البطارية من الشمس"
    elif price < 1.5 and battery_soc > 0.3:  # سعر منخفض (جنيه/كيلو)
        return "استخدام الشبكة + تفريغ البطارية"
    else:
        return "استخدام البطارية + الشمس"

# مثال
action = ai_controller(35, 14, 800, 0.6, 2.1)
print(f"القرار: {action}")
