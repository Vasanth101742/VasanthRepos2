
# import socket

# server = "10.50.0.4"#"ELGi-BIS.database.windows.net"
# port = 1433

# try:
#     print(f"Connecting to {server}:{port}")
#     sock = socket.create_connection((server, port), timeout=10)
#     print("TCP connection successful")
#     sock.close()
# except Exception as e:
#     print(f"TCP connection failed: {type(e).__name__}: {e}")



#Test Whether SQL Server is reachable and credentials are correct
import os
import socket
import pyodbc

server = "10.50.0.4"

print("=== SQL Connectivity Diagnostics ===")

try:
    print("DNS resolution:")
    print(socket.gethostbyname_ex(server))
except Exception as e:
    print("DNS FAILED:", repr(e))

try:
    print("TCP connectivity:")
    sock = socket.create_connection((server, 1433), timeout=10)
    print("TCP 1433 OK")
    sock.close()
except Exception as e:
    print("TCP FAILED:", repr(e))

try:
    print("SQL connection:")
    
    conn = pyodbc.connect(
        f"DRIVER={{ODBC Driver 18 for SQL Server}};"
        f"SERVER=tcp:{server},1433;"
        f"DATABASE=ELGI_SOP;"
        f"UID=sa;"
        f"PWD=ElgiP0w3r@20#23;"
        f"Encrypt=yes;"
        f"TrustServerCertificate=yes;"
        f"Connection Timeout=10;"
    )

    print("SQL CONNECTION OK")
    conn.close()

except Exception as e:
    print("SQL CONNECTION FAILED:", repr(e))

#End :Test Whether SQL Server is reachable and credentials are correct







import html
from http.client import responses
from unittest import result
import urllib
import azure.functions as func
from azure.storage.blob import BlobServiceClient
import logging
import os
import json
import pyodbc
import xml.etree.ElementTree as ET
import pandas as pd

# import requests

# response = requests.get(
#     "http://localhost:7071/api/uploadxml",
#     verify=r"C:\Certificates\CorporateRootCA.cer"
# )

# print(response.status_code)




app = func.FunctionApp()


@app.route(
    route="uploadxml",
    methods=["POST"],
    auth_level=func.AuthLevel.FUNCTION
)
def UploadXmlToBlob(req: func.HttpRequest) -> func.HttpResponse:
    """
    Upload raw XML content from the HTTP request body
    directly to Azure Blob Storage.
    """

    try:

        #Step 1: Read LN API content from the request body************************

        # Method 1: Read json body
        # payload = req.get_json()
        # LN_API_content = payload.get("xml")
        
        # Method 2: Read raw request body
        LN_API_content = req.get_body().decode('utf-8')

        if not LN_API_content:
            return func.HttpResponse(
                json.dumps({
                    "status": "error",
                    "message": "XML content is required in the request body."
                }),
                status_code=400,
                #mimetype="application/json" #Commented
                mimetype="application/xml"
            )

        # Optional: validate that the request contains XML
        content_type = req.headers.get("Content-Type", "").lower()

        if "xml" not in content_type and "text/plain" not in content_type:
            logging.warning(
                f"Unexpected Content-Type: {content_type}"
            )

        # Get optional values from query parameters
        file_name = req.params.get(
            "fileName",
            "RegionWiseDFU.xml"
        )

        container_name = req.params.get(
            "container",
            "xml"
        )


        #Step 2: Azure BLOB Storage Configuration************************

        connection_string = os.getenv("AzureWebJobsStorage")

        if not connection_string:
            raise ValueError(
                "AzureWebJobsStorage environment variable is not configured."
            )

        blob_service_client = BlobServiceClient.from_connection_string(
            connection_string
        )

        container_client = blob_service_client.get_container_client(
            container_name
        )

        # Create container if it doesn't exist
        try:
            container_client.create_container()
            logging.info(
                f"Created container: {container_name}"
            )
        except Exception:
            # Container probably already exists
            pass

        blob_client = container_client.get_blob_client(
            file_name
        )


        #Step 3: upload data into Azure BLOB Storage************************
        # Upload raw XML bytes
        blob_client.upload_blob(
            LN_API_content,
            overwrite=True
        )



        #Step 4: Parse XML and extract GetDFUResponse************************

        # Decode HTML entities
        xml_string = html.unescape(LN_API_content)
        root = ET.fromstring(xml_string)

        # Find GetDFUResponse ignoring namespaces
        for elem in root.iter():
            if elem.tag.endswith("GetDFUResponse"):
                get_dfu = elem
                break

        result = {
        child.tag.split("}")[-1]: child.text.strip() if child.text else ""
        for child in get_dfu
        }

        print(result)




        # Extract data
        # Find GetDFUResponse
        responses = root.findall(".//GetDFUResponse")

        print("Number of GetDFUResponse records:", len(responses))


        for record in responses:

            print("\n========== RECORD ==========")

            region = record.findtext("Region", default="").strip()
            item = record.findtext("Item", default="").strip()
            verticals = record.findtext("Verticals", default="").strip()
            dfu = record.findtext("DFU", default="").strip()
            item_catg = record.findtext("ItemCatg", default="").strip()
            rrs_classification = record.findtext(
                "RRSClassification",
                default=""
            ).strip()

            classification = record.findtext(
                "Classification",
                default=""
            ).strip()

            revenue = record.findtext(
                "Revenue",
                default=""
            ).strip()

            priority = record.findtext(
                "Priority",
                default=""
            ).strip()

            updated_date = record.findtext(
                "Updateddate",
                default=""
            ).strip()


            print("Region:", region)
            print("Item:", item)
            print("Verticals:", verticals)
            print("DFU:", dfu)
            print("ItemCatg:", item_catg)
            print("RRSClassification:", rrs_classification)
            print("Classification:", classification)
            print("Revenue:", revenue)
            print("Priority:", priority)
            print("Updateddate:", updated_date)




        # #------------------------------------------------------------
        

        rows = []

        for record in responses:

            row = {}

            for child in record:

                row[child.tag] = (
                    child.text.strip()
                    if child.text
                    else ""
                )

            rows.append(row)


        df = pd.DataFrame(rows)

        print(df)




        # # write the Output to SQL Server---------------------------------------------

        # # conn_str = (
        # #     'DRIVER={ODBC Driver 17 for SQL Server};'
        # #     f'SERVER={os.environ["server"]};'
        # #     f'DATABASE={os.environ["database"]};'
        # #     # For Windows integrated auth:
        # #     #'Trusted_Connection=yes;'
        # #     # Or for SQL Server auth, comment above line and uncomment these:
        # #      f'UID={os.environ["username"]};'
        # #      f'PWD={os.environ["password"]};'
        # # )


        # conn_str = (
        #     "DRIVER={ODBC Driver 17 for SQL Server};"
        #     f"SERVER={os.getenv('server')};"
        #     f"DATABASE={os.getenv('database')};"
        #     f"UID={os.getenv('username')};"
        #     f"PWD={os.getenv('password')};"
        # )


        conn_str = (
            "DRIVER={ODBC Driver 18 for SQL Server};"
            f"SERVER=10.x.x.x;"
            f"DATABASE=Database_name;"
            f"UID=ServiceAccount;"
            f"PWD=password;"
            "Encrypt=yes;"
            "TrustServerCertificate=yes;"
            "Connection Timeout=120;"
        )

        #conn_str =SourceData.conn_str
        quoted = urllib.parse.quote_plus(conn_str)

        insert_sql = "INSERT INTO dbo.Regionwise_DFU_Master_from_LNAPI(Region,Item,Verticals,DFU,ItemCatg, \
                    RRSClassification,Classification,Revenue,Priority,Updateddate)VALUES \
                    (?,?,?,?,?,?,?,?,?,?)"

        dest_conn=pyodbc.connect(conn_str)
        cursor = dest_conn.cursor()
        #cursor.fast_executemany = True
        #cursor.execute("Truncate Table SalesQtyForecast ")
        #dest_conn.commit()

        df2=df[["Region","Item","Verticals","DFU","ItemCatg", \
                    "RRSClassification","Classification","Revenue","Priority","Updateddate"]]
        #print(df_final2['Qty'])
        #print("df_final2.dtypes : \n",df_final2.dtypes)

        data = [tuple(x) for x in df2.to_numpy()]
        #print(data)
        cursor.executemany(insert_sql, data)
        dest_conn.commit()
        cursor.close()
        dest_conn.close()


        # End: write the Output to SQL Server----------------------------------------


        logging.info(
            f"Successfully uploaded file '{file_name}' "
            f"to container '{container_name}'"
        )


        
        


        return func.HttpResponse(
            json.dumps({
                "status": "success",
                "fileName": file_name,
                "container": container_name
            }),
            status_code=200,
            mimetype="application/json"
        )

        

    except ValueError as ve:
        logging.error(str(ve))

        return func.HttpResponse(
            json.dumps({
                "status": "error",
                "message": str(ve)
            }),
            status_code=400,
            mimetype="application/json"
        )

    except Exception as e:
        logging.exception("Unexpected error")

        return func.HttpResponse(
            json.dumps({
                "status": "error",
                "message": str(e)
            }),
            status_code=500,
            mimetype="application/json"
        )


