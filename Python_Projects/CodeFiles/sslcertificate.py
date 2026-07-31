import ssl
import socket

def get_ssl_certificate(hostname):
    context = ssl.create_default_context()
    with socket.create_connection((hostname, 443)) as sock:
        with context.wrap_socket(sock, server_hostname=hostname) as ssock:
            cert = ssock.getpeercert()
            return cert

# Example usage
hostname = "PROD-AZURE-BIS-SERVER-10.50.0.4"#"10.50.0.4"#"https://elgi.sharepoint.com/"
certificate = get_ssl_certificate(hostname)
print(certificate)