
This project provides a simple, mobile tool to predict CO₂ emissions for African countries using real local data. The goal is to support climate action and planning by making emissions modeling easy for everyone.

## Mission and Problem;

My mission is to make CO₂ emissions prediction and reduction planning easy and accessible for Africa, using real local data.
Many existing tools are too complex or not tailored for African needs, making climate action difficult.
This app bridges the gap by offering simple, insightful predictions and actionable guidance for everyone.

## Public API Endpoint

# Swagger UI docs; 

https://linear-regression-model-38av.onrender.com/docs

# Predict endpoint;
POST /predict

'https://linear-regression-model-38av.onrender.com/predict'

## How itp works;

1. # API: 
   A FastAPI app predicts total CO₂ emissions based on user inputs. Users can provide all available data for higher accuracy.
 
   The Flutter app collects user data, sends it to the API, and displays the predicted emissions.

2. # Model:

- Uses a trained machine learning regression model (Random Forest/Linear Regression).
- All the necessary inputs are needed to maintain the accuracy
- Model trained and tested on African data.

2. # Mobile App:

## running the app

- clone the repo
- make sure you have flutter installed
- run 'flutter pub get' to make sure you have the necessary requirements.
- run 'cd summative/API' and then 'pip install -r requirements.txt' to make sure you have the necessary requirements for the api&model.
- run the app (you can use debug or use 'flutter run')

## Usage

- Enter values in the input fields.
- Tap “Predict” to get your CO₂ emission forecast.
- See tailored prediction.

## How to Run Locally

# API
```bash
cd path/to/API
pip install -r requirements.txt
uvicorn prediction:app --reload

```
## author
Alliance Dushime
a.dushimezi@alustudent.com

Source of the dataset;

Kaggle: https://www.kaggle.com/datasets/ngaruniki/co2-emission-in-africa/data


