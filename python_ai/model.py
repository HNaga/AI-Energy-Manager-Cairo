import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestRegressor
import joblib

np.random.seed(42)
hours = pd.date_range('2025-01-01', periods=8760, freq='H')
temp = 25 + 15 * np.sin(2*np.pi*(hours.hour + hours.dayofyear*24)/8760) + np.random.normal(0, 3, 8760)
solar = np.where((hours.hour >= 6) & (hours.hour <= 18), 
                 800 * np.sin(np.pi*(hours.hour-6)/12)**2, 0) + np.random.normal(0, 50, 8760)

base_load = 0.8
ac_load = np.where(temp > 28, 2.5 * (temp-28)/10, 0)
light_load = np.where((hours.hour >= 18) | (hours.hour <= 6), 0.4, 0.1)
consumption = base_load + ac_load + light_load + np.random.normal(0, 0.2, 8760)

df = pd.DataFrame({
    'datetime': hours,
    'temp': temp,
    'solar_wh': solar,
    'consumption_kwh': consumption
})
df['hour'] = df['datetime'].dt.hour
df['dayofweek'] = df['datetime'].dt.dayofweek

X = df[['temp', 'hour', 'dayofweek']]
y = df['consumption_kwh']
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X, y)

print(f"R² Score: {model.score(X, y):.4f}")

joblib.dump(model, 'energy_model.pkl')
df.to_csv('sim_data.csv', index=False)
print("Model and data saved successfully!")
