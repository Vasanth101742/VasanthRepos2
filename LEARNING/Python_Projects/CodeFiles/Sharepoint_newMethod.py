import requests

tenant_id = "50f40674-931c-4d09-ae8a-bb8fde36b912"
client_id = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
client_secret = "2do8Q~i5WJh~rw~dlzSHyJo5~Omq.voSlS0eUc7P"

def get_access_token(client_id, client_secret, tenant_id):
    url = f"https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token"
    
    headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    }
    
    data = {
        "client_id": client_id,
        "client_secret": client_secret,
        "grant_type": "client_credentials",
        "scope": "https://graph.microsoft.com/.default"
    }
    
    response = requests.post(url, headers=headers, data=data)
    
    if response.status_code == 200:
        print("Token Generated Successfully")
        access_token = response.json().get('access_token')
        return access_token
    else:
        print(f"Error getting token: {response.status_code}")
        print(response.text)
        return None
