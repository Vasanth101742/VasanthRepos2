# import ssl
# import socket

# def save_server_cert(host, port, cert_file_path):
#     conn = ssl.create_connection((host, port))
#     context = ssl.create_default_context()
#     sock = context.wrap_socket(conn, server_hostname=host)

#     # Get cert in DER (binary) format and convert to PEM
#     der_cert = sock.getpeercert(True)
#     pem_cert = ssl.DER_cert_to_PEM_cert(der_cert)

#     # Save to a file
#     with open(cert_file_path, 'w') as f:
#         f.write(pem_cert)

#     print(f"Saved certificate to {cert_file_path}")

# # Example usage:
# save_server_cert('elgi.sharepoint.com', 443, 'server-cert.pem')

###############################################################################


import subprocess

def fetch_certificate_chain():
    command = ['openssl', 's_client', '-showcerts', '-connect', 'elgi.sharepoint.com:443']
    with open('full-cert-chain.pem', 'wb') as cert_file:
        subprocess.run(command, stdout=cert_file)

fetch_certificate_chain()