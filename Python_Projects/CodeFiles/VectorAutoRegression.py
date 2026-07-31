#VectorAutoRegression

#Step 1: Importing necessary libraries

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from statsmodels.tsa.api import VAR
from statsmodels.tsa.stattools import adfuller

#Step 2: Generate Sample Data

# Sample data generation
np.random.seed(0)
dates = pd.date_range(start='2024-01-01', periods=100)
data = pd.DataFrame(np.random.randn(100, 3), index=dates, columns=['A', 'B', 'C'])
print(data)
input()

#Step 3: Function to plot time series

# Function to plot time series
def plot_series(data):
    fig, axes = plt.subplots(nrows=3, ncols=1, figsize=(10, 8))
    for i, col in enumerate(data.columns):
        data[col].plot(ax=axes[i], title=col)
        axes[i].set_ylabel('Values')
        axes[i].set_xlabel('Date')
    plt.tight_layout()
    plt.show()
    
plot_series(data)

#Step 4: Function to check stationarity

# Check stationarity of time series using ADF test
def check_stationarity(timeseries):
    result = adfuller(timeseries)
    print('ADF Statistic:', result[0])
    print(f'p-value: {result[1]:.16f}')
    print('Critical Values:')
    for key, value in result[4].items():
        print('\t%s: %.3f' % (key, value))


#Step 5: VAR analysis

# Section for VAR analysis
def var_analysis(data):
    # Step 1: Check stationarity and visualize the original data
    print("Step 1: Checking stationarity")
    for col in data.columns:
        print('Stationarity test for', col)
        check_stationarity(data[col])

    # Step 2: Applying VAR model
    print("\nStep 2: Applying VAR model")
    model = VAR(data)
    results = model.fit()

    # Step 3: Forecasting
    print("\nStep 3: Forecasting")
    lag_order = results.k_ar
    forecast = results.forecast(data.values[-lag_order:], steps=10)

    # Step 4: Visualizing forecast
    print("\nStep 4: Visualizing forecast")
    forecast_index = pd.date_range(start='2024-04-11', periods=10)
    forecast_data = pd.DataFrame(forecast, index=forecast_index, columns=data.columns)
    #plot_series(pd.concat([data, forecast_data]))
    # print(data.dtypes)
    # input()

    plt.figure(figsize=(10,8))
    plt.subplot(3,1,1)
    plt.plot(data.index, data["A"], label="Sales Actual")
    plt.plot(forecast_data.index, forecast_data["A"], label="Sales Forecast")
    plt.legend()
    plt.show()

# Perform VAR analysis
var_analysis(data)