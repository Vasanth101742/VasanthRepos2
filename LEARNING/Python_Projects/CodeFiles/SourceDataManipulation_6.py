import pandas as pd
from datetime import datetime, timedelta
import File1

today = datetime.today()
date_24_days_ago = today - timedelta(days=24)
date_24_days_ago=date_24_days_ago.date()
#print(date_24_days_ago.strftime('%Y-%m-%d'))

Index_date= pd.date_range(start=date_24_days_ago, periods=30, freq='D')
print(Index_date)
#print(type(Index_date))
df1=pd.DataFrame(Index_date)
#print(type(df1))
print(df1)

data1=File1.df1
df1[['MonthEndDate','Qty']]=data1[['MonthEndDate','Qty']]
print(df1)


