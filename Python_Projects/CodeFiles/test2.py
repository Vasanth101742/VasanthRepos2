import requests

# URL of the website
url = "https://www.elgi.com"

# Send a GET request with SSL verification
response = requests.get(url, verify=True)

# Print the certificate details
print(response.cert)