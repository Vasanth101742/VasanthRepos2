import pyodbc

SQL_connection_string = pyodbc.connect('Driver={SQL Server};'
                      'Server=bis-db;'
                      'Database=ELGI_LN;'
                      'UID=sa;'
                      'PWD=Reset123')
print("SQL Server Connection established Successfully")