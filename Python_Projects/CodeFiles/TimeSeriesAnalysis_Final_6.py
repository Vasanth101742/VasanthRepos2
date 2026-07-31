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
from datetime import datetime, timedelta
import time

# Step 1: DateMaster Generation--------------------------------------------------

# #Method 1: Monthwise--------------------------------
# startdate=datetime.today() - pd.DateOffset(months=24)
# startdate=startdate.replace(day=1)
# startdate=startdate.date()
# Index_date= pd.date_range(start=startdate
#                           ,periods=24
#                            ,freq='D')

# #print(Index_date)

# df_DateMaster=pd.DataFrame(Index_date)
# #print(type(df1_new))

# df_DateMaster.columns = ['Index_date']
# print('df_DateMaster before : \n',df_DateMaster)
# # df_DateMaster['Index_date']=df_DateMaster['Index_date'].dt.date() #Error: Series Object is not callable
# print('df_DateMaster after : \n',df_DateMaster)

# #End :Method 1: Monthwise--------------------------------
#Method 2: Daywise----------------------------------------
# Determine start and end
end = pd.Timestamp.today().normalize()
start = end - pd.DateOffset(months=24) + pd.Timedelta(days=1)  # inclusive of start month

# Full daily range
dates = pd.date_range(start=start, end=end, freq='D')

# Optional: convert to DataFrame
df_DateMaster = pd.DataFrame({'Index_date': dates})
#print('df_DateMaster : \n',df_DateMaster)
#input("")
#End : Method 2: Daywise--------------------------------

#End : Step 1: DateMaster Generation------------------------------------------------------
#Step 2: Source Data Generation------------------------------------------------------
#df=File1.df12 #For Monthwise
df=File1.df14 #For Daywise
#df_data=df.loc[(df['Organ'] == 'India') & (df['item'] == '000111770'),['Organ','item','Item_desc','MonthEndDate','Qty']]
#print(df_data)

# print('df.dtypes',df.dtypes)
# print('result.dtypes',df_DateMaster.dtypes)

Organ = df['Organ'].unique().tolist()
#Organ=['India']
#print("Organ : ",Organ)

# Item = df.loc[df['Organ'] == Organ[0],'item'].unique().tolist()
# #print("Item : ",Item)

#End : Step 2: Source Data Generation------------------------------------------------------
for i in Organ:
    #Step 3: Time Series Data Generation------------------------------------------------------

    Item = df.loc[df['Organ'] == i,'item'].unique().tolist()
    #Item=['000111770','B005700770004','B56XX07','S02599','S02469']
    #Item=['S02469']
    #print("Item : ",Item)
    
    for j in Item:
        position = Item.index(j)+1
        TotalItems=len(Item)
        print(f"Currently Processing : {position}/{TotalItems}")
        #print(f"Organ and Item :{i}, {j}")
        filtered_df = df[(df['Organ'] == i) & (df['item'] == j)]
        filtered_df=pd.DataFrame(filtered_df)
        
        
        #Source for Daywise 
        df_Source = pd.merge(df_DateMaster, filtered_df, left_on='Index_date', right_on='EntryDate', 
                  how='left', suffixes=('_left', '_right'))
        
        #Source for Monthwise 
        # df_Source=pd.DataFrame(Index_date)
        # df_Source.columns = ['Index_date']
        # df_Source[['Organ','item','Item_desc','EntryDate','Qty','sales_amount']]=filtered_df[['Organ','item','Item_desc','EntryDate','Qty','sales_amount']].reset_index(drop=True)
        # df_Source.set_index('Index_date', inplace=True)
        # df_Source['Index_date']=df_Source.index
        # df_Source['Index_date'] = df_Source['Index_date'].dt.date
        # df_Source['Qty'] = df_Source['Qty'].fillna(0)

        
        
        #Updating the Missing Values
        #df_Source.loc[df_Source['Organ'].isna(), 'Organ'] = df_Source.loc[df_Source['Organ'].notna(), 'Organ'] #No Use       
        df_Source.loc[df_Source['Organ'].isna(), 'Organ'] = i
        df_Source.loc[df_Source['item'].isna(), 'item'] = j
        df_Source['Qty'] = df_Source['Qty'].fillna(0)
        df_Source['sales_amount'] = df_Source['sales_amount'].fillna(0)
        df_Source.set_index('Index_date', inplace=True)
        df_Source['Index_date']=df_Source.index
        #print(df_Source[pd.notna(df_Source['Qty'])])
        #print(df_Source)
        
        
        
        series=df_Source['Qty'].astype(float)
        series = series.asfreq('D') 

        #End : Step 3: Time Series Data Generation------------------------------------------------------
        #Step 4: Time Series Modelling------------------------------------------------------------------
        #Method 1: Using Pycaret builtin Method
        forecaststeps=90 # int(len(df_DateMaster)/6)
        print("forecaststeps :",forecaststeps)
        start_time = time.time()
        s1=setup(series,fold=3,fh=forecaststeps,session_id=123,verbose=False)
        s2=TSForecastingExperiment()
        s2.setup(series,verbose=False)
        #print("check_stats : \n",check_stats())
        best=compare_models(verbose=False)
        #print("best._forecaster.__class__.__name__ :",best._forecaster.__class__.__name__)
        best_model_name = str(best).split("(")[0]
        #print("Best Model as per Pycaret for the Given Data : ",best_model_name)

        pred_model=predict_model(best,fh=180,verbose=False)
        final_model=finalize_model(best)
        end_time = time.time()
        elapsed_mins = (end_time - start_time)/60
        #print("type(pred_model) :",type(pred_model))
        #print("pred_model :\n",pred_model)
        
        plot_model(final_model, plot='forecast', data_kwargs={'fh': forecaststeps})
        plt.show()
        
        
               
    
        #End :Method 1: Using Pycaret builtin Method
        #End :Step 4: Time Series Modelling------------------------------------------------------------------
        #Step 5: Forecast Data Generation---------------------------------------------------------------------
        pred_model2=pred_model
        #print("pred_model2 before:",pred_model)
        pred_model2['Index_date2']=pred_model.index
        pred_model2['Index_date2'] = pred_model2['Index_date2'].dt.to_timestamp()
        pred_model2["best_model_name"]=best_model_name
        pred_model2["elapsed_mins"]=elapsed_mins
        #print("pred_model2 after:",pred_model)
        
        
        df_combined = pd.concat([df_Source[['Organ','item','Item_desc','EntryDate','Index_date','Qty']], pred_model2[['Index_date2','y_pred',"best_model_name","elapsed_mins"]]], ignore_index=True)        
        df_combined.loc[pd.isna(df_combined['Index_date']), 'Index_date'] = df_combined.loc[pd.notna(df_combined['Index_date2']), 'Index_date2']
        df_combined.loc[pd.isna(df_combined['Qty']), 'Qty'] = df_combined.loc[pd.notna(df_combined['y_pred']), 'y_pred']
        df_combined.loc[df_combined['Organ'].isna(), 'Organ'] = i
        df_combined.loc[df_combined['item'].isna(), 'item'] = j
        
        
        
        
        df_combined.fillna('', inplace=True)
        #df_combined['EntryDate'] = df_combined['EntryDate'].fillna(pd.Timestamp('1900-01-01'))
        df_combined['Qty'] = df_combined['Qty'].astype(np.float16)
        # print(df_combined)
        # input('Enter ')
        
        df_final=df_combined
        
        #End :Step 5: Forecast Data Generation----------------------------------------------------------------

        # write the Output to SQL Server---------------------------------------------
        conn_str =File1.conn_str
        quoted = urllib.parse.quote_plus(conn_str)

        insert_sql = "INSERT INTO dbo.SalesQtyForecast_Daywise (Organ,Item,Item_desc,EntryDate,IndexDate,Qty,ModelName,Elapsed_mins)VALUES (?,?,?,?,?,?,?,?)"

        dest_conn=pyodbc.connect(conn_str)
        cursor = dest_conn.cursor()
        #cursor.fast_executemany = True
        # cursor.execute("Truncate Table SalesQtyForecast_Daywise ")
        # dest_conn.commit()

        df_final2=df_final[['Organ','item','Item_desc','EntryDate','Index_date','Qty','best_model_name','elapsed_mins']]
        #print("df_final2.dtypes : \n",df_final2.dtypes)

        data = [tuple(x) for x in df_final2.to_numpy()]
        #print(data)
        cursor.executemany(insert_sql, data)
        dest_conn.commit()
        cursor.close()
        dest_conn.close()


        # End: write the Output to SQL Server----------------------------------------

