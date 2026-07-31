from office365.runtime.auth.authentication_context import AuthenticationContext
from office365.sharepoint.client_context import ClientContext

url = "https://elgi.sharepoint.com/sites/sites/BIS-IT"
username = "vasanthk"
password = "Elgi@0079"

context = AuthenticationContext(url)
if context.acquire_token_for_user(username, password):
    ctx = ClientContext(url, context)
    print("Authentication successful!")
else:
    print("Authentication failed!")