import jaydebeapi
import pandas as pd
import pyodbc
import logging
import datetime
from sqlalchemy import create_engine
from sqlalchemy.types import Integer, String,DateTime, Integer, String, TIMESTAMP
import urllib.parse
import params
from tqdm import tqdm
import time

src_conn = jaydebeapi.connect(params.JDBC_driver,params.JDBC_URL,params.Credentials,
                              params.JAR_Path,params.Driver_Path)
print("")
print("\nInfor LN DataLake connected successfully !! \n")
#print("conn1 :",src_conn)


conn= f'DRIVER={{SQL Server}};SERVER={params.BI_Server};DATABASE={params.BI_db};UID={params.BI_username};PWD={params.password}'
dest_conn1 = pyodbc.connect(conn)

if dest_conn1 is None:
     print('BI Azure Server Connection Failed through pyodbc Connectivity')
else:
    print("")
    print("BI Azure Server Connected successfully for Truncation !! \n")


dest_conn2 = f'mssql+pyodbc://{params.BI_username}:{params.BI_password}@{params.BI_Server}/{params.BI_db}?&driver=ODBC+Driver+17+for+SQL+Server'
engine = create_engine(dest_conn2,fast_executemany=True)
#print(engine.connect)

if engine.connect is None:
    print('BI Azure Server Connection Failed through Sqlalchemy Connectivity')
#Connect to the database
with engine.connect() as connection:
    print("")
    print("BI Azure Server Connected successfully for Data Loading !! \n")


Queries = [
        #"select compnr,bpid,nama,prst from ln_tccom100",
           "select null as adrs,null as adrs_ref_compnr,amnt,amth_1,amth_2,amth_3,amth_dtwc,amth_rfrc,\
            amti,null as arrq,null as arrq_kw,null as baca_1,null as baca_2,null as baca_3,null as baca_dtwc,\
			null as baca_invc,null as baca_rfrc,null as baco,\
            null as bahc_1,null as bahc_2,null as bahc_3,null as bahc_dtwc,null as bahc_rfrc,null as bala,\
			null as balc,null as balh_1,null as balh_2,null as balh_3,null as balh_dtwc,\
            null as balh_rfrc,null as bank,null as basi,null as bdsp,null as bdsp_kw,null as bkrn,null as bppn,\
			null as bpri,null as btno,null as cain,null as cain_kw,null as ccrs,null as ccrs_ref_compnr,\
            ccur,null as ccur_ref_compnr,cdam_1,null as cdam_2,null as cdam_3,null as cdam_dtwc,\
			null as cdam_invc,null as cdam_rfrc,null as cdf_rema,null as cfrs,\
            null as cfrs_ref_compnr,compnr,null as cpay,null as cpay_ref_compnr,null as crep,\
			null as crep_ref_compnr,null as csbi,null as cvat,null as cvat_ref_compnr,\
            null as dbnt,null as dbnt_kw,null as dc1a,dc1h_1,null as dc1h_2,null as dc1h_3,null as dc1h_dtwc,\
			null as dc1h_rfrc,null as dc1i,null as dc2a,null as dc2h_1,null as dc2h_2,null as dc2h_3,\
            null as dc2h_dtwc,null as dc2h_rfrc,null as dc2i,null as dc3a,null as dc3h_1,null as dc3h_2,null as dc3h_3,\
			null as dc3h_dtwc,null as dc3h_rfrc,null as dc3i,null as deleted,null as did1,\
            null as did2,null as did3,null as dim1,null as dim2,null as dim3,null as dim4,null as dim5,null as dim6,\
			null as dim7,null as dim8,null as dim9,null as dm10,null as dm11,null as dm12,null as doca,docd,docn,\
			null as doub,null as doub_kw,dued,null as fact,null as fact_kw,null as fcmh_1,null as fcmh_2,null as fcmh_3,\
			null as fcmi,null as fcmt,itbp,null as itbp_ref_compnr,null as lamt,null as lapa,\
            null as laph_1,null as laph_2,null as laph_3,null as laph_dtwc,null as laph_rfrc,null as lapi,null as lcdt,\
			null as leac,null as leac_ref_compnr,null as lett,null as line,null as lino,\
            null as liqd,null as lmbi,null as lmbi_kw,null as lpdt,null as lvat,null as lvat_kw,null as mbno,ninv,\
			null as nuid,null as ofbp,null as oinv,null as opbp,null as opbp_ref_compnr,null as orno,\
            null as osch,null as otyp,null as otyp_ref_compnr,null as owbk,owbk_ref_compnr,null as pada,padh_1,\
			null as padh_2,null as padh_3,null as padh_dtwc,null as padh_rfrc,\
            null as padi,null as paym,null as paym_ref_compnr,null as pdat,null as pfbp,null as pfbp_bank_ref_compnr,\
			null as pfbp_ref_compnr,null as post,null as pref,null as pref_ref_compnr,\
            null as prob,null as prob_ref_compnr,prod,null as proj,null as prop,null as pysh,null as pysh_kw,\
			null as rade,null as rade_kw,\
            TO_DATE(ratd,'yyyy-mm-dd') ratd,\
			rate_1,null as rate_2,null as rate_3,null as ratf_1,\
            null as ratf_2,null as ratf_3,null as rcod,null as rcom,null as rcpt,null as rcpt_kw,null as reas,\
			null as reas_ref_compnr,null as recd,null as recl,null as rect,null as refr,null as regc,null as regc_ref_compnr,\
            null as rtyp,null as sbid,null as schn,null as sequencenumber,null as sgtp,null as sgtp_kw,null as stat,null as stat_kw,\
			null as step,null as step_kw,null as styp,null as styp_ref_compnr,null as svah_1,\
            null as svah_2,null as svah_3,null as svam,null as tbrl,null as tdoc,null as tdoc_ref_compnr,null as text,null as text_ref_compnr,\
			TO_DATE(timestamp,'yyyy-mm-dd') timestamp,\
			null as tnrn,null as tore_1,null as tore_2,\
            null as tore_3,null as tore_dtwc,null as tore_invc,null as tore_rfrc,trec,trec_kw,ttyp,\
			null as ttyp_ref_compnr,null as txdt,null as txtb,null as txtb_ref_compnr,null as typa,\
            null as typa_ref_compnr,null as user,null as username,null as vata,null as vatc,null as vatc_cvat_ref_compnr,\
			null as vatc_ref_compnr,null as vath_1,null as vath_2,null as vath_3,null as vath_dtwc,\
            null as vath_rfrc,null as vati,null as vatp,null as vaty,null as wros,null as wros_kw,[year] from ln_tfacr200"
        ]
TableNames=[#'ln_tccom100',
    "ln_tfacr200_TST"]
        
count1=0

for query in Queries:
#for query in tqdm(Queries, desc="Loading data", unit="query"):
    time.sleep(0.05)
    #print("Source Query under execution :"+Queries[count1]) 
    #print("BI Table to be Loaded :"+TableNames[count1])
    print(f"BI Table to be Loaded : {TableNames[count1]}")
    start_time = time.time()
    cursor = src_conn.cursor()
    #print(cursor)
    cursor.execute(query)
       
    # print("Column Metadata:")

    # a=[desc[2] for desc in cursor.description]
    # print(a)
    
    # for desc in cursor.description:
    #     print(desc)

    #for desc in cursor.description:
        #print(f"Column Name: {desc[0]}")
        #print(f"Type Code: {desc[1]}")
        #print(f"Display Size: {desc[2]}")
        #print(f"Internal Size: {desc[3]}")
        #print('-' * 30)

    columns = [desc[0] for desc in cursor.description]
    rows = cursor.fetchall()
    df = pd.DataFrame(rows, columns=columns)
    end_time2 = time.time()
    elapsed_time2 = end_time2 - start_time
    print("Source Data Fetching completed for :"+TableNames[count1]+f" in {elapsed_time2:.2f} seconds")
    #print(columns)
    #print(df)
    #print(df.dtypes)

    # for column in columns:
    #     i=0
    #     print(column,df.dtypes.iloc[i])
    #     i=i+1




    # data = []
    # for row in rows:
    #     converted_row = []
    #     for idx, value in enumerate(row):
    #         if isinstance(value, datetime.datetime):  
    #             value = value.astimezone(datetime.timezone.utc) 
    #         converted_row.append(value)
    #     data.append(converted_row)
    
    # df2 = pd.DataFrame(data, columns=columns)
    # #print(df2)

    cursor.close()
    
    
    cursor=dest_conn1.cursor()
    cursor.execute( "Truncate Table "+ TableNames[count1])
    dest_conn1.commit()

    cursor.close()
    
    #dtype_mapping = {'did1': TIMESTAMP(timezone=True)}
    dtype_mapping = {'did1': String(50),
                     'did2': String(50),
                     'did3': String(50),
                     'docd': String(50),
                     'dued': String(50),
                     'lcdt': String(50),
                     'liqd': String(50),
                     'lpdt': String(50),
                     'pdat': String(50),
                     'prop': String(50),
                     'ratd': String(50),
                     'timestamp': String(50),
                     'txdt': String(50)

                     }


    chunksize = 1000
    total_chunks = len(df) // chunksize + (1 if len(df) % chunksize != 0 else 0)
    with tqdm(total=total_chunks, desc="Loading data", unit="chunk") as pbar:
        for i in range(0, len(df), chunksize):
            # Get the current chunk of data
            chunk = df.iloc[i:i+chunksize]
            chunk.to_sql(TableNames[count1],con=engine,schema="dbo",if_exists="append",index=False,
                         #dtype=dtype_mapping
                         )
            pbar.update(1)

    #df.to_sql(TableNames[count1],con=engine,schema="dbo",if_exists="append",index=False,dtype=dtype_mapping)
    print("Data Insert Successful for "+TableNames[count1])
    end_time = time.time()
    elapsed_time = end_time - start_time
    print(f"Elapsed time: {elapsed_time:.2f} seconds")
    count1=count1+1
    


src_conn.close()
dest_conn1.close()
#dest_conn2.close()


#-----------------------------------------------------------------------------





# #cursor.execute( "Truncate Table ln_tccom100")

# if dest_conn1 is None:
#      print('BI Azure Server Connection Failed through pyodbc Connectivity')
# else:
#     print("BI Azure Server Connected successfully for Initialization !!")
#     for item in TableNames:
#          #print(row['compnr'],row['bpid'], row['nama'],row['prst'])
#          print(item)
#          cursor.execute( "Truncate Table "+ item)
#          #cursor.execute(f"delete from {item}")
#          print('Truncation process completed')

# dest_conn1.commit()
# cursor.close()
# dest_conn1.close()


# #-----------------------------------------------------------

# #engine = create_engine(connection_string,fast_executemany=True)


    

