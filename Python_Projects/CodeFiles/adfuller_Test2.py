import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.stattools import adfuller

# 1. Load a real-world time series (airline passengers)
url = "https://raw.githubusercontent.com/jbrownlee/Datasets/master/airline-passengers.csv"
data = pd.read_csv(url, parse_dates=['Month'], index_col='Month')
ts = data['Passengers'].astype(float)
print(type(data))
print(type(ts))
print("data :\n",data)
print("ts : \n",ts)

# Optional: visualize
ts.plot(title='Monthly Airline Passengers (1949–1960)')
plt.show()

# 2. Define helper to run ADF test
def adf_test(series, autolag='AIC', regression='c'):
    result = adfuller(series, autolag=autolag, regression=regression)
    #print("Result : \n",result)
    output = pd.Series(result[0:4], 
                       index=['ADF Test Statistic', 'p-value', 'Lags Used', 'No of Observations'])
    for key, val in result[4].items():
        output[f'Critical Value ({key})'] = val
    output2=pd.Series(result[5:6], index=['Max Information Criterion'])
    output=pd.concat([output,output2])
    return output

# 3. Run ADF on original series
print("=== Original Series ===")
print(adf_test(ts))

# 4. Transform: log and first difference (remove trend/variance issues)
ts_log = np.log(ts)
ts_diff = ts_log.diff().dropna()

print("\n=== Log‑diff Transformed Series ===")
print(adf_test(ts_diff))

# 5. Interpretation:
# If original series has p‑value > 0.05 and larger test statistic than critical,
# it’s non‑stationary. After log/diff, p-value should drop below 0.05 and
# statistic should fall under critical — meaning stationarity achieved.
