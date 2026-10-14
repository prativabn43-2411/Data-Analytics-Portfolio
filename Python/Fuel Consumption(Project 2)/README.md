# 🚗 Vehicle Fuel Consumption & CO₂ Emissions Analysis

## 📌 Project Overview

This project analyzes vehicle fuel consumption, fuel efficiency, and carbon dioxide (CO₂) emissions using Python. The goal is to understand how vehicle characteristics, fuel types, and manufacturers relate to fuel economy and environmental impact.

Using Exploratory Data Analysis (EDA), data aggregation, visualization, and correlation analysis, this project identifies patterns that can help explain differences in fuel consumption and emissions across vehicle categories.

## 🎯 Project Objectives

- Analyze fuel efficiency across different vehicle classes.
- Investigate the impact of fuel types on fuel consumption and CO₂ emissions.
- Compare manufacturers based on average emissions and engine size.
- Identify relationships between engine size, cylinder count, fuel consumption, and CO₂ emissions.
- Detect potential multicollinearity among numerical variables using a correlation heatmap.
- Present insights through clear and informative visualizations.

## 📂 Dataset Description

**Dataset:** `FuelConsumption.csv`

The dataset contains vehicle specifications, fuel consumption measurements, and CO₂ emissions.

### Key Columns

| Column | Description |
|---|---|
| `MAKE` | Vehicle manufacturer |
| `MODEL` | Vehicle model |
| `VEHICLECLASS` | Vehicle category |
| `ENGINESIZE` | Engine displacement in litres |
| `CYLINDERS` | Number of engine cylinders |
| `FUELTYPE` | Fuel type |
| `FUELCONSUMPTION_CITY` | Fuel consumption during city driving |
| `FUELCONSUMPTION_HWY` | Fuel consumption during highway driving |
| `FUELCONSUMPTION_COMB` | Combined fuel consumption in L/100 km |
| `FUELCONSUMPTION_COMB_MPG` | Combined fuel efficiency in miles per gallon |
| `CO2EMISSIONS` | Carbon dioxide emissions in g/km |

## 🛠️ Tools & Technologies

- **Python** — Data analysis and programming
- **Pandas** — Data manipulation and aggregation
- **NumPy** — Numerical operations
- **Matplotlib** — Data visualization
- **Seaborn** — Statistical visualization
- **Jupyter Notebook** — Interactive analysis environment

## 🔍 Project Analysis

### 1. Fuel Efficiency Across Vehicle Classes

- Grouped vehicles by `VEHICLECLASS`.
- Calculated average combined MPG and fuel consumption.
- Identified the most and least fuel-efficient vehicle classes.
- Created bar charts to compare fuel efficiency.

### 2. Impact of Fuel Type

- Grouped vehicles by `FUELTYPE`.
- Compared average CO₂ emissions and combined fuel consumption.
- Analyzed average MPG for different fuel types.
- Ranked fuel types by emissions and fuel economy.

### 3. Manufacturer/Make Analysis

- Grouped vehicles by `MAKE
