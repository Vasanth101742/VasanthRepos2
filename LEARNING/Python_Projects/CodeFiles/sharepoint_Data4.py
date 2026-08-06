
#Step 1: Authenticate Using MSAL (Client Credentials Flow)

import msal

# Azure AD app registration details
tenant_id = "50f40674-931c-4d09-ae8a-bb8fde36b912"
client_id = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
client_sec = "2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P"
authority = f"https://login.microsoftonline.com/{tenant_id}"

# Microsoft Graph or SharePoint scopes
scopes = ["https://graph.microsoft.com/.default"]  # Scope for Microsoft Graph API

# Initialize MSAL confidential client application
app = msal.ConfidentialClientApplication(
    client_id,
    client_credential=client_sec,
    authority=authority
)

# Get the access token
token_response = app.acquire_token_for_client(scopes=scopes)

if "access_token" in token_response:
    access_token = token_response["access_token"]
    print("Access token acquired Successfully !!")
else:
    print(f"Error: {token_response.get('error')}, {token_response.get('error_description')}")


#--------------------------------------------------------------------------------------------------------

#Step 2: Download the Excel File from SharePoint

import requests

# Define your SharePoint site URL and file path
site_url = "https://elgi.sharepoint.com/sites/BIS-IT"
file_url = "/sites/BIS-IT/Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.xlsx"

# Microsoft Graph API URL to access SharePoint file
graph_url = f"https://graph.microsoft.com/v1.0/sites/{site_url}/drive/root:{file_url}:/content"

# Headers with the access token
headers = {
    'Authorization': f'Bearer {access_token}'
}

#print(graph_url)
#print(headers)
# Send a GET request to download the file
response = requests.get(graph_url, headers=headers)
#print(response)

# Check if the request was successful
if response.status_code == 200:
    # Save the file locally
    with open("ATS_Production_Plan_Master.xlsx", "wb") as local_file:
        local_file.write(response.content)
    print("File downloaded successfully.")
else:
    print(f"Failed to download file. Status code: {response.status_code}, {response._content}")
    exit(0)


#--------------------------------------------------------------------------------------
#Step 3:  Load the Excel file using pandas
import pandas as pd

df = pd.read_excel("downloaded_ExcelFile.xlsx", sheet_name="Sheet1")

# Display the first few rows of the data
print(df.head())