
#Forecast_Sales_Consumption

#Step 1: Source Data Preparation

import pandas as pd
import numpy as np
import SourceData

#df = pd.read_csv("your_data.csv", parse_dates=["date"])
df=SourceData.df_DFUwise_Monthwise2
df = df.sort_values("MonthEndDate")
df.set_index("MonthEndDate", inplace=True)

# Keep only numeric series
data = df[["DeliveryQty", "ProdQty"]]
#print(data)


#Step 2: Check Stationarity & Difference If Needed

from statsmodels.tsa.stattools import adfuller

def adf_test(series):
    result = adfuller(series)
    print(f"ADF Statistic: {result[0]}, p-value: {result[1]}")

adf_test(data['DeliveryQty'])
adf_test(data['ProdQty'])

#If p-value > 0.05, difference once:
data_diff = data.diff().dropna()

#Step 3: Fit the VAR Model
from statsmodels.tsa.api import VAR

model = VAR(data_diff)
lag_results = model.select_order(maxlags=15)
print(lag_results.summary())

results = model.fit(lag_results.selected_orders["aic"])
print(results.summary())


#Step 4: Forecasting
#Step 4.1 One-Step Forecast

forecast_input = data_diff.values[-results.k_ar:]
forecast = results.forecast(y=forecast_input, steps=1)
print("1-step forecast:", forecast)


#Step 4.2: Multi-Step Forecast (example: next 12 days)
steps = 12
forecast = results.forecast(y=data_diff.values[-results.k_ar:], steps=steps)

# Convert to DataFrame
import numpy as np

forecast_df = pd.DataFrame(forecast,
                           columns=["DeliveryQty_diff_forecast", "ProdQty_diff_forecast"],
                           index=pd.date_range(df.index[-1] + pd.Timedelta(days=1), periods=steps))


#Step 5: Convert Differenced Forecast Back to Original Scale
last_actual = data.iloc[-1]

forecast_df["DeliveryQty_forecast"] = last_actual["DeliveryQty"] + forecast_df["DeliveryQty_diff_forecast"].cumsum()
forecast_df["ProdQty_forecast"] = last_actual["ProdQty"] + forecast_df["ProdQty_diff_forecast"].cumsum()


#Step 6: Plot Forecast

import matplotlib.pyplot as plt

plt.figure(figsize=(12,6))
plt.subplot(2,1,1)
plt.plot(df.index, df["DeliveryQty"], label="Sales Actual")
plt.plot(forecast_df.index, forecast_df["DeliveryQty_forecast"], label="Sales Forecast")
plt.legend()

plt.subplot(2,1,2)
plt.plot(df.index, df["ProdQty"], label="Consumption Actual")
plt.plot(forecast_df.index, forecast_df["ProdQty_forecast"], label="Consumption Forecast")
plt.legend()
plt.show()



