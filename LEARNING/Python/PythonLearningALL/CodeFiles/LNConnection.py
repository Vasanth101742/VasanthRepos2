import cx_Oracle
from sqlalchemy import create_engine


#Reading from the Oracle database table

oracle_connection_string = (
    'oracle+cx_oracle://bis:bis@' +
    cx_Oracle.makedsn('lnerp-scan.elgi.com', '1521', service_name='lnerprac')
)


# engine = create_engine(
#     oracle_connection_string.format(
#         username='bis',
#         password='bis',
#         hostname='lnerp-scan.elgi.com',
#         port='1521',
#         service_name='lnerprac',
#     )
# )


engine = create_engine(oracle_connection_string)


con=engine.connect() #not working
print(con)
print("LN Connection established Successfully")


import pyodbc
SQL_connection_string = pyodbc.connect('Driver={SQL Server};'
                      'Server=bis-db;'
                      'Database=ELGI_LN;'
                      'UID=sa;'
                      'PWD=Reset123')
