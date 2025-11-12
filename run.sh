echo "AI Energy Manager"
echo "افتح المتصفح: http://localhost:8501"
echo "من الموبايل: http://$(hostname -I | awk '{print $1}'):8501"
streamlit run python_ai/app.py --server.port=8501 --server.address=0.0.0.0
