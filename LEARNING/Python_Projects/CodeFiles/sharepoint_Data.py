import office365
import msal
from office365.sharepoint.client_context import ClientContext
from office365.runtime.auth.authentication_context import AuthenticationContext
#from office365.sharepoint.auth.authentication_context import AuthenticationContext 
#from office365.sharepoint.auth import AuthenticationContext

#from authentication_context import AuthenticationContext
from office365.sharepoint.files.file import File
import io
import pandas as pd

# Set up the SharePoint details
tenant_id = "50f40674-931c-4d09-ae8a-bb8fde36b912"
client_id = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
client_sec = "2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P"
site_url = "https://elgi.sharepoint.com/sites/sites/BIS-IT"
file_url = 'Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.xlsx'  # Replace with the file path on SharePoint

# Authenticate using client credentials (OAuth)
context_auth = AuthenticationContext(url=site_url)
#context_auth.acquire_token_for_app(client_id=client_id, client_sec=client_sec, tenant=tenant_id)
context_auth.acquire_token_for_app(client_id=client_id, client_sec=client_sec)
context_auth.verify_ssl = True
# Create a client context

ctx = ClientContext(site_url, context_auth)
print(ctx)
print(ctx.service_root_url)
#print(ctx.service_relative_url) #AttributeError: 'ClientContext' object has no attribute 'service_relative_url'
# Get the file from SharePoint
response = File.open_binary(ctx, file_url)

# Save the file locally (optional)
with open("downloaded_file.xlsx", "wb") as f:
    f.write(response.content)

# Load the Excel file into a pandas DataFrame
with io.BytesIO(response.content) as file_stream:
    df = pd.read_excel(file_stream)

# Display the DataFrame
print(df)











#----------------------------------------------------------

# import msal
# from office365.sharepoint.client_context import ClientContext
# from office365.sharepoint.files.file import File
# import io
# import pandas as pd

# # Azure App Registration details
# tenant_id = "50f40674-931c-4d09-ae8a-bb8fde36b912"
# client_id = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
# client_sec = "2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P"
# site_url = "https://elgi.sharepoint.com/sites/sites/BIS-IT"

# # Authentication URL for Microsoft Identity Platform
# authority = f"https://login.microsoftonline.com/{tenant_id}"

# # Scopes needed to access SharePoint (using App-Only permissions)
# scopes = ["https://graph.microsoft.com/.default"]

# # Initialize MSAL Confidential Client Application
# app = msal.ConfidentialClientApplication(client_id, authority=authority, client_credential=client_sec)

# # Acquire the access token using client credentials
# token_response = app.acquire_token_for_client(scopes)

# if "access_token" in token_response:
#     print("Authentication Success")
#     # Access token acquired, use it to authenticate with SharePoint
#     access_token = token_response["access_token"]
    
#     # Create a context with the access token for SharePoint
#     context = ClientContext(site_url).with_access_token(access_token)
#     print(context)


#     # Get the file from SharePoint
#     response = File.open_binary(context, https://elgi.sharepoint.com/:x:/s/BIS-IT/Ee_eWz1PUylOo7moQfi-I9sBM7J9pcwK24YPCGXmTZiJ0w?e=igdLpQ)
#     # Read the file into a pandas DataFrame
#     with io.BytesIO(response.content) as file_stream:
#         df = pd.read_excel(file_stream)

#     # Display the dataframe
#     print(df)
    
# #     # Get SharePoint List (replace 'Your List Name' with your actual list name)
# #     list_title = "Your List Name"
# #     target_list = context.web.lists.get_by_title(list_title)

# #     # Query list items
# #     items = target_list.items.get().execute_query()

# #     # Print out the list items
# #     for item in items:
# #         print(f"Title: {item.properties['Title']}")  # Modify this according to the fields you want to extract
# # else:
# #     print("Authentication failed. Could not obtain access token.")