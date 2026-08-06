import urllib.parse

JDBC_driver="com.infor.idl.jdbc.Driver"
JDBC_URL="jdbc:infordatalake://ELGI_PRD:."
Credentials={'user': 'prakashk@elgi.com', 'pass': 'Valc0me@123'} 
JAR_Path="D:\\dbt\\infor-compass-jdbc-2022.10.jar",  
Driver_Path="D:\\dbt\\"  



BI_Server = 'ELGI-BIS'
BI_db = 'ELGI_US'
username = 'bisadmin'
password = 'ElgiP0w3r@20#23'
BI_username = urllib.parse.quote_plus(username)
BI_password = urllib.parse.quote_plus(password)
#BI_ODBC_Driver=ODBC+Driver+17+for+SQL+Server
