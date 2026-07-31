import pycaret as py
from pycaret.utils import version
#import matplotlib.pyplot as plt
import SourceData
#import Evaluation
import pandas as pd
from pycaret.time_series import *
from pycaret.time_series import TSForecastingExperiment
import urllib
import pyarrow as pa
import pyodbc
import numpy as np
import warnings
warnings.filterwarnings("ignore", category=UserWarning)
import time
from pycaret.classification import evaluate_model
from pycaret.classification import plot_model
from statsmodels.tsa.seasonal import seasonal_decompose

#------ Table Truncation----------------------------------------------------
# conn_str =File1.conn_str
# quoted = urllib.parse.quote_plus(conn_str)
 
# dest_conn=pyodbc.connect(conn_str)
# cursor = dest_conn.cursor()
# #cursor.fast_executemany = True
# cursor.execute("Truncate Table SalesQtyForecast ")
# dest_conn.commit()
# cursor.close()
# dest_conn.close()
#------End: Table Truncation-------------------------------------------------
 
 
# 1. Source Data for Modelling----------------------------------------------------------
forecaststeps=3
df=SourceData.df_DFUwise_Monthwise
Region = df['Region'].unique().tolist()
#Region = ['USA','Europe','AUS','Brazil','Indonesia','Malaysia','ID','SA']
# Region=['Europe','USA','Channel','Direct','C&M','WW','Railway Units','Railways Wiper','HO-AFM-Industrial',
# 'ACP-AFM-Industrial','HO-AFM-Portables','GSC-AFM-Portables','ACP-AFM-Portables',
# 'HO-AFM-Railway','ACP-AFM-Railway','GSC-AFM-Railway','GSC-AFM-Industrial']
#Region=['South Asia','Africa','ID','ME','Australia','Indonesia','Malaysia']
#Region=['USA','Malaysia','ID']
#print(Organ)
 
#Item = df['item'].unique().tolist()
#print(Item)
 
 
# Item = df.loc[df['Organ'] == Organ[0],'item'].unique().tolist()
#print(Item)
 
#Item=['S014900','B009301070004','000010310']  #S014900,'000111770'

df_final = pd.DataFrame(columns=['Region','DFUCode','DPSTCode','India_tpl','MonthEndDate','Index_date','Qty','Index_date2','y_pred'])
 
for i in Region:
    DFUCode = df.loc[df['Region'] == i,'DFUCode'].unique().tolist()
    #print(DFUCode)
    #DFUCode=['B001300110004']
    #Item=['S011733','S011734','S011735','S011736','S011759']
    #Item=['S02469']#,'B676801','B677701']
    #Item=['S02428']
    #print(Item)
   
 
    for j in DFUCode:
        position = DFUCode.index(j)+1
        TotalItems=len(DFUCode)
        print(f"Currently Processing : {position}/{TotalItems}")
        DPSTCode = df.loc[(df['Region'] == i) & (df['DFUCode'] == j),'DPSTCode'].unique().tolist()
        print("DPSTCode :",DPSTCode)
        for k in DPSTCode:
            print(f"Organ ,DFUCode, DPST :{i}, {j} ,{k}")
            filtered_df = df[(df['Region'] == i) & (df['DFUCode'] == j)  & (df['DPSTCode'] == k)]
            filtered_df=pd.DataFrame(filtered_df)
            #print("filtered_df",filtered_df)
            #input("")
            #Item_desc = df.loc['Organ'==i & 'item'==j,'Item_desc'].unique().tolist()
            #print('Item_desc :',Item_desc)
       
            # # Date Manipulation-------------------------------------
            #Method 1:
            # from datetime import datetime, timedelta
            # MonthsConsidered=24
            # today = datetime.today()
            # date_24_days_ago = today - timedelta(days=MonthsConsidered)
            # startdate=date_24_days_ago.date()
            # startdate=datetime.today()
            # startdate=startdate.replace(day=1)
            # startdate=startdate.date()
            # Index_date= pd.date_range(start=startdate
            #                           ,periods=MonthsConsidered #+forecaststeps
            #                           ,freq='D')
            # df_DateMaster=pd.DataFrame(Index_date)
            # #print(type(df1_new))
            # df_DateMaster.columns = ['Index_date']

            #Method 2:
            # Sample data with start and end dates as strings
            # DateMapping = {'Index_date': ['2025-08-01', '2025-08-02', '2025-08-03','2025-08-04','2025-08-05',
            #                    '2025-08-06', '2025-08-07', '2025-08-08','2025-08-09','2025-08-10',
            #                    '2025-08-11', '2025-08-12', '2025-08-13', '2025-08-14','2025-08-15',
            #                    '2025-08-16', '2025-08-17', '2025-08-18', '2025-08-19','2025-08-20',
            #                    '2025-08-21', '2025-08-22', '2025-08-23','2025-08-24','2025-08-25',
            #                    '2025-08-26','2025-08-27',
            #                    #'2025-08-26', '2025-08-27', '2025-08-28', '2025-08-29','2025-08-30'
            #                    ],
            #                 'Monthend_date': ['2024-02-29','2024-03-31','2024-04-30',
            #                                   '2024-05-31','2024-06-30','2024-07-31','2024-08-31',
            #                                   '2024-09-30','2024-10-31','2024-11-30','2024-12-31',
            #                                   '2025-01-31','2025-02-28','2025-03-31','2025-04-30',
            #                                   '2025-05-31','2025-06-30','2025-07-31','2025-08-31',
            #                                   '2025-09-30','2025-10-31','2025-11-30','2025-12-31',
            #                                   '2026-01-31','2026-02-28','2026-03-31','2026-04-30'
            #                       ]    
            #             }
            

            DateMapping = {'Index_date': ['2025-08-01','2025-08-02','2025-08-03','2025-08-04','2025-08-05',
                                            '2025-08-06','2025-08-07','2025-08-08','2025-08-09','2025-08-10',
                                            '2025-08-11','2025-08-12','2025-08-13','2025-08-14','2025-08-15',
                                            '2025-08-16','2025-08-17','2025-08-18','2025-08-19','2025-08-20',
                                            '2025-08-21','2025-08-22','2025-08-23','2025-08-24','2025-08-25',
                                            '2025-08-26','2025-08-27','2025-08-28','2025-08-29','2025-08-30',
                                            '2025-08-31','2025-09-01','2025-09-02'
                               ],
                            'Monthend_date': ['2023-01-31','2023-02-28','2023-03-31','2023-04-30','2023-05-31',
                                                '2023-06-30','2023-07-31','2023-08-31','2023-09-30','2023-10-31',
                                                '2023-11-30','2023-12-31','2024-01-31','2024-02-29','2024-03-31',
                                                '2024-04-30','2024-05-31','2024-06-30','2024-07-31','2024-08-31',
                                                '2024-09-30','2024-10-31','2024-11-30','2024-12-31','2025-01-31',
                                                '2025-02-28','2025-03-31','2025-04-30','2025-05-31','2025-06-30',
                                                '2025-07-31','2025-08-31','2025-09-30'
                                  ]    
                        }
            

            # Create DataFrame
            df_DateMapping = pd.DataFrame(DateMapping)
            # Convert string columns to datetime
            df_DateMapping['Index_date'] = pd.to_datetime(df_DateMapping['Index_date'])
            df_DateMapping['Monthend_date'] = pd.to_datetime(df_DateMapping['Monthend_date'])

            # Convert datetime columns to date type
            # df_DateMapping['Index_date'] = df_DateMapping['Index_date'].dt.date
            # df_DateMapping['Monthend_date'] = df_DateMapping['Monthend_date'].dt.date
            #print(df_DateMapping)
            #print(df_DateMapping.dtypes)
            df1_stage = pd.merge(df_DateMapping, filtered_df, left_on='Monthend_date', right_on='MonthEndDate', 
                  how='left', suffixes=('_left', '_right'))
            #print(df1_stage)
            df1_new=pd.DataFrame(columns=['Region','DFUCode','DPSTCode','India_tpl','MonthEndDate','Qty'])
            df1_new[['Region','DFUCode','DPSTCode','India_tpl','Index_date','MonthEndDate','Qty']]=df1_stage[['Region','DFUCode','DPSTCode','India_tpl','Index_date','MonthEndDate','Qty']].reset_index(drop=True)    
            #print(df1_new)
        
        

            #Old Method :
            #df1_new[['Region','DFUCode','India_tpl','MonthEndDate','Qty']]=filtered_df[['Region','DFUCode','India_tpl','MonthEndDate','Qty']].reset_index(drop=True)    
            #print(df1_new)
            #input("")        
            df1_new.set_index('Index_date', inplace=True)
            df1_new['Index_date']=df1_new.index
            df1_new['Index_date'] = df1_new['Index_date'].dt.date
            df1_new['Qty'] = df1_new['Qty'].fillna(0)
            #print(df1_new)
            #input("")
            # End: Date Manipulation--------------------------------
            # #Preprocessing
            # #a.Removing Trend
            # #1.Differencing
            # df1_new['differenced'] = df1_new['Qty'].diff()
            # #2.Log Transformation
            # df1_new['log_transformed'] = np.log(df1_new['Qty'])
            # #3.Rolling Mean
            # df1_new['rolling_mean'] = df1_new['Qty'] - df1_new['Qty'].rolling(window=12).mean()

            # #b.Removing Seasonality
            # decomposition = seasonal_decompose(df1_new['Qty'], model='additive', period=10)
            # df1_new['seasonally_adjusted'] = df1_new['Qty'] / decomposition.seasonal
            # #print('df1_new :\n',df1_new)
            # #input("")

            series=df1_new['Qty'].astype(float)
            series = series.asfreq('D')
            # print(df1_new)
            # input("")
            #print(series)        
            #print("type(series) :",type(series))
            # series_df=pd.DataFrame(series)
            # print("type(series_df) :",type(series))
            # End : 1. Source Data for Modelling----------------------------------------------------
            start_time = time.time()
            s1=setup(series,fold=3,fh=forecaststeps,session_id=123,verbose=False)
            s2=TSForecastingExperiment()
            s2.setup(series,verbose=False)
            #print("check_stats : \n",check_stats())
       
            # model = create_model('arima')
            # pred_model=predict_model(model,fh=12,verbose=False)
            # final_model=finalize_model(model)
            #print("type(pred_model) :",type(pred_model))
            #print("pred_model :\n",pred_model)
       
               
            #best=compare_models(n_select=1, sort='Accuracy',verbose=False)
            best=compare_models(verbose=False)
            rmse = pull()['RMSE'].to_list()
            print("type(RMSE):", type(rmse))
            print("RMSE:", rmse[0])
            #evaluate_model(best)
            best_model_name = str(best).split("(")[0]
            # print(best)
            # print(type(best))
            #input("")
            print("Best Model as per Pycaret for the Given Data : ",best_model_name)
            pred_model=predict_model(best,fh=12,verbose=False)
        
            final_model=finalize_model(best)
            end_time = time.time()
            elapsed_mins = round((end_time - start_time)/60,5)
            #print("type(pred_model) :",type(pred_model))
            print("pred_model :\n",pred_model)
        
        
      
            # plot_model(final_model,plot='forecast',data_kwargs={'fh': forecaststeps+9})
            # plt.show()

            # # Plot accuracy (AUC curve)
            # plot_model(best, plot='auc')

            # # Plot confusion matrix
            # plot_model(best, plot='confusion_matrix')

            # # Plot classification report
            # plot_model(best, plot='class_report')
               
            # View the predictions and associated metrics
            #print("pred_model.head()",pred_model.head())

            # Get a table of all available metrics
            #all_metrics = get_metrics()
            #print("all_metrics :",all_metrics)

       
            pred_model2=pred_model
            pred_model2['Index_date2']=pred_model.index
            #print("pred_model2.dtypes before:",pred_model2.dtypes)
            #pred_model2['Index_date2']=pd.to_datetime(pred_model2['Index_date2']) #Error : Cannot convert the Period directlt to datetime        
            pred_model2['Index_date2'] = pred_model2['Index_date2'].dt.to_timestamp()
            #pred_model2['Index_date2'] =pd.to_datetime(pred_model2['Index_date2']).dt.date() #error: 'Series' object is not callable
            #print("pred_model2 :\n",pred_model2[['Index_date2','y_pred']])
            #print("pred_model2.dtypes After:",pred_model2.dtypes)
            pred_model2["best_model_name"]=best_model_name
            pred_model2["elapsed_mins"]=elapsed_mins
       
 
            df_combined = pd.concat([df1_new[['Region','DFUCode','DPSTCode','India_tpl','MonthEndDate','Index_date','Qty']], pred_model2[['Index_date2','y_pred',"best_model_name","elapsed_mins"]]], ignore_index=True)
            #print("df_combined :\n",df_combined)
            df_combined.loc[pd.isna(df_combined['Index_date']), 'Index_date'] = df_combined.loc[pd.notna(df_combined['Index_date2']), 'Index_date2']
            df_combined.loc[pd.isna(df_combined['Qty']), 'Qty'] = df_combined.loc[pd.notna(df_combined['y_pred']), 'y_pred']
            #df_combined.loc[pd.isna(df_combined['Organ']), 'Organ'] = df_combined.loc[pd.notna(df_combined['Organ']), 'Organ']
            #df_combined.loc[pd.isna(df_combined['Organ']), 'Organ'] = df_combined.loc[pd.notna(df_combined['Organ']), 'Organ']
            #df_combined['Organ'] = df1_new['Organ'].fillna("India")
       
            df_combined2=df_combined
            # print(df_combined2)
            # input("")
            #df_combined.loc[df_combined['Organ'].isna(), 'Organ'] = df_combined2.loc[df_combined['Organ'].notna(), 'Organ']
       
            df_combined.loc[df_combined['Region'].isna(), 'Region'] = i
            df_combined.loc[df_combined['DFUCode'].isna(), 'DFUCode'] = j
            df_combined.loc[df_combined['DPSTCode'].isna(), 'DPSTCode'] = k
            #print('filtered_df[Item_desc].drop_duplicates() :\n',filtered_df['Item_desc'].drop_duplicates())
            #k=filtered_df.loc['Item_desc'].drop_duplicates()
            #print("type(k)",type(k))
            #print("k=",k)
            #df_combined.loc[df_combined['Item_desc'].isna(), 'Item_desc'] = k
            #df_combined.loc[df_combined['MonthEndDate'].isna(), 'MonthEndDate'] = filtered_df['MonthEndDate']
            df_combined.fillna('', inplace=True)
            df_combined['MonthEndDate'] = df_combined['MonthEndDate'].fillna(pd.Timestamp('1900-01-01'))
            df_combined['Qty'] = df_combined['Qty'].astype(np.float16)
            #df_combined['elapsed_mins'] = df_combined['elapsed_mins'].astype(np.float16)
            df_combined['Index_date']=pd.to_datetime(df_combined['Index_date'])
       
            #print("df_combined :\n",df_combined)
            df_final=df_combined.reset_index(drop=True)
            #df_final=pd.concat([df_final, df_combined], ignore_index=True)  
            # print("i :",i)
            # print([df_combined['Organ'].isna(), 'Organ'])
            # print(df_combined.loc[df_combined['Organ'].isna(), 'Organ'])
            # print(df_combined2.loc[df_combined['Organ'].notna(), 'Organ'])
 
       
            #input("Press Enter to exit")
 
            print("******************************************")
            #print(df_final['item'].unique().tolist())
            df_final.fillna('', inplace=True)
            df_final['MonthEndDate'] = df_final['MonthEndDate'].fillna(pd.Timestamp('1900-01-01'))
            #df_final['Qty'] = 0 if (df_final['Qty']).any()=='inf' else df_final['Qty']
            df_final['Qty'] = df_final['Qty'].replace([np.inf, -np.inf], np.nan).fillna(0)
            df_final['Qty'] = df_final['Qty'].astype(np.float64)
            df_final['Index_date']=pd.to_datetime(df_final['Index_date'])
            print("df_final : \n",df_final)
            #print("df_final.dtypes : \n",df_final.dtypes)
            #df_final.to_excel('predictions.xlsx', index=True)
 
       
 
            # write the Output to SQL Server---------------------------------------------
            conn_str =SourceData.conn_str
            quoted = urllib.parse.quote_plus(conn_str)
 
            insert_sql = "INSERT INTO dbo.SalesQtyForecast (Organ,DFUCode,DPSTCode,India_tpl,MonthendDate,IndexDate,Qty,ModelName,Elapsed_mins)VALUES (?,?,?,?,?,?,?,?,?)"
 
            dest_conn=pyodbc.connect(conn_str)
            cursor = dest_conn.cursor()
            #cursor.fast_executemany = True
            #cursor.execute("Truncate Table SalesQtyForecast ")
            #dest_conn.commit()
 
            df_final2=df_final[['Region','DFUCode','DPSTCode','India_tpl','MonthEndDate','Index_date','Qty',"best_model_name","elapsed_mins"]]
            #print(df_final2['Qty'])
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
 
 