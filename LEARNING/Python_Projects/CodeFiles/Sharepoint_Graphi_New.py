import msal
import requests

# Azure AD app registration details
client_id = '403fbac6-e27b-4fc4-866f-7d8520ba0941'
client_secret = '2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P'
tenant_id = '50f40674-931c-4d09-ae8a-bb8fde36b912'
authority = f"https://login.microsoftonline.com/{tenant_id}"

# Scopes for Microsoft Graph API
scopes = ['https://graph.microsoft.com/.default']

# Site and file details
site_url = 'elgi.sharepoint.com/sites/BIS-IT'
file_path = '/Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.xlsx'
drive_id = 'your-drive-id'

# Authenticate and get access token
app = msal.ConfidentialClientApplication(client_id, authority=authority, client_credential=client_secret)
token_response = app.acquire_token_for_client(scopes=scopes)

if 'access_token' in token_response:
    access_token = token_response['access_token']
else:
    raise Exception("Error obtaining access token")

# Get site_id
site_api_url = f"https://graph.microsoft.com/v1.0/sites/{site_url}"
headers = {'Authorization': f'Bearer {access_token}'}
site_response = requests.get(site_api_url, headers=headers)

if site_response.status_code == 200:
    site_data = site_response.json()
    site_id = site_data['id']
else:
    raise Exception(f"Error retrieving site data: {site_response.status_code}")

# Download file content
# drive_api_url = f"https://graph.microsoft.com/v1.0/sites/{site_id}/drives/{drive_id}/root:{file_path}:/content"
# response = requests.get(drive_api_url, headers=headers)

# Get the list of drives (document libraries) for the site
drive_api_url = f"https://graph.microsoft.com/v1.0/sites/{site_id}/drives"
headers = {'Authorization': f'Bearer {access_token}'}
drive_response = requests.get(drive_api_url, headers=headers)

if drive_response.status_code == 200:
    drives = drive_response.json()
    # List all drives and print their IDs and names
    for drive in drives['value']:
        print(f"Drive Name: {drive['name']}, Drive ID: {drive['id']}")





if response.status_code == 200:
    with open('downloaded_file.xlsx', 'wb') as file:
        file.write(response.content)
    print("File downloaded successfully!")
else:
    raise Exception(f"Error downloading file: {response.status_code}")
