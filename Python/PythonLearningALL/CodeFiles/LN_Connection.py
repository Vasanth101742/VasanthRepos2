import time

import cx_Oracle
con=cx_Oracle.connect("bis/bis@lnerp-scan.elgi.com:1521/lnerprac")
print("Oracle Connection Version "+con.version +" established Successfully")

#ver = con.version.split(".")
#print(ver)

#print (ver.index("0"))
#print (ver.index("1"))
#print (ver.index("2"))
#print (ver.index("12"))


#ver.remove("2")
#print (ver)

#ver1 = ["11", "g"]
#ver2 = ["R", "2"]
#ver3=ver1 + ver2
#print (ver1 + ver2)

#print(con.version)



cur = con.cursor()
cur.arraysize = 1000 # Limit the no of rows to be fetched

start_time = time.time()

#-----------------------------------------------------------------------------------------------------------------------

#Query Execution

#Method1 :Normal Query Execution #erpnln.ttfgld495400,erpnln.ttfgld495400.T$YEAR,
# erpnln.ttfgld495400.T$URAT$1,
# erpnln.ttfgld495400.T$URAT$2,
# erpnln.ttfgld495400.T$URAT$3,
# erpnln.ttfgld495400.T$ARAT$1,
# erpnln.ttfgld495400.T$ARAT$2,
# erpnln.ttfgld495400.T$ARAT$3,
# erpnln.ttfgld495400.T$DIM1,
# erpnln.ttfgld495400.T$DIM2,
# erpnln.ttfgld495400.T$DIM3,
# erpnln.ttfgld495400.T$DIM4,
# erpnln.ttfgld495400.T$DIM5,
# erpnln.ttfgld495400.T$DIM6,
# erpnln.ttfgld495400.T$DIM7,
# erpnln.ttfgld495400.T$DIM8,
# erpnln.ttfgld495400.T$DIM9,
# erpnln.ttfgld495400.T$DM10,
# erpnln.ttfgld495400.T$DM11,
# erpnln.ttfgld495400.T$DM12,
#erpnln.ttfgld495400.T$FYER,

# erpnln.ttfgld495400.T$LEAC,
#
# erpnln.ttfgld495400.T$DBCR,
# erpnln.ttfgld495400.T$GUID,
# erpnln.ttfgld495400.T$OCMP,

# erpnln.ttfgld495400.T$RBON,
# erpnln.ttfgld495400.T$RBID,
# erpnln.ttfgld495400.T$RPON,
# erpnln.ttfgld495400.T$OBRE,
# erpnln.ttfgld495400.T$BUID,
# erpnln.ttfgld495400.T$TTYP,
# erpnln.ttfgld495400.T$DOCN,
# erpnln.ttfgld495400.T$BTNO,
# erpnln.ttfgld495400.T$LINO,

#
# erpnln.ttfgld495400.T$FPRD,
# erpnln.ttfgld495400.T$KTRN,
# erpnln.ttfgld495400.T$RECO,
# erpnln.ttfgld495400.T$RECS,

# erpnln.ttfgld495400.T$AMTH$1,
# erpnln.ttfgld495400.T$AMTH$2,
# erpnln.ttfgld495400.T$AMTH$3,
# erpnln.ttfgld495400.T$CUNI,
# erpnln.ttfgld495400.T$NUNI,

# erpnln.ttfgld495400.T$FCOM,
# erpnln.ttfgld495400.T$AMNT,
# erpnln.ttfgld495400.T$CCUR,
# erpnln.ttfgld495400.T$SERL,
# erpnln.ttfgld495400.T$SRNO,
#
# erpnln.ttfgld495400.T$RCE1,
# erpnln.ttfgld495400.T$RCE2,
# erpnln.ttfgld495400.T$RCE3,
# erpnln.ttfgld495400.T$RCE4,
# erpnln.ttfgld495400.T$RCE5,
#
# erpnln.ttfgld495400.T$REV1,
# erpnln.ttfgld495400.T$REV2,
# erpnln.ttfgld495400.T$REV3,
# erpnln.ttfgld495400.T$REV4,
# erpnln.ttfgld495400.T$REV5,
# erpnln.ttfgld495400.T$INIC,
# erpnln.ttfgld495400.T$INAD,
# erpnln.ttfgld495400.T$ACCE,
# erpnln.ttfgld495400.T$ACCF


# erpnln.ttfgld495400.T$IDTC,
# erpnln.ttfgld495400.T$TRDT,
# erpnln.ttfgld495400.T$CRDT
#erpnln.ttfgld495400.T$PODT,

cur.execute("""select distinct 
cast(T$DCDT as varchar(20)),*
from erpnln.ttfgld495400 where cast(erpnln.ttfgld495400.T$DCDT as varchar(20))='01-JAN-12' """)

#Method2 :Query Execution using Bind variable
# cur.prepare('select erpnln.ttfgld495400.* from erpnln.ttfgld495400 where erpnln.ttfgld495400.T$rbid= :id')

# cur.execute(None, {'id': '110003478'})
# res = cur.fetchall()
# print(res)
#
# cur.execute(None, {'id': '110002059'})

#-----------------------------------------------------------------------------------------------------------------------
#Fetching row one by one
#row = cur.fetchone()
#print(row)
#row = cur.fetchone()
#print(row)


#Fetching all rows at once
#Method 1:
# res = cur.fetchall()
# print(res)

#Method 2:
for result in cur:
   print(result)


#-----------------------------------------------------------------------------------------------------------------------
end_time = time.time()
elapsed = (end_time - start_time)
print ("\n","Elapsed: ",round(elapsed,2), " seconds")

cur.close()
con.close()

