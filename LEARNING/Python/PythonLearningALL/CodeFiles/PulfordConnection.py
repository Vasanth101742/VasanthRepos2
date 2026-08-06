import pyodbc
import pandas as pd

cnxn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
                      "Server=54.252.110.128;"
                      "Database=DW;"
                      "Trusted_Connection=yes;")
df = pd.read_sql_query('select * from [ItemCategory]', cnxn)
print(df)