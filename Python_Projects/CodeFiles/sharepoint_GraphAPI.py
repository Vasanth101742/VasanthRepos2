import msal
from office365.sharepoint.client_context import ClientContext
# from office365.runtime.auth.authentication_context import AuthenticationContext
# from office365.sharepoint.files.file import File
# import io
# import pandas as pd
import requests

from urllib.parse import quote
from office365.runtime.http.request_options import RequestOptions
from office365.runtime.http.http_method import HttpMethod
#import certify



# Suppress SSL verification warning
# import urllib3
# urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


#Step 1: Token Generation Process

# Azure App Registration details
tenant_id = "50f40674-931c-4d09-ae8a-bb8fde36b912"
client_id = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
client_secret = "2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P"
#site_url1 = "https://elgi.sharepoint.com/sites/BIS-IT"
site_url2 = "https://elgi.sharepoint.com/sites/BIS-IT"
#site_url2 = "elgi.sharepoint.com/sites/ISMS/IT-Infra"
#site_url2 = "elgi.sharepoint.com/sites/ISMS/ELGi_NA"
#site_url3 = "https://elgi.sharepoint.com/sites/sites/BIS-IT/_api"
server_relative_url = "/Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.xlsx"
#server_relative_url = "sites/ISMS/IT-Infra/Shared%20Documents/pamlog.xls"
#server_relative_url = "sites/ELGi_NA/Shared%20Documents/pamlog.xls"

#Sharepoint URL :https://elgi.sharepoint.com/sites/BIS-IT/_api/web/getFileByServerRelativePath(DecodedUrl='/sites/BIS-IT/Shared Documents/MasterData/ATS/ATS_Production_Plan_Master.xlsx')/$value


# Authentication URL for Microsoft Identity Platform
authority = f"https://login.microsoftonline.com/{tenant_id}"

# Scopes needed to access SharePoint (using App-Only permissions)
scopes = ["https://graph.microsoft.com/.default"]
#scopes = ["https://elgi.sharepoint.com/.default"]

# Initialize MSAL Confidential Client Application
app = msal.ConfidentialClientApplication(client_id, authority=authority, client_credential=client_secret)


# Acquire the access token using client credentials
token_response = app.acquire_token_for_client(scopes)
#print(f"token_response= {token_response}")

#End of Step 1: Token Generation Process

# #Step 2.1: # Authentication based on Username and Password

# context_auth = AuthenticationContext(site_url1)
# context = ClientContext(site_url1, context_auth)
# username='vasanthk'
# password='Elgi@0079'
# if context_auth.acquire_token_for_user(username, password):
#     print("Authentication Success")
#     #Download the file content
#     response = File.open_binary(context, server_relative_url)

# #End of Step 2.1: # Authentication based on Username and Password


if "access_token" in token_response:
    print("\n Authentication Success !! ")
    # Access token acquired, use it to authenticate with SharePoint
    access_token = token_response["access_token"]
    print(f'access_token={access_token}')

    access_token2=token_response.get("access_token")
    print(f'\naccess_token={access_token2}\n')

    # Create a context with the access token for SharePoint
    context = ClientContext(site_url2).with_access_token(access_token2)
    #print(f"context :{context}")
    #print(f"context.service_root_url :{context.service_root_url}")

    #Method 1:
    # Get the file from SharePoint using the File class and download it
    
    # response = File.open_binary(context, server_relative_url)
    
    #Observed that the below code from above File.open_binary from Standard python script is not functioning properly
    
#     url = quote(
#             r"{0}/web/getFileByServerRelativePath(DecodedUrl='{1}')/\$value".format(context.service_root_url(), server_relative_url),
#             safe=":/",
#         )
#     print(url)
    # request = RequestOptions(url)
    # request.method = HttpMethod.Get
    # response = context.pending_request().execute_request_direct(request)
    # print(f"response :{response}")

    #Method 2: Direct URL Feed

    # Define headers with the Bearer token for authentication
    headers = {
    "Authorization": f"Bearer {access_token}",
    "Accept": "application/json",
    #"Accept":"application/x-www-form-urlencoded"
    #"Content-Type":"application/x-www-form-urlencoded"
    #"grant_type":"client_credentials&client_id=403fbac6-e27b-4fc4-866f-7d8520ba0941@50f40674-931c-4d09-ae8a-bb8fde36b912&client_secret=2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P&resource=00000003-0000-0ff1-ce00-000000000000/elgi.sharepoint.com@50f40674-931c-4d09-ae8a-bb8fde36b912"
}
    #url="https://elgi.sharepoint.com/sites/BIS-IT/_api/web/getFileByServerRelativePath(DecodedUrl='/sites/BIS-IT/Shared%20Documents/MasterData/ATS/ATS_Production_Plan_Master.csv')/$value"
    url=site_url2+server_relative_url
    #url="https://elgi.sharepoint.com/:x:/s/BIS-IT/Ee_eWz1PUylOo7moQfi-I9sBM7J9pcwK24YPCGXmTZiJ0w?e=PpLKtl"
    #url="https://elgi.sharepoint.com/sites/BIS-IT/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FBIS%2DIT%2FShared%20Documents%2FMasterData%2FATS&viewid=f622d9cb%2Dd82b%2D488b%2Db960%2D38d36972f64f"
    print(url)
    
    

    #response = requests.get(url,headers=headers,verify='D:\\SSL_Certificates\\netskope2.cer')#,verify=False)
    response = requests.get(url,headers=headers,verify='D:\\SSL_Certificates\\netskope2.cer')#,verify=False)
    print(f"response.status_code :{response.status_code}")
    print(f"response.text:{response.text}")
    print(f"response.content:{response.content}")
       
    # # # Read the file into a pandas DataFrame
    # with io.BytesIO(response.content) as file_stream:
    #      print(f"file :{file_stream}")
    #      file_content = io.BytesIO()
    #      print(f"file_content :{file_content}")
    #      file_content = file_stream.download(file_content)
    #      df = pd.read_excel(file_stream)


    # # Display the dataframe
    # print(df)

    
    # # #Method 2:
    # file = context.web.get_file_by_server_relative_url(server_relative_url)
    # print(f"file :{file}")
    # # # Create a file-like object to store the content
    # file_content = io.BytesIO()
    
    # # # Download the file content into memory
    # file_content = file.download(file_content)
    # print(f"file_content :{file_content}")
    # context.execute_query()

    # # # Read the Excel file from the downloaded content (as bytes)
    # # excel_data = io.BytesIO(file_content.content)

    # # # Load the Excel file into a pandas DataFrame
    # # df = pd.read_excel(excel_data, engine='openpyxl')

    # # # Show the first few rows of the data
    # # print(df.head())



    # #Method 3:  Microsoft Graph endpoint to access the file by server-relative URL
    # graph_url = f"https://graph.microsoft.com/v1.0/sites/{site_url2}/drive/root:{server_relative_url}:/content"
    # headers = {"Authorization": f"Bearer {access_token2}"}
    # #print(f"headers={headers}")
    
    
    # #Verify the Token
    import jwt
    #access_token = "your_access_token"
    # Decode the JWT token
    decoded_token = jwt.decode(access_token2, options={"verify_signature": False})
    print (f"Decoded Token :{decoded_token}")
    
    
       
    # # Make the request to download the Excel file
    # response = requests.get(graph_url, headers=headers)#,verify='/path/to/sharepoint.crt')
    # print(f"response={response}")


    # if response.status_code == 200:
    with open("ATS_Production_Plan_Master.xlsx", "wb") as file:
            file.write(response.content)
            print("Excel file downloaded successfully.")
    #else:
    #     print(f"Error downloading file: {response.status_code}")
    #     print(response.text)

    

    # site_api_url = f"https://graph.microsoft.com/v1.0/sites/{site_url2}"
    # headers = {'Authorization': f'Bearer {access_token2}'}
    # site_response = requests.get(site_api_url, headers=headers)
    # print(f"response={response}")