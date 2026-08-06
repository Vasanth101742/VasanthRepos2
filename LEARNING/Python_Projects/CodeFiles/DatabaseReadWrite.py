#Pandas Tutorial 14: Read Write Data From Database (read_sql, to_sql)
#Source: https://www.youtube.com/watch?v=M-4EpNdlSuY&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=21


#python -m pip install --upgrade pip --user #xecute this command in the terminal window for upgradation
#python -m pip install sqlalchemy --user  #install this package by executing this command in the terminal window
#python -m pip install pyodbc --user

#Old Method-------------------------------------------------------------------------------------------------------------

# import pandas as pd
# import numpy as np

# import cx_Oracle
# con=cx_Oracle.connect("bis/bis@lnerp-scan.elgi.com:1521/lnerprac")
# print("Oracle Connection Version "+con.version +" established Successfully")
#
#
# # cur = con.cursor()
# # cur.execute('select erpnln.tcisli305400.* from erpnln.tcisli305400')
# # for result in cur:
# #     print(result)
# # cur.close()
#
#
# cur = con.cursor()
# cur.execute("select erpnln.ttfgld495465.* from erpnln.ttfgld495465 where T$rbid='100000701' and T$rpon=10 ")
# for result in cur:
#     print(result)
# cur.close()
# con.close()


#-----------------------------------------------------------------------------------------------------------------------
#New Method


import pandas as pd
import cx_Oracle
#import sqlalchemy
from sqlalchemy import create_engine
import pyodbc

#print('Python: ' + version.split('|')[0])
print('Pandas: ' + pd.__version__)
print('pyODBC: ' + pyodbc.version)


#Reading from the Oracle database table

oracle_connection_string = (
    'oracle+cx_oracle://bis:bis@' +
    cx_Oracle.makedsn('lnerp-scan.elgi.com', '1521', service_name='lnerprac')
)

engine = create_engine(
    oracle_connection_string.format(
        username='bis',
        password='bis',
        hostname='lnerp-scan.elgi.com',
        port='1521',
        service_name='lnerprac',
    )
)

#engine = sqlalchemy.create_engine('oracle://bis:bis@lnerp-scan.elgi.com:1521/lnerprac')
print("Oracle Connection established Successfully")


con=engine.connect() #not working
print(con)
a=pd.read_sql("select erpnln.tcisli305400.t$sfcp,erpnln.tcisli305400.t$tran from erpnln.tcisli305400",engine)
a=pd.DataFrame(a)
print(a)

con.close()

#-----------------------------------------------------------------------------------------------------------------------
#Writing into the SQL database table


# from IPython.display import YouTubeVideo
# YouTubeVideo("uoLE14ZLkUM")

#Azure connection
#import pyodbc
#conn = pyodbc.connect(DRIVER='SQL Server',SERVER='bis-db',DATABASE='ELGI_LN',UID='elgi\\bisadmin',PWD='Reset123')


import pyodbc
conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=bis-db;'
                      'Database=ELGI_LN;'
                      'UID=sa;'
                      'PWD=Reset123')
print(conn)

# cursor = conn.cursor()
# cursor.execute('SELECT top 10 * FROM ELGI_LN.dbo.Elgi_sales_details')

# for row in cursor:
#     a = row
#     a = pd.DataFrame(a)
#     #print(row)
#
# #a=pd.DataFrame(a)
# #print(a)



tableResult = pd.read_sql_query("SELECT top 10 * FROM ELGI_LN.dbo.Elgi_sales_details where areaname like '%coim%'", conn)
#tableResult=pd.DataFrame(tableResult) #Not required as already it is a data frame
print(tableResult)
print(type(tableResult))

