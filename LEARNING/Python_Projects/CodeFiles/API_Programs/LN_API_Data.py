import os
import xml.etree.ElementTree as ET

import pyodbc
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient


# ============================================================
# Configuration
# ============================================================

STORAGE_ACCOUNT_NAME = os.environ["STORAGE_ACCOUNT_NAME"]
CONTAINER_NAME = os.environ["ADLS_CONTAINER_NAME"]
BLOB_PATH = os.environ["BLOB_PATH"]

SQL_SERVER = os.environ["SQL_SERVER"]
SQL_DATABASE = os.environ["SQL_DATABASE"]
SQL_USERNAME = os.environ["SQL_USERNAME"]
SQL_PASSWORD = os.environ["SQL_PASSWORD"]


# ============================================================
# Download XML from ADLS
# ============================================================

def download_xml():

    account_url = (
        f"https://{STORAGE_ACCOUNT_NAME}.blob.core.windows.net"
    )

    credential = DefaultAzureCredential()

    blob_service_client = BlobServiceClient(
        account_url=account_url,
        credential=credential
    )

    blob_client = blob_service_client.get_blob_client(
        container=CONTAINER_NAME,
        blob=BLOB_PATH
    )

    xml_bytes = blob_client.download_blob().readall()

    return xml_bytes


# ============================================================
# Parse XML
# ============================================================

def parse_xml(xml_bytes):

    root = ET.fromstring(xml_bytes)

    records = []

    # Ignore namespace prefixes and search by local element name
    for element in root.iter():

        if element.tag.split("}")[-1] != "GetDFUResponse":
            continue

        def get_value(field_name):
            child = next(
                (
                    child
                    for child in element
                    if child.tag.split("}")[-1] == field_name
                ),
                None
            )

            if child is None or child.text is None:
                return None

            return child.text.strip()

        record = (
            get_value("Region"),
            get_value("Item"),
            get_value("Verticals"),
            get_value("DFU"),
            get_value("ItemCatg"),
            get_value("RRSClassification"),
            get_value("Classification"),
            get_value("Revenue"),
            get_value("Priority"),
            get_value("Updateddate")
        )

        records.append(record)

    return records


# ============================================================
# Insert into SQL Server
# ============================================================

def insert_into_sql(records):

    connection_string = (
        "DRIVER={ODBC Driver 18 for SQL Server};"
        f"SERVER={SQL_SERVER};"
        f"DATABASE={SQL_DATABASE};"
        f"UID={SQL_USERNAME};"
        f"PWD={SQL_PASSWORD};"
        "Encrypt=yes;"
        "TrustServerCertificate=no;"
    )

    connection = pyodbc.connect(connection_string)

    cursor = connection.cursor()

    insert_sql = """
        INSERT INTO dbo.DFU
        (
            Region,
            Item,
            Verticals,
            DFU,
            ItemCatg,
            RRSClassification,
            Classification,
            Revenue,
            Priority,
            Updateddate
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """

    cursor.fast_executemany = True

    cursor.executemany(
        insert_sql,
        records
    )

    connection.commit()

    cursor.close()
    connection.close()


# ============================================================
# Main
# ============================================================

def main():

    print("Downloading XML from ADLS...")

    xml_bytes = download_xml()

    print("Parsing XML...")

    records = parse_xml(xml_bytes)

    print(f"Records found: {len(records)}")

    if not records:
        print("No GetDFUResponse records found.")
        return

    print("Loading records into SQL...")

    insert_into_sql(records)

    print("Load completed successfully.")


if __name__ == "__main__":
    main()
