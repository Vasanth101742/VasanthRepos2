import io
import pandas as pd
from office365.sharepoint.client_context import ClientContext


import msal
import datetime
from typing import TYPE_CHECKING, AnyStr
from urllib.parse import quote

import requests

from office365.runtime.client_result import ClientResult
from office365.runtime.http.http_method import HttpMethod
from office365.runtime.http.request_options import RequestOptions
from office365.sharepoint.client_context import ClientContext


# Azure App Registration details
tenant_id = "50f40674-931c-4d09-ae8a-bb8fde36b912"
client_id = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
client_secret = "2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P"
site_url1 = "elgi.sharepoint.com/sites/BIS-IT"
site_url2 = "https://elgi.sharepoint.com/sites/sites/BIS-IT/_api"
server_relative_url = "/sites/BIS-IT/Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.xlsx"

#Sharepoint URL :https://elgi.sharepoint.com/sites/BIS-IT/_api/web/getFileByServerRelativePath(DecodedUrl='/sites/BIS-IT/Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.xlsx')/$value


# Authentication URL for Microsoft Identity Platform
authority = f"https://login.microsoftonline.com/{tenant_id}"

# Scopes needed to access SharePoint (using App-Only permissions)
scopes = ["https://graph.microsoft.com/.default"]

# Initialize MSAL Confidential Client Application
app = msal.ConfidentialClientApplication(client_id, authority=authority, client_credential=client_secret)

# Acquire the access token using client credentials
token_response = app.acquire_token_for_client(scopes)
access_token = token_response["access_token"]



# Replace these variables with your actual values
site_url = "https://elgi.sharepoint.com/sites/BIS-IT"  # SharePoint site URL
#access_token = "YOUR_ACCESS_TOKEN"  # Replace with your actual access token
file_relative_url = "/sites/BIS-IT/Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.xlsx"  # Path to the Excel file in SharePoint

# Create the client context using the site URL and access token
context = ClientContext(site_url).with_access_token(access_token)

# Access the SharePoint file
file = context.web.get_file_by_server_relative_url(file_relative_url)

# Create a file-like object to store the content
file_content = io.BytesIO()

# Download the file content into the file-like object
file.download(file_content)  # Pass the file_content (BytesIO) here
context.execute_query()

# Move the cursor of the BytesIO object to the beginning
file_content.seek(0)

# Load the Excel file into a pandas DataFrame
df = pd.read_excel(file_content, engine='openpyxl')

# Show the first few rows of the data
print(df.head())
