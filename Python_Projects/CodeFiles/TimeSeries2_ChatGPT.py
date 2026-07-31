import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from statsmodels.tsa.arima.model import ARIMA
from sklearn.metrics import mean_squared_error
from math import sqrt
import statsmodels.api as sm
import MyCalendar

import File1
import Evaluation
# 1. Source Data for Modelling----------------------------------------------------------

#Source1:
# np.random.seed(0)
# dates = pd.date_range(start='2010-01-01', periods=120, freq='ME')
# trend = np.linspace(50, 150, 120)
# season = 10 + 20 * np.sin(np.linspace(0, 2 * np.pi, 120))
# noise = np.random.normal(scale=10, size=120)
# series = pd.Series(trend + season + noise, index=dates)

#print(np.random.seed(10))
#print(dates)
#print(trend)
#print(season)
#print(noise)

#Source2:

data1=File1.df1
data=data1[['MonthEndDate','Qty']]
data.set_index('MonthEndDate', inplace=True)
#data.index.freq = 'M'
print("*********Time Series Information**********")
#print(data.index)
#print(data.columns)
#print(type(data))
#print(data.info)

# plt.plot(data, label='Source Data')
# plt.show()

#Feature Extraction
X,y=Evaluation.create_features(data,label="Qty")
data=pd.concat([X,y],axis=1)
print(data)


series=data['Qty'].astype(float)
#print(type(series))
series.plot(title='Qty Sold for the past 24 Months')
plt.show()


# End : 1. Source Data for Modelling-----------------------------------------------------
# 2. Train–Test split (e.g: last 20% as test)-------------------------------------
#Method 1:
Steps=int(len(series)*0.2)
print("Steps :",Steps)
print("****************")
train, test = series[:-Steps], series[-Steps:]
print("type(test) : ",type(test))
print("test.index :",test.index)

#Method 2:
# msk=(data.index<len(data)-30)
# train=df[msk].copy()
# test=df[~msk].copy()

#train, test = series_differencing[:-Steps], series_differencing[-Steps:]


#2.1 Stationarity Check:
#if p-value is > 0.05, the series is not stationary

#For Improved fitting
#1. Use an ADF test to decide minimal d needed for stationarity.
#2. Inspect ACF and PACF plots to select modest p and q (often in low single digits) 
#3. Try auto_arima/pmdarima with AIC/BIC to optimize (p,d,q) in a computationally smart way

#Method 1 : ACF and PACF Plotting to check Stationarity
from statsmodels.graphics.tsaplots import plot_acf,plot_pacf

fig, ax = plt.subplots(1, 2, figsize=(12, 4))
plot_acf(series, lags=len(series)*0.5, ax=ax[0])
sm.graphics.tsa.plot_pacf(series, lags=len(series)*0.5, ax=ax[1])
plt.show()


# #Method 2 : ADF Test to check Stationarity

print("===ADF Test for Original Data Series ===")
print(Evaluation.adf_test(series))


# Transform: log and first difference (remove trend/variance issues)
print("===ADF Test for Transformed Data Series ===")
series_log = np.log(series).astype(float) #don't forget to transform the data back when making real predictions
#print("series_log :\n",series_log)
#print(series_log.isna().sum())
#print(np.isinf(series_log).sum())
series_differencing = series_log.replace([np.inf ,-np.inf],np.nan).dropna().diff()
series_differencing = series_differencing.replace([np.inf ,-np.inf],np.nan).dropna()
#print("series_differencing :\n",series_differencing)
print(Evaluation.adf_test(series_differencing)) 
# The above P value will determine to set the d value 
# i.e if p<=0.05 ,d=1 ;if p>0.05 ,d=2, dont go further of setting d value>2, will be ineffective.


fig, ax = plt.subplots(1, 2, figsize=(12, 4))
plot_acf(series_differencing, lags=len(series_differencing)*0.5, ax=ax[0])
sm.graphics.tsa.plot_pacf(series_differencing, lags=len(series_differencing)*0.5, ax=ax[1])
plt.show()




# End : 2. Train–Test split (e.g., last 12 months as test)-------------------------------
# 3. Fitting the Model: ARIMA on training data-------------------------------------------
model = ARIMA(train, order=(30,1,3))
#print("model : \n",model)
fitted = model.fit()
#print("fitted : \n",fitted)
print(fitted.summary())


#Auto Fitting the Model
#import pmdarima as pm #Due to Python Version Compatibility issue, it is not installed
# auto_arima=pm.auto_arima(series,stepwise=False,Seasonal=False)
# print(auto_arima)



# End : 3. Fitting the Model: ARIMA on training data-------------------------------------
# 4. Time Series Prediction : 
# To Ensure Model has captured adequate information from the data

residuals=fitted.resid[1:]
fig,ax=plt.subplots(1,2)
residuals.plot(title="Residuals",ax=ax[0])
residuals.plot(title="Density",kind="kde",ax=ax[1])
plt.show()


fig, ax = plt.subplots(1, 2, figsize=(12, 4))
plot_acf(residuals, lags=len(residuals)*0.5, ax=ax[0])
sm.graphics.tsa.plot_pacf(residuals, lags=len(residuals)*0.5, ax=ax[1])
plt.show()

# End : 4. Time Series Prediction :------------------------------------------------------
# 4. Forecast for the test period--------------------------------------------------------
a=MyCalendar.ForecastPeriod()
ForcastDates=a[1]
#print("cal.ForecastDates",ForcastDates)
# print("type(test)",type(test))
# print("type(ForcastDates)",type(ForcastDates))
print("test.index : \n",test.index)
print("ForcastDates.index : \n",ForcastDates.index)
fc_index=test.index.append(ForcastDates.index).unique()
fc = fitted.get_forecast(steps=Steps+int(a[0]))
pred = fc.predicted_mean
#pred.index = test.index #Future Dates as Index is required to plot
pred.index = fc_index

# forecast_test=fitted.forecast(len(test))
# series["forecast_manual"]=[None]*len(train)+list(forecast_test)
# plt.plot(series, label='Source Data')
# plt.show()

# End : 4. Forecast for the test period--------------------------------------------------
# 5. Evaluate performance----------------------------------------------------------------
rmse = sqrt(mean_squared_error(test, pred[:Steps]))
print(f'RMSE on test = {rmse:.2f}')


# End: 5. Evaluate performance-----------------------------------------------------------
# 6. Plot actual vs forecast-------------------------------------------------------------
plt.figure(figsize=(10,5))
plt.plot(train, label='Original Data')
plt.plot(test, label='Test Data', color='gray')
plt.plot(pred, label='Forecast Data', color='red')
plt.legend()
plt.title('ARIMA Forecast')
plt.show()

# End : 6. Plot actual vs forecast-------------------------------------------------------
pred.to_excel('series_output.xlsx', sheet_name='Sheet1', index=True)