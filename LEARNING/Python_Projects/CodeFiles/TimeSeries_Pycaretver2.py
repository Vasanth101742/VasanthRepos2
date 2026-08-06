import pycaret as py
from pycaret.utils import version
import matplotlib.pyplot as plt
import File1
import Evaluation
import pandas as pd
from pycaret.time_series import *
from pycaret.time_series import TSForecastingExperiment
import urllib
import pyarrow as pa
import pyodbc
import numpy as np
import warnings
warnings.filterwarnings("ignore", category=UserWarning)
# 1. Source Data for Modelling----------------------------------------------------------
forecaststeps=File1.forecaststeps
df=File1.df11
Organ = df['Organ'].unique().tolist()
#print(Organ)

#Item = df['item'].unique().tolist()
#print(Item)

Organ=['India']
# Item = df.loc[df['Organ'] == Organ[0],'item'].unique().tolist()
#print(Item)

#Item=['S014900','B009301070004','000010310']  #S014900,'000111770'

df_final = pd.DataFrame(columns=['Organ','item','Item_desc','MonthEndDate','Index_date','Qty','Index_date2','y_pred'])

for i in Organ:
    #Item = df.loc[df['Organ'] == i,'item'].unique().tolist() 
    #Item=['S011733','S011734','S011735','S011736','S011759']
    #Item=['B676103','B676801','B677701']
    Item=['B003308170042']
    #print(Item)
    

    for j in Item:
        position = Item.index(j)+1
        TotalItems=len(Item)
        print(f"Currently Processing : {position}/{TotalItems}")
        #print(f"Organ and Item :{i}, {j}")
        filtered_df = df[(df['Organ'] == i) & (df['item'] == j)]
        filtered_df=pd.DataFrame(filtered_df)
        
        #Item_desc = df.loc['Organ'==i & 'item'==j,'Item_desc'].unique().tolist()
        #print('Item_desc :',Item_desc)
        
        # # Date Manipulation-------------------------------------
        from datetime import datetime, timedelta
        MonthsConsidered=24
        today = datetime.today()
        date_24_days_ago = today - timedelta(days=MonthsConsidered)
        startdate=date_24_days_ago.date()
        startdate=datetime.today()
        startdate=startdate.replace(day=1)
        startdate=startdate.date()
        Index_date= pd.date_range(start=startdate
                                  ,periods=MonthsConsidered #+forecaststeps
                                  ,freq='D')
        df1_new=pd.DataFrame(Index_date)
        #print(type(df1_new))
        df1_new.columns = ['Index_date']
        df1_new[['Organ','item','Item_desc','MonthEndDate','Qty']]=filtered_df[['Organ','item','Item_desc','MonthEndDate','Qty']].reset_index(drop=True)
        df1_new.set_index('Index_date', inplace=True)
        df1_new['Index_date']=df1_new.index
        df1_new['Index_date'] = df1_new['Index_date'].dt.date
        df1_new['Qty'] = df1_new['Qty'].fillna(0)

        # End: Date Manipulation--------------------------------

        series=df1_new['Qty'].astype(float)
        series = series.asfreq('D') 
        #print(df1_new)
        #print(series)        
        #print("type(series) :",type(series))
        # series_df=pd.DataFrame(series)
        # print("type(series_df) :",type(series))
        # End : 1. Source Data for Modelling----------------------------------------------------
        s1=setup(series,fold=3,fh=forecaststeps,session_id=123,verbose=False)
        s2=TSForecastingExperiment()
        s2.setup(series,verbose=False)
        #print("check_stats : \n",check_stats())
        
        model = create_model('arima')
        pred_model=predict_model(model,fh=9,verbose=False)
        final_model=finalize_model(model)
        
        best=compare_models(verbose=False)
        print("Best Model as per Pycaret for the Given Data : ",best)
        # pred_model=predict_model(best,verbose=False)
        # final_model=finalize_model(best)
        
        
        #print("type(pred_model) :",type(pred_model))
        #print("pred_model :\n",pred_model)
        pred_model2=pred_model
        pred_model2['Index_date2']=pred_model.index
        #print("pred_model2.dtypes before:",pred_model2.dtypes)
        #pred_model2['Index_date2']=pd.to_datetime(pred_model2['Index_date2']) #Error : Cannot convert the Period directlt to datetime        
        pred_model2['Index_date2'] = pred_model2['Index_date2'].dt.to_timestamp()
        #pred_model2['Index_date2'] =pd.to_datetime(pred_model2['Index_date2']).dt.date() #error: 'Series' object is not callable
        #print("pred_model2 :\n",pred_model2[['Index_date2','y_pred']])
        #print("pred_model2.dtypes After:",pred_model2.dtypes)


        df_combined = pd.concat([df1_new[['Organ','item','Item_desc','MonthEndDate','Index_date','Qty']], pred_model2[['Index_date2','y_pred']]], ignore_index=True)
        #print("df_combined :\n",df_combined)
        df_combined.loc[pd.isna(df_combined['Index_date']), 'Index_date'] = df_combined.loc[pd.notna(df_combined['Index_date2']), 'Index_date2']
        df_combined.loc[pd.isna(df_combined['Qty']), 'Qty'] = df_combined.loc[pd.notna(df_combined['y_pred']), 'y_pred']
        #df_combined.loc[pd.isna(df_combined['Organ']), 'Organ'] = df_combined.loc[pd.notna(df_combined['Organ']), 'Organ']
        #df_combined.loc[pd.isna(df_combined['Organ']), 'Organ'] = df_combined.loc[pd.notna(df_combined['Organ']), 'Organ']
        #df_combined['Organ'] = df1_new['Organ'].fillna("India")
        
        df_combined2=df_combined
        #df_combined.loc[df_combined['Organ'].isna(), 'Organ'] = df_combined2.loc[df_combined['Organ'].notna(), 'Organ']
        
        df_combined.loc[df_combined['Organ'].isna(), 'Organ'] = i
        df_combined.loc[df_combined['item'].isna(), 'item'] = j
        #print('filtered_df[Item_desc].drop_duplicates() :\n',filtered_df['Item_desc'].drop_duplicates())
        #k=filtered_df.loc['Item_desc'].drop_duplicates()
        #print("type(k)",type(k))
        #print("k=",k) 
        #df_combined.loc[df_combined['Item_desc'].isna(), 'Item_desc'] = k
        df_combined.loc[df_combined['MonthEndDate'].isna(), 'MonthEndDate'] = filtered_df['MonthEndDate']
        #print("df_combined :\n",df_combined)
        df_final=pd.concat([df_final, df_combined], ignore_index=True)
        # print("i :",i)
        # print([df_combined['Organ'].isna(), 'Organ'])
        # print(df_combined.loc[df_combined['Organ'].isna(), 'Organ'])
        # print(df_combined2.loc[df_combined['Organ'].notna(), 'Organ'])

        
        
        plot_model(final_model,plot='forecast',data_kwargs={'fh': forecaststeps+9})
        plt.show()
                       
        # plot_model(final_model, plot='forecast', data_kwargs={'fh': forecaststeps+9})
        # plt.show()
        
        #input("Press Enter to exit")

print("******************************************")
#print(df_final['item'].unique().tolist())
df_final.fillna('', inplace=True)
df_final['MonthEndDate'] = df_final['MonthEndDate'].fillna(pd.Timestamp('1900-01-01'))
df_final['Qty'] = df_final['Qty'].astype(np.float64)
df_final['Index_date']=pd.to_datetime(df_final['Index_date'])
#print("df_final : \n",[df_final])
#print("df_final.dtypes : \n",df_final.dtypes)
#df_final.to_excel('predictions.xlsx', index=True) 



# write the Output to SQL Server---------------------------------------------
conn_str =File1.conn_str
quoted = urllib.parse.quote_plus(conn_str)

insert_sql = "INSERT INTO dbo.SalesQtyForecast (Organ,Item,Item_desc,MonthendDate,IndexDate,Qty)VALUES (?,?,?,?,?,?)"

dest_conn=pyodbc.connect(conn_str)
cursor = dest_conn.cursor()
#cursor.fast_executemany = True
cursor.execute("Truncate Table SalesQtyForecast ")
dest_conn.commit()

df_final2=df_final[['Organ','item','Item_desc','MonthEndDate','Index_date','Qty']]
#print("df_final2.dtypes : \n",df_final2.dtypes)

data = [tuple(x) for x in df_final2.to_numpy()]
#print(data)
cursor.executemany(insert_sql, data)
dest_conn.commit()
cursor.close()
dest_conn.close()


# End: write the Output to SQL Server----------------------------------------
















# # 1. Source Data for Modelling----------------------------------------------------------
# #print ("Pycaret Version :",version())
# forecaststeps=File1.forecaststeps


# #Source 1: Monthwise
# # data1=File1.df2
# # #data=data1[['CalPeriod','Qty']]
# # data=data1
# # data.set_index('CalPeriod', inplace=True)

# #Source 2: Invoice date wise
# #Index_date= pd.date_range(start='2025-01-01', periods=30, freq='D')


# # data1=File1.df1_new
# # data=data1[['MonthEndDate','Qty']]
# # date_range = pd.date_range(start=data['MonthEndDate'].min(), periods=len(data), freq='D')
# # data['Index_date'] = date_range
# # data.set_index('Index_date', inplace=True)
# # data.asfreq("D")
# # #print("Data : \n",data)

# # full_idx = pd.date_range(start=data.index.min(), end=data.index.max(), freq='D')
# # data = data.reindex(full_idx)
# # data['Qty'] = data['Qty'].fillna(0)
# # #print(data)
# # #input("Press Enter to close...")

# #print(data.index)
# #print(data.dtypes)
# #print(data)


# # plt.plot(data, label='Source Data')
# # plt.show()


# # #Source 3: Month end Date wise
# data1=File1.df1_new
# # #print(data1)
# # #print(data1.index)



# #Feature Extraction
# # X,y=Evaluation.create_features(data,label="Qty")
# # data=pd.concat([X,y],axis=1)
# # print(data)


# series=data1['Qty'].astype(float)
# series = series.asfreq('D') 
# #print(type(series))
# # series.plot(title='Qty Sold for the past 24 Months')
# # plt.show()


# # End : 1. Source Data for Modelling-----------------------------------------------------

# # #Method 1:  If Invoice Dates are considered-------------------------------------------

# # s1=setup(series,fold=3,fh=forecaststeps,session_id=123 , numeric_imputation_target='mean')
# # print("s1 :\n",s1)

# # s2=TSForecastingExperiment()
# # s2.setup(series,numeric_imputation_target='mean')

# # #End of Method 1:  If Invoice Dates are considered------------------------------------
# # #Method 2:  If Monthend Dates are considered------------------------------------------

# s1=setup(series,fold=3,fh=forecaststeps,session_id=123)
# #print("s1 :\n",s1)
# s2=TSForecastingExperiment()
# s2.setup(series)
# #print("s2 :\n",s2)

# # End of Method 2:  If Monthend Dates are considered -------------------------------------


# #print("check_stats : \n",check_stats())


# model = create_model('arima')
# #plot_model(model, plot='forecast', data_kwargs={'fh': forecaststeps+3})
# #plt.show()

# pred_model=predict_model(model,fh=6)
# #print(pred_model)
# pred_model.to_excel('predictions.xlsx', index=True) 


# final_model=finalize_model(model)
# #print(final_model)
# plot_model(final_model,plot='forecast',data_kwargs={'fh': forecaststeps+6})
# plt.show()



# # model = create_model('naive')
# # pred_model=predict_model(model,fh=6)
# # final_model=finalize_model(model)
# # plot_model(final_model,plot='forecast',data_kwargs={'fh': forecaststeps+6})
# # plt.show()


# # #Plot train data
# # train = get_config('X_train')
# # plt.plot(train.index, train['target_col'], label='Train')

# # # Plot test data
# # test = get_config('X_test')
# # plt.plot(test.index, test['target_col'], label='Test')

# # # Plot forecast data
# # plt.plot(pred_model.index, pred_model['Label'], label='Forecast')

# # plt.legend()
# # plt.show()



# #input("Press Enter to close...")

# # plot_model(model, plot='train_test_split')
# # plt.show()
# # plot_model(model, plot='insample')
# # plt.show()
# # plot_model(model, plot='residuals')
# # plt.show()
# # plot_model(model, plot='diagnostics')
# # plt.show()
# # plot_model(model, plot='acf')
# # plt.show()
# # plot_model(model, plot='pacf')
# # plt.show()


# best=compare_models()
# print("Best Model as per Pycaret for the Given Data : ",best)

# pred_model=predict_model(best)
# #print("pred_model : \n",pred_model)
# final_model=finalize_model(best)
# #print("final_model : \n",final_model)

# plot_model(final_model, plot='forecast', data_kwargs={'fh': forecaststeps+6})
# plt.show()
# plot_model(best, plot='train_test_split')
# plt.show()
# plot_model(best, plot='insample')
# plt.show()


# input("Press Enter to close...")
