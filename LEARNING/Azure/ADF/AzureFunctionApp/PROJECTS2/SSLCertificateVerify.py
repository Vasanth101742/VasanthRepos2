import ssl

cert_path = r"C:\Certificates\CorporateRootCA.cer"

try:
    certs = ssl._ssl._test_decode_cert(cert_path)
    print("Certificate loaded successfully")
    print("Subject:", certs["subject"])
    print("Issuer:", certs["issuer"])
except Exception as e:
    print("Certificate cannot be loaded:")
    print(type(e).__name__, e)



# import requests

# response = requests.get(
#     # "http://localhost:7071/api/uploadxml",
#     "https://www.elgi.com",
#     verify=r"C:\Certificates\CorporateRootCA.cer"
# )

# print(response.status_code)
