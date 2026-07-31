import jaydebeapi
import pandas as pd
import pyodbc
import logging
import datetime
from sqlalchemy import create_engine
import urllib.parse


# # Set up basic configuration for logging
# logging.basicConfig(level=logging.INFO)

# # Create a logger instance
# logger = logging.getLogger(__name__)

# # Logging messages
# logger.debug('This is a debug message.')
# logger.info('This is an info message.')
# logger.warning('This is a warning message.')
# logger.error('This is an error message.')
# logger.critical('This is a critical message.')









# #--------Method 1: Attempted to include slsf4j dependency through pom.xml file --Failed-------
# import xml.etree.ElementTree as ET
# tree=ET.parse('pom.xml')
# root=tree.getroot()

# print(root.tag)
# print(root[0].tag)

# #----------------------------------------------------------------------------------------------



#Define connection parameters
conn1 = jaydebeapi.connect(
    "com.infor.idl.jdbc.Driver",  # JDBC driver class
    "jdbc:infordatalake://ELGI_PRD:.",  # JDBC URL
     {'user': 'prakashk@elgi.com', 'pass': 'Valc0me@123'},  # Credentials (leave blank)
     "D:\\dbt\\infor-compass-jdbc-2022.10.jar",  # Path to JDBC driver JAR
     "D:\\dbt\\"  # Path to directory containing the driver
     #"C:/Users/vasanthk/AppData/Local/DBeaver/plugins/"
)

print("conn1 :",conn1)

##Method 1: Using Cursor Execution
print("Using Cursor Execution")
cursor = conn1.cursor()
print(cursor)
#query = "select bpid,bprl,bptx_ref_compnr,cadr,cast(crdt as date) from ln_tccom100"
query = "select compnr,bpid,nama,prst from ln_tccom100"

# Execute the query
cursor.execute(query)


# Fetch the result and store in a pandas DataFrame
columns = [desc[0] for desc in cursor.description]  # Get column names
rows = cursor.fetchall()

# Fetch and print the results
# for row in rows:
#     print(row)


# Store the result in a DataFrame
df = pd.DataFrame(rows, columns=columns)
#print(df)



# Convert TIMESTAMP_WITH_TIMEZONE to string or datetime if needed
data = []
for row in rows:
    converted_row = []
    for idx, value in enumerate(row):
        if isinstance(value, datetime.datetime):  # Check if the column is of datetime type
            # If it includes a timezone, it might be handled as an aware datetime in Python
            value = value.astimezone(datetime.timezone.utc)  # Convert to UTC, or handle as needed
        converted_row.append(value)
    data.append(converted_row)

df2 = pd.DataFrame(data, columns=columns)
print(df2)


# Close the cursor and connection
cursor.close()
conn1.close()


#Method 1: Using pyodbc
server = 'ELGI-BIS,1433'
database = 'ELGI_US'
username = 'bisadmin'
password = 'ElgiP0w3r@20#23'


#Create the connection string
#connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
# Connect to the SQL Server
conn3 = pyodbc.connect(connection_string)
cursor3=conn3.cursor()
# Insert DataFrame into SQL Server table
if conn3 is None:
     print("pyodbc Connection failed!")
else:
    print("pyodbc Connection Successful!")
    for index, row in df2.iterrows():
         #print(row['compnr'],row['bpid'], row['nama'],row['prst'])
         cursor3.execute
         (
            # "INSERT INTO LN_TCCOM999 (compnr,bpid,nama,prst) VALUES (?,?,?,?)",
            # row['compnr'], row['bpid'], row['nama'],row['prst']

            #"INSERT INTO LN_TCCOM999 (compnr,bpid,nama,prst) VALUES ("+row['compnr']+","+row['bpid']+","+row['nama']+","+row['prst']")"
            
         )

# # Insert multiple rows into SQL Server table
# if conn3 is None:
#     print("Connection failed!")
# else:
#     print("Connection Success!")
#     cursor.executemany("INSERT INTO ln_tccom100 (compnr,bpid,nama,prst) VALUES (?,?, ?, ?)", df2)



# Commit and close the connection
conn3.commit()
cursor3.close()
conn3.close()


##End : Method 1: Using Cursor Execution--------------------------------------------
##Method 2: Using Sqlalchemy Execution----------------------------------------------
# Your SQL Server connection details
#server = '10.50.0.4.database.windows.net'  # e.g., 'localhost' or 'your_server_ip'
server = 'ELGI-BIS'
database = 'ELGI_US'
username = 'bisadmin'
password = 'ElgiP0w3r@20#23'
encoded_username = urllib.parse.quote_plus(username)
encoded_password = urllib.parse.quote_plus(password)

# # Method 1: Create the SQLAlchemy engine for the SQL Server connection
#connection_string = "mssql+pyodbc://{username}:{password}@{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server"
#connection_string = 'mssql+pyodbc://{username}:{password}@{server}/{database}?trusted_connection=yes&driver=SQL+Server+Native+Client+11.0'
#connection_string = 'mssql+pyodbc://{username}:{password}@{server}/{database}?trusted_connection=yes&driver=ODBC+Driver+17+for+SQL+Server'
#connection_string = 'mssql+pyodbc://{username}:{password}@{server}/{database}?trusted_connection=yes&driver=ODBC+Driver+17+for+SQL+Server'
#connection_string = 'mssql+pyodbc://bisadmin:{password}@ 10.50.0.4/ELGI_US?driver=ODBC+Driver+17+for+SQL+Server'
connection_string = f'mssql+pyodbc://{encoded_username}:{encoded_password}@{server}/{database}?&driver=ODBC+Driver+17+for+SQL+Server'
engine = create_engine(connection_string,fast_executemany=True)

#engine = create_engine(connection_string,fast_executemany=True)
print(engine.connect)

if engine.connect is None:
    print('SQLAlchemy Conncetion Failed')
#Connect to the database
with engine.connect() as connection:
    print("SQLAlchemy engine Connected successfully to SQL Server")
    df2.to_sql("ln_tccom100",con=engine,schema="dbo",if_exists="append",index=False)
    print("Data Insert Successful !!")

# try:
#     connection = engine.connect()
#     print("SQLAlchemy connection successful!")
#     connection.close()
# except Exception as e:
#     print(f"Error: {e}")

# # Write DataFrame to SQL Server table
# df.to_sql('LN_TCCOM100', con=engine, if_exists='replace', index=False)

# print("Data written to SQL Server successfully!")


##Method 2: Using Direct Execution--------------------------------------------------
# print ("Using Direct Exeution")
# conn2 = pyodbc.connect(conn)
# df = pd.read_sql(query, conn2)
# print(df)
# conn2.close()

##End : Method 1: Using Direct Execution--------------------------------------------

##----------------------------------------------------------------------------------

# import pyodbc

# # Define the DSN, username, and password
# dsn = 'jdbc:infordatalake://ELGI_PRD'
# user = 'ELGI_PRD~bS9_c2rQHql1GvKYvaaMmEBeUq_NTCSqlxh4S4HicKI'
# password = 'ZSPl4Q9wmB5zFV1Puv4r-tiHwo4p9zSFoxF0p_SkQ4v4oDlz75gYMla7URNrlB8uCIappvVzHqDzOdt9rAIM4Q'

# # Establish the connection
# conn = pyodbc.connect(f'DSN={'infordatalake://ELGI_PRD'};UID={'ELGI_PRD~bS9_c2rQHql1GvKYvaaMmEBeUq_NTCSqlxh4S4HicKI'};PWD={'ZSPl4Q9wmB5zFV1Puv4r-tiHwo4p9zSFoxF0p_SkQ4v4oDlz75gYMla7URNrlB8uCIappvVzHqDzOdt9rAIM4Q'}')

# # Create a cursor from the connection
# cursor = conn.cursor()

# # Execute a query
# cursor.execute("SELECT * FROM your_table_name")

# # Fetch and print the results
# rows = cursor.fetchall()
# for row in rows:
#       print(row)

