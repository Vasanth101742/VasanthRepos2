import pandas as pd
from sqlalchemy import create_engine
import LNConnection as LN
import BIConnection as BI
#Similarly do for SQL Server Connection Also
#-----------------------------------------------------------------------------------------------------------------------
engine = create_engine(LN.oracle_connection_string)
con=engine.connect()
#print(con)
a=pd.read_sql("select erpnln.tcisli305400.t$sfcp,erpnln.tcisli305400.t$tran from erpnln.tcisli305400",engine)
a=pd.DataFrame(a)
print(a)

con.close()




b = pd.read_sql_query("SELECT top 10 * FROM ELGI_LN.dbo.Elgi_sales_details where areaname like '%coim%'", BI.SQL_connection_string)
#tableResult=pd.DataFrame(tableResult) #Not required as already it is a data frame
print(b)
print(type(b))
