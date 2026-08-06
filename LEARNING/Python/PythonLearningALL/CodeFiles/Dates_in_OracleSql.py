import pandas as pd
from sqlalchemy import create_engine
import LNConnection as LN
import numpy as np
import re
#-----------------------------------------------------------------------------------------------------------------------

engine = create_engine(LN.oracle_connection_string)
con=engine.connect()
#401

Company=[400,411,412,413,414,415,551,552,600]#,416,417,418,419,420,440,450,465,470,480,490,500,581,611,612,613,614,615,616,617,618,619,620,621,622,640,951]
a=pd.DataFrame() #Empty dataframe

Query ="select sysdate,cast(sysdate-1 as date) from dual"
Sysdate=pd.DataFrame.append(a, pd.read_sql(Query, engine))
print(Sysdate)

for count1 in Company:
    print("Fetcing data for :ttdsls400" + str(count1))
    Query = "select " + str(count1) + '''as company, t$odat as orderdate,t$orno as orderno,t$ofbp as custcode,
    t$oref as segment, t$cbrn as lobcode, t$crep as salesrepcode
    from erpnln.ttdsls400''' + str(count1)  +" where cast(t$odat as date) > "+ "cast(sysdate-1 as date)"
    #" where cast(t$odat as date) > '26/Feb/2020' "
    # +" and  "+str(count1)+" =401"
    a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
ttdsls400=a
print(ttdsls400)