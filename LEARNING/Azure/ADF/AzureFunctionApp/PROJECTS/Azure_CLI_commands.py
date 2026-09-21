import os
from azure.identity import ManagedIdentityCredential


client_id =os.environ["AZURE_CLIENT_ID"]
print(client_id)

credential = ManagedIdentityCredential(
    client_id= client_id
)