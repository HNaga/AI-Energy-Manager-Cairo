import joblib
import numpy as np

model = joblib.load('python_ai/energy_model.pkl')

def ai_controller(temp, hour, solar, battery_soc, price):
    load_pred = model.predict([[temp, hour, 0]])[0]  # consumption prediction
    
    if solar > load_pred * 1.2 and battery_soc < 0.9:
        return "Charge battery from solar"
    elif price < 1.5 and battery_soc > 0.3:  # low price (EGP/kWh)
        return "Use grid + discharge battery"
    else:
        return "Use battery + solar"

# مثال
action = ai_controller(35, 14, 800, 0.6, 2.1)
print(f"القرار: {action}")
