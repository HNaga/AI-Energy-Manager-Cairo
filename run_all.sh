
cd ~/AI-Energy-Manager-Cairo
rm -rf venv

python3 -m venv venv
source venv/bin/activate

pip install --upgrade pip


sudo apt update
sudo apt install python3-numpy python3-pandas -y


grep -v -E "numpy|pandas" requirements.txt > requirements_temp.txt

pip install -r requirements_temp.txt


pip install numpy pandas --no-deps

pip install streamlit scikit-learn joblib matplotlib --quiet


python -c "import streamlit, pandas, numpy, sklearn, joblib, matplotlib; "
