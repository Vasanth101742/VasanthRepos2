import pycaret as py
from pycaret.utils import version
import matplotlib.pyplot as plt
import File1
import Evaluation
import pandas as pd
from pycaret.time_series import *
from pycaret.time_series import TSForecastingExperiment


# 1. Source Data for Modelling----------------------------------------------------------
#print ("Pycaret Version :",version())
forecaststeps=File1.forecaststeps


#Source 1: Monthwise
# data1=File1.df2
# #data=data1[['CalPeriod','Qty']]
# data=data1
# data.set_index('CalPeriod', inplace=True)

#Source 2: Invoice date wise
#Index_date= pd.date_range(start='2025-01-01', periods=30, freq='D')


# data1=File1.df1_new
# data=data1[['MonthEndDate','Qty']]
# date_range = pd.date_range(start=data['MonthEndDate'].min(), periods=len(data), freq='D')
# data['Index_date'] = date_range
# data.set_index('Index_date', inplace=True)
# data.asfreq("D")
# #print("Data : \n",data)

# full_idx = pd.date_range(start=data.index.min(), end=data.index.max(), freq='D')
# data = data.reindex(full_idx)
# data['Qty'] = data['Qty'].fillna(0)
# #print(data)
# #input("Press Enter to close...")

#print(data.index)
#print(data.dtypes)
#print(data)


# plt.plot(data, label='Source Data')
# plt.show()


# #Source 3: Month end Date wise
data1=File1.df1_new
# #print(data1)
# #print(data1.index)



#Feature Extraction
# X,y=Evaluation.create_features(data,label="Qty")
# data=pd.concat([X,y],axis=1)
# print(data)


series=data1['Qty'].astype(float)
series = series.asfreq('D') 
print("********Series : \n",series)
#print(type(series))
# series.plot(title='Qty Sold for the past 24 Months')
# plt.show()


# End : 1. Source Data for Modelling-----------------------------------------------------

# #Method 1:  If Invoice Dates are considered-------------------------------------------

# s1=setup(series,fold=3,fh=forecaststeps,session_id=123 , numeric_imputation_target='mean')
# print("s1 :\n",s1)

# s2=TSForecastingExperiment()
# s2.setup(series,numeric_imputation_target='mean')

# #End of Method 1:  If Invoice Dates are considered------------------------------------
# #Method 2:  If Monthend Dates are considered------------------------------------------

s1=setup(series,fold=3,fh=forecaststeps,session_id=123)
#print("s1 :\n",s1)
s2=TSForecastingExperiment()
s2.setup(series)
#print("s2 :\n",s2)

# End of Method 2:  If Monthend Dates are considered -------------------------------------


#print("check_stats : \n",check_stats())


model = create_model('arima')
#plot_model(model, plot='forecast', data_kwargs={'fh': forecaststeps+3})
#plt.show()

pred_model=predict_model(model,fh=6)
#print(pred_model)
pred_model.to_excel('predictions.xlsx', index=True) 


final_model=finalize_model(model)
#print(final_model)
plot_model(final_model,plot='forecast',data_kwargs={'fh': forecaststeps+6})
plt.show()



# model = create_model('naive')
# pred_model=predict_model(model,fh=6)
# final_model=finalize_model(model)
# plot_model(final_model,plot='forecast',data_kwargs={'fh': forecaststeps+6})
# plt.show()


# #Plot train data
# train = get_config('X_train')
# plt.plot(train.index, train['target_col'], label='Train')

# # Plot test data
# test = get_config('X_test')
# plt.plot(test.index, test['target_col'], label='Test')

# # Plot forecast data
# plt.plot(pred_model.index, pred_model['Label'], label='Forecast')

# plt.legend()
# plt.show()



#input("Press Enter to close...")

# plot_model(model, plot='train_test_split')
# plt.show()
# plot_model(model, plot='insample')
# plt.show()
# plot_model(model, plot='residuals')
# plt.show()
# plot_model(model, plot='diagnostics')
# plt.show()
# plot_model(model, plot='acf')
# plt.show()
# plot_model(model, plot='pacf')
# plt.show()


best=compare_models()
print("Best Model as per Pycaret for the Given Data : ",best)

pred_model=predict_model(best)
#print("pred_model : \n",pred_model)
final_model=finalize_model(best)
#print("final_model : \n",final_model)

plot_model(final_model, plot='forecast', data_kwargs={'fh': forecaststeps+6})
plt.show()
plot_model(best, plot='train_test_split')
plt.show()
plot_model(best, plot='insample')
plt.show()


input("Press Enter to close...")
