#Step 1: Implement Authentication with MSAL
import msal
import requests
import pandas as pd
import ssl
# # Azure AD app details
# tenant_id = "50f40674-931c-4d09-ae8a-bb8fde36b912"
# client_id = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
# client_secret = "2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P"
# authority = f'https://login.microsoftonline.com/{tenant_id}'

# # Scopes for SharePoint REST API and Microsoft Graph
# scopes = ['https://graph.microsoft.com/.default', 'Files.Read', 'Sites.Read.All']

# # Redirect URI (same as registered in Azure AD app)
# redirect_uri = 'http://localhost'

# # MSAL app instance
# app = msal.PublicClientApplication(client_id, authority=authority)

# # Step 1: Get authorization URL to prompt user login
# auth_url = app.get_authorization_request_url(scopes, redirect_uri=redirect_uri)

# print("Please go to the following URL and log in:")
# print(auth_url)

# # Step 2: Get the authorization code from the user after login
# auth_code = input("Enter the authorization code you received: ")

# # Step 3: Exchange authorization code for an access token
# result = app.acquire_token_by_authorization_code(
#     auth_code,
#     scopes=scopes,
#     redirect_uri=redirect_uri,
#     client_credential=client_secret
# )

# if "access_token" in result:
#     access_token = result["access_token"]
#     print("Access token obtained successfully.")
# else:
#     print("Error obtaining access token:", result.get("error_description"))
#     exit()


#------------------------------------------------------------------------------------
#Step 1: Token Generation Process

# Azure App Registration details
tenant_id = "50f40674-931c-4d09-ae8a-bb8fde36b912"
client_id = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
client_secret = "2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P"
site_url1 = "https://elgi.sharepoint.com/sites/BIS-IT"
site_url2 = "elgi.sharepoint.com/sites/BIS-IT"
site_url3 = "https://elgi.sharepoint.com/sites/sites/BIS-IT/_api"
server_relative_url = "/sites/BIS-IT/Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.csv"

#Sharepoint URL :https://elgi.sharepoint.com/sites/BIS-IT/_api/web/getFileByServerRelativePath(DecodedUrl='/sites/BIS-IT/Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.xlsx')/$value


# Authentication URL for Microsoft Identity Platform
authority = f"https://login.microsoftonline.com/{tenant_id}"

# Scopes needed to access SharePoint (using App-Only permissions)
#scopes = ["https://graph.microsoft.com/.default"]
scopes = ["https://elgi.sharepoint.com/.default"]

# Initialize MSAL Confidential Client Application
app = msal.ConfidentialClientApplication(client_id, authority=authority, client_credential=client_secret)

# Acquire the access token using client credentials
token_response = app.acquire_token_for_client(scopes)
#print(f"token_response= {token_response}")

if "access_token" in token_response:
    print("Authentication Success")
    # Access token acquired, use it to authenticate with SharePoint
    access_token = token_response["access_token"]
    print(f'access_token={access_token}')


# #Verify the Token
import jwt
#access_token = "your_access_token"
# Decode the JWT token
decoded_token = jwt.decode(access_token, options={"verify_signature": False})
print (f"Decoded Token : \n {decoded_token}")
    
    


#End of Step 1: Token Generation Process

#------------------------------------------------------------------------------------

#Download Excel File from SharePoint

# Site URL and file path (server-relative URL)
site_url = 'https://elgi.sharepoint.com/sites/BIS-IT'
file_relative_url = '/sites/BIS-IT/Shared%20Documents/MasterData/ATS/ATS_Production_Plan_Master.csv'

# SharePoint REST API URL to download the file
sharepoint_api_url = f"{site_url}/_api/web/getfilebyserverrelativeurl('{file_relative_url}')/$value"

# Headers with the access token

#access_token='eyJ0eXAiOiJKV1QiLCJub25jZSI6ImhOUG45dWxCVUhFbG1GYXhTZjNYSWI1U0xoZXV6RWF5VlZkNlp0dm9DWDQiLCJhbGciOiJSUzI1NiIsIng1dCI6IkpETmFfNGk0cjdGZ2lnTDNzSElsSTN4Vi1JVSIsImtpZCI6IkpETmFfNGk0cjdGZ2lnTDNzSElsSTN4Vi1JVSJ9.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC81MGY0MDY3NC05MzFjLTRkMDktYWU4YS1iYjhmZGUzNmI5MTIvIiwiaWF0IjoxNzQzMDUzNDY4LCJuYmYiOjE3NDMwNTM0NjgsImV4cCI6MTc0MzA1NzM2OCwiYWlvIjoiazJSZ1lOaDluZFh2Y05rVit3NXAvWk1kRG9LMUFBPT0iLCJhcHBfZGlzcGxheW5hbWUiOiJQcm9kLVNoYXJlcG9pbnQgQklTLUlUIiwiYXBwaWQiOiI0MDNmYmFjNi1lMjdiLTRmYzQtODY2Zi03ZDg1MjBiYTA5NDEiLCJhcHBpZGFjciI6IjEiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC81MGY0MDY3NC05MzFjLTRkMDktYWU4YS1iYjhmZGUzNmI5MTIvIiwiaWR0eXAiOiJhcHAiLCJvaWQiOiI3NGU5YmMxMy1jMGM4LTRmOTItODRjNC1lMGZmM2EyY2NmNjUiLCJyaCI6IjEuQVVvQWRBYjBVQnlUQ1UydWlydVAzamE1RWdNQUFBQUFBQUFBd0FBQUFBQUFBQUF1QVFCS0FBLiIsInN1YiI6Ijc0ZTliYzEzLWMwYzgtNGY5Mi04NGM0LWUwZmYzYTJjY2Y2NSIsInRlbmFudF9yZWdpb25fc2NvcGUiOiJBUyIsInRpZCI6IjUwZjQwNjc0LTkzMWMtNGQwOS1hZThhLWJiOGZkZTM2YjkxMiIsInV0aSI6IkhXTWJEOFNZN1VtVTRTV2pJYXhoQUEiLCJ2ZXIiOiIxLjAiLCJ3aWRzIjpbIjA5OTdhMWQwLTBkMWQtNGFjYi1iNDA4LWQ1Y2E3MzEyMWU5MCJdLCJ4bXNfaWRyZWwiOiI3IDQiLCJ4bXNfdGNkdCI6MTQ0NzM5MDc0MX0.W4z1JGs5NgaqEHmCMm2ITX3NiVD7-ITfz3mVjwQjVoU3AYMwRARufmW8iEl6Kj5OGlpwgxhVVtUXYrzyIYXH8pCDigQWpFL8wz3Ttjb5NjWZ5RviOXiPPok35zF8rp93oFOIJAW3jnU8XQUk0ddwHI-e44HBPhePiYNpBHhX4mH_vTIWGtC07RL2z6JxAyUWfFJ7sHaiZugOn_GYEjASh2mfheYEsUChHRmRgrmCyt8x3nzs7_jyhcCQbiwf3g7fY8dEvsy85NheQICH_wb6gln6DDHVsn1TUuwBvkjXFAc2lhUsVQo28vpcK2qNfSKSpM20ZqQjxUtLVa9mCkkRdA'

headers = {
    'Authorization': f'Bearer {access_token}',
    'Accept': 'application/json'
}

# Make the GET request to SharePoint API
response = requests.get(sharepoint_api_url, headers=headers,verify='D:\\SSL_Certificates\\netskope2.cer')
#response = requests.get(sharepoint_api_url, headers=headers,verify=False)#,verify='D:\\SSL_Certificates\\sharepoint.pem')
#response = requests.get(sharepoint_api_url, headers=headers)#,verify='D:\\SSL_Certificates\\sharepoint.pem')

print(f"response.content : {response.content}")


if response.status_code == 200:
    # Save the file locally
    with open('downloaded_ExcelFile.xlsx', 'wb') as file:
        file.write(response.content)
    print("Excel file downloaded successfully.")
else:
    print(f"Failed to download file. Status code: {response.status_code}")
    print(response.text)