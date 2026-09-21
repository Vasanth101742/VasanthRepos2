import requests

response = requests.get(
    "http://localhost:7071/api/uploadxml",
    verify=r"C:\Certificates\CorporateRootCA.cer"
)

print(response.status_code)
