import pyodbc
import pandas as pd
from datetime import datetime, timedelta


# Step 1: Install the driver and library via:
#   pip install pyodbc pandas

# Step 2: Define your connection details
server   = '10.50.0.4'    # e.g. 'localhost\\SQLEXPRESS' or 'db.company.com'
database = 'ELGI_LN'
username = 'sa'       # omit if using Windows Authentication
password = 'ElgiP0w3r@20#23'       # omit if using Windows Authentication

# Choose authentication method: either Windows or SQL
conn_str = (
    'DRIVER={ODBC Driver 17 for SQL Server};'
    f'SERVER={server};'
    f'DATABASE={database};'
    # For Windows integrated auth:
    #'Trusted_Connection=yes;'
    # Or for SQL Server auth, comment above line and uncomment these:
     f'UID={username};'
     f'PWD={password};'
)

# Step 3: Make the connection
conn = pyodbc.connect(conn_str)
print("✅ Connected to SQL Server")

# Step 4: Read data into DataFrame
# query = "select organ,invoice_date,Item,Item_desc, \
# Sum(deliveryQty) Qty ,sum(sales_amount) sales_amount \
# from elgi_sales_details \
# where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-1))) \
# and Item_desc is not null \
# group by organ,invoice_date,Item,Item_desc"

MonthsConsidered=24
forecaststeps=3


query1 = "select MonthEndDate,sum(deliveryQty) Qty ,sum(sales_amount) sales_amount \
from (select invoice_date , eomonth(invoice_date,0) as MonthEndDate,deliveryQty,\
sales_amount from elgi_sales_details \
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-"+str(MonthsConsidered)+"))) \
and Item_desc is not null \
and ltrim(rtrim(item))='B676103')a \
group by MonthEndDate"

query11="select Organ,item,Item_desc,MonthEndDate,\
sum(deliveryQty) Qty ,sum(sales_amount) sales_amount,\
Dense_Rank() over(order by Organ) as OrganRnk,\
ROW_NUMBER() over(partition by Organ,Item order by Organ) as ItemRnk \
from (\
select case when organ in ('SAAME','ID','GULF TO ROTAIR','VACUUM','COSEA','India') \
then 'India' else organ end as organ,\
invoice_date as EntryDate,eomonth(invoice_date,0) as MonthEndDate,\
ltrim(rtrim(item)) item,Item_desc,deliveryQty,sales_amount \
from elgi_sales_details \
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-"+str(MonthsConsidered)+"))) \
and deliveryQty>0 \
and Item_desc is not null \
and Organ not in ('Subsidiary') \
union all \
select Region,\
InvDate as EntryDate,eomonth(InvDate,0) as MonthEndDate,\
ltrim(rtrim(ItemCode)) ItemCode,ltrim(rtrim(ItemDesc)) ItemDesc,\
DelQty,Amount from [ELGI_US].dbo.[vw_Sales_data_US] \
where InvDate>=(select dateadd(dd,1,eomonth(getdate()-1,-"+str(MonthsConsidered)+"))) \
and DelQty>0 \
)a \
where concat(Organ,ltrim(rtrim(item))) not in (select distinct concat(Organ,ltrim(rtrim(item))) \
from SalesQtyForecast) \
and concat(Organ,ltrim(rtrim(item))) in (select distinct concat(Region,ltrim(rtrim(itemcode))) \
from Sales_RRS where region='India' and ItemCategory='Aftermarket') \
group by Organ,MonthEndDate,item,Item_desc \
order by Item,MonthEndDate"


query12="select Organ,item,Item_desc,EntryDate,\
sum(deliveryQty) Qty ,sum(sales_amount) sales_amount,\
Dense_Rank() over(order by Organ) as OrganRnk,\
ROW_NUMBER() over(partition by Organ,Item order by Organ) as ItemRnk \
from (select Organ,invoice_date as EntryDate,eomonth(invoice_date,0) as EntryDate2,\
ltrim(rtrim(item)) item,Item_desc,deliveryQty,sales_amount from elgi_sales_details \
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-"+str(MonthsConsidered)+"))) \
and Item_desc is not null \
and Organ not in ('Subsidiary') \
and concat(Organ,ltrim(rtrim(item))) not in (select distinct concat(Organ,ltrim(rtrim(item))) \
from SalesQtyForecast)\
)a \
group by Organ,EntryDate,item,Item_desc \
order by Item,EntryDate"


query13="select Organ,item,Item_desc,EntryDate,\
sum(deliveryQty) Qty ,sum(sales_amount) sales_amount,\
Dense_Rank() over(order by Organ) as OrganRnk,\
ROW_NUMBER() over(partition by Organ,Item order by Organ) as ItemRnk \
from (select Organ,invoice_date as EntryDate,eomonth(invoice_date,0) as EntryDate2,\
ltrim(rtrim(item)) item,Item_desc,deliveryQty,sales_amount from elgi_sales_details \
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-"+str(MonthsConsidered)+"))) \
and Item_desc is not null \
and Organ not in ('Subsidiary') \
and concat(Organ,ltrim(rtrim(item))) not in (select distinct concat(Organ,ltrim(rtrim(item))) \
from SalesQtyForecast)\
)a \
group by Organ,EntryDate,item,Item_desc \
order by Item,EntryDate"


query14="select Organ,item,Item_desc,EntryDate,\
sum(deliveryQty) Qty ,sum(sales_amount) sales_amount,\
Dense_Rank() over(order by Organ) as OrganRnk,\
ROW_NUMBER() over(partition by Organ,Item order by Organ) as ItemRnk \
from (\
select case when organ in ('SAAME','ID','GULF TO ROTAIR','VACUUM','COSEA','India') \
then 'India' else organ end as organ,\
invoice_date as EntryDate,eomonth(invoice_date,0) as EntryDate2,\
ltrim(rtrim(item)) item,Item_desc,deliveryQty,sales_amount \
from elgi_sales_details \
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-"+str(MonthsConsidered)+"))) \
and company like '4%'\
and deliveryQty>0 \
and Item_desc is not null \
and Organ not in ('Subsidiary') \
union all \
select Region,\
InvDate as EntryDate,eomonth(InvDate,0) as EntryDate2,\
ltrim(rtrim(ItemCode)) ItemCode,ltrim(rtrim(ItemDesc)) ItemDesc,\
DelQty,Amount from [ELGI_US].dbo.[vw_Sales_data_US] \
where InvDate>=(select dateadd(dd,1,eomonth(getdate()-1,-"+str(MonthsConsidered)+"))) \
and DelQty>0 \
)a \
where concat(Organ,ltrim(rtrim(item))) not in (select distinct concat(Organ,ltrim(rtrim(item))) \
from SalesQtyForecast_Daywise) \
and concat(Organ,ltrim(rtrim(item))) in (select distinct concat(Region,ltrim(rtrim(itemcode))) \
from Sales_RRS where region='India') \
group by Organ,EntryDate,item,Item_desc \
order by Item,EntryDate"

query2 ="select * from (\
select CalPeriod,CalPeriodName,cal_Month,Sum(deliveryQty) Qty ,sum(sales_amount) sales_amount \
from (select concat(cal_year,RIGHT('00'+CAST(cal_Month AS VARCHAR(2)),2)) as CalPeriod,\
concat(left([Monthname],3),'-',right(cal_year,2)) as CalPeriodName,cal_Month,\
item,Item_desc,DeliveryQty,Sales_amount from elgi_sales_details \
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-"+str(MonthsConsidered)+"))) \
and Item_desc is not null \
and ltrim(rtrim(item))='B676103'\
)a \
group by CalPeriod,CalPeriodName,cal_Month)a \
where Qty<>0 \
order by CalPeriod"

df1 = pd.read_sql_query(query1, conn)
df1['MonthEndDate']=pd.to_datetime(df1['MonthEndDate'])

# print(f"📦 Retrieved {len(df1)} rows with columns: {', '.join(df1.columns)}")

df11 = pd.read_sql_query(query11, conn)
df11['MonthEndDate']=pd.to_datetime(df11['MonthEndDate'])
#print("df11 :",df11)


df12 = pd.read_sql_query(query12, conn)
df12['EntryDate']=pd.to_datetime(df12['EntryDate'])
#print("df12 :",df12)


df13 = pd.read_sql_query(query13, conn)
df13['EntryDate']=pd.to_datetime(df13['EntryDate'])
#print("df13 :",df13)


df14 = pd.read_sql_query(query14, conn)
df14['EntryDate']=pd.to_datetime(df14['EntryDate'])
print("df14 :",df14)




df2 = pd.read_sql_query(query2, conn)
#print(f"📦 Retrieved {len(df2)} rows with columns: {', '.join(df2.columns)}")


# #Method 1:  If Invoice Dates are considered-------------------------------------------
# df1_new=df1
# df1_new['Index_date']=df1['MonthEndDate']
# df1_new.set_index('Index_date', inplace=True)
# df1_new['Qty'] = df1_new['Qty'].fillna(0)

# #End of Method 1:  If Invoice Dates are considered------------------------------------

# #Method 2:  If Monthend Dates are considered------------------------------------------
today = datetime.today()
date_24_days_ago = today - timedelta(days=MonthsConsidered)
date_24_days_ago=date_24_days_ago.date()

Index_date= pd.date_range(start=date_24_days_ago, periods=MonthsConsidered #+forecaststeps
                          , freq='D')
#print(Index_date)
#print(type(Index_date))
df1_new=pd.DataFrame(Index_date)
#print(type(df1))
#print(df1_new)

#data1=File1.df1
# print(df1.dtypes)
# print(df1)

df1_new[['MonthEndDate','Qty']]=df1[['MonthEndDate','Qty']]
df1_new.columns = ['Index_date', 'MonthEndDate', 'Qty']
df1_new.set_index('Index_date', inplace=True)
df1_new['Qty'] = df1_new['Qty'].fillna(0)

# End of Method 2:  If Monthend Dates are considered -------------------------------------

#print(df1_new)



# Step 5: Work with the data
# print(df1.head())
# print(df2.head())

# Step 6: Always close the connection
conn.close()
print("🔒 Connection closed")

#--------------------------------------------------------------------------------------------



