

import requests


tenant_id = "50f40674-931c-4d09-ae8a-bb8fde36b912"
client_id = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
client_secret = "2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P"
tenant_name="elgi"
headers = { "Content-Type": "application/x-www-form-urlencoded" }




def get_spo_access_token(client_id, client_secret, tenant_id, tenant_name,headers):
    url = f"https://login.microsoftonline.com/{tenant_id}/oauth2/token"
    headers=headers

    data = {
        "grant_type": "client_credentials",
        "client_id": client_id,
        "client_secret": client_secret,
        "resource": f"https://{tenant_name}.sharepoint.com"
    }

    response = requests.post(url, headers=headers, data=data)

    if response.status_code == 200:
        print("Token Generation Success")
        response_data = response.json()
        return response.json().get("access_token")
        
    else:
        print("Token error:", response.status_code)
        print(response.text)
        return None

      
access_token=get_spo_access_token(client_id, client_secret, tenant_id, tenant_name,headers)
#print(f"SharpointToken : \n {access_token}")



# #Verify the Token
import jwt
#access_token = "your_access_token"
# Decode the JWT token
decoded_token = jwt.decode(access_token, options={"verify_signature": False})
print (f"Decoded Token :\n {decoded_token}")



site_url = 'https://elgi.sharepoint.com/sites/BIS-IT'
file_relative_url = '/sites/BIS-IT/Shared%20Documents/MasterData/ATS/ATS_Production_Plan_Master.csv'

# SharePoint REST API URL to download the file
sharepoint_api_url = f"{site_url}/_api/web/getfilebyserverrelativeurl('{file_relative_url}')/$value"
print(f"sharepoint_api_url : \n {sharepoint_api_url}")

headers = { 'Authorization': f'Bearer {access_token}',
    "Content-Type": "application/x-www-form-urlencoded" }





response = requests.get(sharepoint_api_url, headers=headers,verify='D:\\SSL_Certificates\\netskope2.cer')
print(f"response.status_code :{response.status_code}")
print(f"response.content:{response.content}")
    


# url2="https://elgi.sharepoint.com/sites/BIS-IT/_api/web/getFileByServerRelativePath(DecodedUrl='/sites/BIS-IT/Shared%20Documents/MasterData/ATS/ATS_Production_Plan_Master.csv')/$value"
# response = requests.get(url2,headers=headers,verify='D:\\SSL_Certificates\\netskope2.cer')#,verify=False)
# print(f"response.status_code :{response.status_code}")
# print(f"response.text:{response.text}")
# print(f"response.content:{response.content}")
    