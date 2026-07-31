import pyodbc
import pandas as pd

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

query = "select * from (\
select invoice_date,Sum(deliveryQty) Qty ,sum(sales_amount) sales_amount \
from elgi_sales_details \
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-24))) \
and Item_desc is not null \
and ltrim(rtrim(item))='S03260'\
group by invoice_date)a \
where Qty<>0"


df = pd.read_sql_query(query, conn)
print(f"📦 Retrieved {len(df)} rows with columns: {', '.join(df.columns)}")

# Step 5: Work with the data
print(df.head())

# Step 6: Always close the connection
conn.close()
print("🔒 Connection closed")

#--------------------------------------------------------------------------------------------



