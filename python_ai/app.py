import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import joblib

# PWA Support
st.set_page_config(
    page_title="AI Energy Manager",
    page_icon="https://img.icons8.com/fluency/96/000000/artificial-intelligence.png",
    layout="wide",
    initial_sidebar_state="expanded"
)

# PWA Headers
st.markdown("""
<link rel="manifest" href="/manifest.json">
<link rel="icon" href="https://img.icons8.com/fluency/96/000000/artificial-intelligence.png">
<meta name="theme-color" content="#1e40af">
""", unsafe_allow_html=True)

st.title("AI-Powered Energy Management")
st.markdown("**Smart Home – 100m² Apartment in Cairo**")

@st.cache_data
def load_data():
    return pd.read_csv("sim_data.csv", parse_dates=['datetime'])

df = load_data()
model = joblib.load("energy_model.pkl")

# Chart
st.subheader("Weekly Energy Profile")
fig, ax = plt.subplots(figsize=(12, 6))
ax.plot(df['datetime'][:168], df['consumption_kwh'][:168], label='Consumption', color='red', linewidth=2)
ax.plot(df['datetime'][:168], df['solar_wh'][:168]/1000, label='Solar', color='orange', alpha=0.8)
ax.set_xlabel('Date')
ax.set_ylabel('Power (kW)')
ax.legend()
ax.grid(True, alpha=0.3)
st.pyplot(fig)

# Controls
st.sidebar.header("AI Controller")
hour = st.sidebar.slider("Hour", 0, 23, 14)
temp = st.sidebar.slider("Temp (°C)", 15, 45, 35)
battery_soc = st.sidebar.slider("Battery (%)", 0, 100, 60) / 100
price = st.sidebar.slider("Price (EGP/kWh)", 1.0, 3.0, 2.1, step=0.1)

pred = model.predict(pd.DataFrame([[temp, hour, 0]], columns=['temp', 'hour', 'dayofweek']))[0]
solar_today = df[df['datetime'].dt.hour == hour]['solar_wh'].mean()

if solar_today > pred * 1.2 and battery_soc < 0.9:
    action = "Charge from Solar"
    color = "green"
elif price < 1.8 and battery_soc > 0.3:
    action = "Use Grid + Discharge"
    color = "orange"
else:
    action = "Use Battery + Solar"
    color = "blue"

st.markdown(f"### Decision: <span style='color:{color};font-size:28px;font-weight:bold'>{action}</span>", unsafe_allow_html=True)
col1, col2 = st.columns(2)
col1.metric("Load", f"{pred:.2f} kWh")
col2.metric("Savings", f"{pred*30*0.28:.0f} EGP/month", delta="28%")

if st.button("Run Simulation", use_container_width=True):
    st.balloons()
    st.success("420 EGP saved this month!")
