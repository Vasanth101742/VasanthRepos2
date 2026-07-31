import jaydebeapi
import pandas as pd
import pyodbc
import logging
import datetime
from sqlalchemy import create_engine
import urllib.parse
import params


src_conn = jaydebeapi.connect(params.JDBC_driver,params.JDBC_URL,params.Credentials,
                              params.JAR_Path,params.Driver_Path)
#print("\n Infor LN DataLake connected successfully !! \n")
#print("conn1 :",src_conn)


cursor = src_conn.cursor()
print(cursor)
query = "select compnr,bpid,nama,prst from ln_tccom100"
cursor.execute(query)
columns = [desc[0] for desc in cursor.description]
rows = cursor.fetchall()
df = pd.DataFrame(rows, columns=columns)
#print(df)


data = []
for row in rows:
    converted_row = []
    for idx, value in enumerate(row):
        if isinstance(value, datetime.datetime):  
            value = value.astimezone(datetime.timezone.utc) 
        converted_row.append(value)
    data.append(converted_row)

df2 = pd.DataFrame(data, columns=columns)
print(df2)

cursor.close()
src_conn.close()

#-----------------------------------------------------------------------------

conn= f'DRIVER={{SQL Server}};SERVER={params.BI_Server};DATABASE={params.BI_db};UID={params.BI_username};PWD={params.password}'
dest_conn1 = pyodbc.connect(conn)


TableNames=['ln_tccom100']

cursor1=dest_conn1.cursor()
#cursor1.execute("""use Pythonsql""")
sql="delete from ln_tccom100"
cursor1.execute(sql)

# if dest_conn1 is None:
#      print('BI Azure Server Connection Failed through pyodbc Connectivity')
# else:
#     print("BI Azure Server Connected successfully for Initialization !!")
#     for item in TableNames:
#          #print(row['compnr'],row['bpid'], row['nama'],row['prst'])
#          print(item)
#          #cursor.execute( "Truncate Table ln_tccom100")
#          cursor.execute(f"delete from {item}")
#          print('Truncation process completed')
#          dest_conn1.commit
dest_conn1.commit()
cursor1.close()
dest_conn1.close()

