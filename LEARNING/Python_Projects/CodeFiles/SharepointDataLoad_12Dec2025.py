from office365.sharepoint.client_context import ClientContext
from office365.runtime.auth.client_credential import ClientCredential
import pandas as pd
from io import BytesIO
import pyodbc

# -----------------------------
# SharePoint App-only Settings
# -----------------------------
tenant = "yourtenant"  # e.g. contoso
site_name = "yoursite"  # e.g. FinanceTeamSite

site_url = f"https://{tenant}.sharepoint.com/sites/{site_name}"

client_id = "YOUR-CLIENT-ID"
client_secret = "YOUR-CLIENT-SECRET"

# File in SharePoint
file_url = "/sites/yoursite/Shared Documents/folder/YourFile.xlsx"

# -----------------------------
# Authenticate using App Credentials
# -----------------------------
credentials = ClientCredential(client_id, client_secret)
ctx = ClientContext(site_url).with_credentials(credentials)

# -----------------------------
# Download file from SharePoint
# -----------------------------
file_obj = BytesIO()

sp_file = ctx.web.get_file_by_server_relative_url(file_url)
sp_file.download(file_obj).execute_query()

file_obj.seek(0)

# -----------------------------
# Convert file to pandas DataFrame
# -----------------------------
if file_url.lower().endswith(".csv"):
    df = pd.read_csv(file_obj)
else:
    df = pd.read_excel(file_obj)

print("Downloaded rows:", len(df))

# -----------------------------
# SQL Server connection
# -----------------------------
conn = pyodbc.connect(
    "Driver={ODBC Driver 17 for SQL Server};"
    "Server=YOUR_SQL_SERVER;"
    "Database=YOUR_DATABASE;"
    "Trusted_Connection=yes;"  # or use UID/PWD
)

cursor = conn.cursor()
cursor.fast_executemany = True

# -----------------------------
# Insert DataFrame rows into SQL Server table
# -----------------------------
table_name = "YourTable"

columns = ",".join(df.columns)
placeholders = ",".join(["?"] * len(df.columns))

sql = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"

cursor.executemany(sql, df.values.tolist())
conn.commit()

cursor.close()
conn.close()

print("✅ Data successfully written to SQL Server!")
