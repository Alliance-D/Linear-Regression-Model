# main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import pandas as pd

# Load model and scaler
model = joblib.load('best_co2_model.joblib')
scaler = joblib.load('co2_scaler.joblib')

#  model features 
FEATURES = [
    'Year', 'Population', 'GDP PER CAPITA (USD)', 'GDP PER CAPITA PPP (USD)', 'Transportation (Mt)',
    'Other Fuel Combustion (Mt)', 'Manufacturing/Construction (Mt)', 'Land-Use Change and Forestry (Mt)',
    'Industrial Processes (Mt)', 'Fugitive Emissions (Mt)', 'Energy (Mt)', 'Electricity/Heat (Mt)',
    'Bunker Fuels (Mt)', 'Building (Mt)'
]

# Pydantic input model with constraints 
class CO2Input(BaseModel):
    Year: int = Field(..., ge=1990, le=2100)
    Population: int = Field(..., ge=0, le=2_000_000_000)
    GDP_PER_CAPITA_USD: float = Field(..., ge=0, le=200_000)
    GDP_PER_CAPITA_PPP_USD: float = Field(..., ge=0, le=200_000)
    Transportation_Mt: float = Field(..., ge=0, le=10_000)
    Other_Fuel_Combustion_Mt: float = Field(..., ge=0, le=10_000)
    Manufacturing_Construction_Mt: float = Field(..., ge=0, le=10_000)
    Land_Use_Change_and_Forestry_Mt: float = Field(..., ge=-10_000, le=10_000)
    Industrial_Processes_Mt: float = Field(..., ge=0, le=10_000)
    Fugitive_Emissions_Mt: float = Field(..., ge=0, le=10_000)
    Energy_Mt: float = Field(..., ge=0, le=10_000)
    Electricity_Heat_Mt: float = Field(..., ge=0, le=10_000)
    Bunker_Fuels_Mt: float = Field(..., ge=0, le=10_000)
    Building_Mt: float = Field(..., ge=0, le=10_000)

app = FastAPI(
    title="CO2 Emission Predictor API",
    description="Predicts total CO2 emissions excluding LUCF (Mt) for African countries.",
    version="1.0"
)

# Add CORS middleware for all origins
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],   
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/predict")
def predict_co2(data: CO2Input):
    # Map the input data to the order of FEATURES
    input_data = [
        data.Year,
        data.Population,
        data.GDP_PER_CAPITA_USD,
        data.GDP_PER_CAPITA_PPP_USD,
        data.Transportation_Mt,
        data.Other_Fuel_Combustion_Mt,
        data.Manufacturing_Construction_Mt,
        data.Land_Use_Change_and_Forestry_Mt,
        data.Industrial_Processes_Mt,
        data.Fugitive_Emissions_Mt,
        data.Energy_Mt,
        data.Electricity_Heat_Mt,
        data.Bunker_Fuels_Mt,
        data.Building_Mt
    ]
    # Make prediction
    X = pd.DataFrame([input_data], columns=FEATURES)
    X_scaled = scaler.transform(X)
    prediction = model.predict(X_scaled)
    return {"predicted_CO2_emission_Mt": float(prediction[0])}
