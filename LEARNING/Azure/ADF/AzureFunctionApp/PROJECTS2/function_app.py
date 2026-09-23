#************************************************************************
# Function App for handling HTTP triggers and Blob Storage uploads
#************************************************************************


#************************************************************************
# Method 1:
#************************************************************************


# import azure.functions as func
# import logging

# app = func.FunctionApp(http_auth_level=func.AuthLevel.FUNCTION)

# @app.route(route="http_trigger123")
# def http_trigger123(req: func.HttpRequest) -> func.HttpResponse:
#     logging.info('Python HTTP trigger function processed a request.')

#     name = req.params.get('name')
#     if not name:
#         try:
#             req_body = req.get_json()
#         except ValueError:
#             pass
#         else:
#             name = req_body.get('name')

#     if name:
#         return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
#     else:
#         return func.HttpResponse(
#              "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
#              status_code=200
#         )




#************************************************************************
# Method 2:
#************************************************************************


# import azure.functions as func
# from azure.storage.blob import BlobServiceClient
# import logging
# import os
# import json

# app = func.FunctionApp()

# @app.route(
#     route="uploadxml",
#     methods=["POST"],
#     auth_level=func.AuthLevel.FUNCTION
# )

# def UploadXmlToBlob(req: func.HttpRequest) -> func.HttpResponse:
#     """
#     Upload XML content to Azure Blob Storage.
#     """

#     try:
#         body = req.get_json()

#         LN_API_content = body.get("xml")
#         file_name = body.get("fileName", "RegionWiseDFU.xml")
#         container_name = body.get("container", "xml")

#         if not LN_API_content:
#             return func.HttpResponse(
#                 json.dumps({
#                     "status": "error",
#                     "message": "XML content is required."
#                 }),
#                 status_code=400,
#                 mimetype="application/json"
#             )

#         connection_string = os.getenv("AzureWebJobsStorage")

#         if not connection_string:
#             raise ValueError(
#                 "AzureWebJobsStorage environment variable is not configured."
#             )

#         blob_service_client = BlobServiceClient.from_connection_string(
#             connection_string
#         )

#         container_client = blob_service_client.get_container_client(
#             container_name
#         )

#         try:
#             container_client.create_container()
#             logging.info(f"Created container: {container_name}")
#         except Exception:
#             pass

#         blob_client = container_client.get_blob_client(file_name)

#         blob_client.upload_blob(
#             LN_API_content,
#             overwrite=True
#         )

#         logging.info(
#             f"Successfully uploaded file '{file_name}' "
#             f"to container '{container_name}'"
#         )

#         return func.HttpResponse(
#             json.dumps({
#                 "status": "success",
#                 "fileName": file_name,
#                 "container": container_name
#             }),
#             status_code=200,
#             mimetype="application/json"
#         )

#     except ValueError as ve:
#         logging.error(str(ve))

#         return func.HttpResponse(
#             json.dumps({
#                 "status": "error",
#                 "message": str(ve)
#             }),
#             status_code=400,
#             mimetype="application/json"
#         )

#     except Exception as e:
#         logging.exception("Unexpected error")

#         return func.HttpResponse(
#             json.dumps({
#                 "status": "error",
#                 "message": str(e)
#             }),
#             status_code=500,
#             mimetype="application/json"
#         )

# @app.route(route="http_trigger2", auth_level=func.AuthLevel.FUNCTION)
# def http_trigger2(req: func.HttpRequest) -> func.HttpResponse:
#     logging.info('Python HTTP trigger function processed a request.')

#     name = req.params.get('name')
#     if not name:
#         try:
#             req_body = req.get_json()
#         except ValueError:
#             pass
#         else:
#             name = req_body.get('name')

#     if name:
#         return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
#     else:
#         return func.HttpResponse(
#              "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
#              status_code=200
#         )


#*************************************************************
#Method 3 : Using XML Body
#*************************************************************

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
        

        # rows = []

        # for record in responses:

        #     row = {}

        #     for child in record:

        #         row[child.tag] = (
        #             child.text.strip()
        #             if child.text
        #             else ""
        #         )

        #     rows.append(row)


        # df = pd.DataFrame(rows)

        # print(df)




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





        # #conn_str =SourceData.conn_str
        # quoted = urllib.parse.quote_plus(conn_str)

        # insert_sql = "INSERT INTO dbo.Regionwise_DFU_Master_from_LNAPI(Region,Item,Verticals,DFU,ItemCatg, \
        #             RRSClassification,Classification,Revenue,Priority,Updateddate)VALUES \
        #             (?,?,?,?,?,?,?,?,?,?)"

        # dest_conn=pyodbc.connect(conn_str)
        # cursor = dest_conn.cursor()
        # #cursor.fast_executemany = True
        # #cursor.execute("Truncate Table SalesQtyForecast ")
        # #dest_conn.commit()

        # df2=df[["Region","Item","Verticals","DFU","ItemCatg", \
        #             "RRSClassification","Classification","Revenue","Priority","Updateddate"]]
        # #print(df_final2['Qty'])
        # #print("df_final2.dtypes : \n",df_final2.dtypes)

        # data = [tuple(x) for x in df2.to_numpy()]
        # #print(data)
        # cursor.executemany(insert_sql, data)
        # dest_conn.commit()
        # cursor.close()
        # dest_conn.close()


        # # End: write the Output to SQL Server----------------------------------------
        




        #xml_text = LN_API_content.decode("utf-8")                      
        # xml_text = LN_API_content
        # json_data = json.loads(xml_text)
        # logging.info(
        #     f"Parsed JSON data: {json_data}"
        # )

        # # Optionally, you can perform further processing with the parsed JSON data here.
        # # Example: log the keys of the parsed JSON data
        # logging.info(
        #     f"JSON keys: {list(json_data.keys())}"
        # )
        # # Example: log the values of the parsed JSON data
        # logging.info(
        #     f"JSON values: {list(json_data.values())}"
        # )
        # # Example: log the number of keys in the parsed JSON data
        # logging.info(
        #     f"Number of JSON keys: {len(json_data.keys())}"
        # )
        # # Example: log the number of values in the parsed JSON data
        # logging.info(
        #     f"Number of JSON values: {len(json_data.values())}"
        # )
        # # Example: log the entire parsed JSON data
        # logging.info(
        #     f"Full JSON data: {json_data}"
        # )
        # # Example: log whether the parsed JSON data is empty
        # logging.info(
        #     f"Is JSON data empty: {not bool(json_data)}"
        # )


        logging.info(
            f"Successfully uploaded file '{file_name}' "
            f"to container '{container_name}'"
        )


        
        # # Download Blob Content
        # blob_data = blob_client.download_blob()


        # # Convert bytes to string
        # json_text = blob_data.readall().decode("utf-8")



        # # Parse JSON
        # json_data = json.loads(json_text)

        # print(json_data)

        # # Access fields
        # print(json_data.get("fileName"))
        # print(json_data.get("xml"))

        

        # import os
        # from azure.storage.blob import BlobServiceClient

        # Azure Storage details
        # connection_string = "<storage_connection_string>"
        # container_name = "xml"
        # blob_name = "RegionWiseDFU_20260918_084853.json"
        # blob_name = file_name

        # # Local folder
        # local_folder = r"C:\JsonFiles"

        # # Create local folder if it doesn't exist
        # os.makedirs(local_folder, exist_ok=True)

        # # Local file path
        # local_file_path = os.path.join(
        #     local_folder,
        #     blob_name
        # )

        # # Create Blob Service Client
        # blob_service_client = BlobServiceClient.from_connection_string(
        #     connection_string
        # )

        # # Get Blob Client
        # blob_client = blob_service_client.get_blob_client(
        #     container=container_name,
        #     blob=blob_name
        # )

        # # Download and save locally
        # with open(local_file_path, "wb") as file:
        #     download_stream = blob_client.download_blob()
        #     file.write(download_stream.readall())

        # print(f"JSON file saved to: {local_file_path}")



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


        










#*******************************************************************************
#Initial Test Code Run
#*******************************************************************************

# @app.route(
#     route="http_trigger2",
#     auth_level=func.AuthLevel.FUNCTION
# )
# def http_trigger2(req: func.HttpRequest) -> func.HttpResponse:

#     logging.info(
#         "Python HTTP trigger function processed a request."
#     )

#     name = req.params.get("name")

#     if not name:
#         try:
#             req_body = req.get_json()
#         except ValueError:
#             pass
#         else:
#             name = req_body.get("name")

#     if name:
#         return func.HttpResponse(
#             f"Hello, {name}. "
#             "This HTTP triggered function executed successfully."
#         )

#     return func.HttpResponse(
#         "This HTTP triggered function executed successfully. "
#         "Pass a name in the query string or in the request body "
#         "for a personalized response.",
#         status_code=200
#     )


# *************************************************************************************
#Method : Outputting both xml and JSON responses
# *************************************************************************************

# import azure.functions as func
# from azure.storage.blob import BlobServiceClient
# import logging
# import os
# import json
# import html
# import xml.etree.ElementTree as ET

# app = func.FunctionApp()


# @app.route(
#     route="uploadxml",
#     methods=["POST"],
#     auth_level=func.AuthLevel.FUNCTION
# )
# def UploadXmlToBlob(req: func.HttpRequest) -> func.HttpResponse:

#     try:

#         content_type = req.headers.get(
#             "Content-Type",
#             ""
#         ).lower()

#         LN_API_content = None
#         json_content = None

#         # -------------------------------------------------
#         # CASE 1 : Request body contains JSON
#         # -------------------------------------------------
#         if "application/json" in content_type:

#             json_content = req.get_json()

#             if "xml" not in json_content:
#                 return func.HttpResponse(
#                     json.dumps({
#                         "status": "error",
#                         "message": "'xml' property not found in JSON payload"
#                     }),
#                     status_code=400,
#                     mimetype="application/json"
#                 )

#             # Decode HTML encoded XML
#             LN_API_content = html.unescape(
#                 json_content["xml"]
#             )

#         # -------------------------------------------------
#         # CASE 2 : Request body contains raw XML
#         # -------------------------------------------------
#         else:

#             LN_API_content = req.get_body().decode(
#                 "utf-8"
#             )

#             if not LN_API_content:
#                 return func.HttpResponse(
#                     json.dumps({
#                         "status": "error",
#                         "message": "Request body is empty"
#                     }),
#                     status_code=400,
#                     mimetype="application/json"
#                 )

#         # -------------------------------------------------
#         # Validate XML
#         # -------------------------------------------------
#         try:
#             ET.fromstring(LN_API_content)
#         except ET.ParseError as ex:
#             return func.HttpResponse(
#                 json.dumps({
#                     "status": "error",
#                     "message": f"Invalid XML: {str(ex)}"
#                 }),
#                 status_code=400,
#                 mimetype="application/json"
#             )

#         # -------------------------------------------------
#         # Blob Storage
#         # -------------------------------------------------
#         connection_string = os.getenv(
#             "AzureWebJobsStorage"
#         )

#         if not connection_string:
#             raise ValueError(
#                 "AzureWebJobsStorage not configured"
#             )

#         container_name = req.params.get(
#             "container",
#             "xml"
#         )

#         base_file_name = req.params.get(
#             "fileName",
#             "RegionWiseDFU"
#         )

#         # Remove extension if supplied
#         base_file_name = os.path.splitext(
#             base_file_name
#         )[0]

#         xml_file_name = f"{base_file_name}.xml"
#         json_file_name = f"{base_file_name}.json"

#         blob_service_client = (
#             BlobServiceClient.from_connection_string(
#                 connection_string
#             )
#         )

#         container_client = (
#             blob_service_client.get_container_client(
#                 container_name
#             )
#         )

#         try:
#             container_client.create_container()
#         except Exception:
#             pass

#         # -------------------------------------------------
#         # Save XML file
#         # -------------------------------------------------
#         xml_blob = container_client.get_blob_client(
#             xml_file_name
#         )

#         xml_blob.upload_blob(
#             LN_API_content.encode("utf-8"),
#             overwrite=True
#         )

#         # -------------------------------------------------
#         # Save JSON file
#         # -------------------------------------------------
#         if json_content:

#             json_blob = container_client.get_blob_client(
#                 json_file_name
#             )

#             json_blob.upload_blob(
#                 json.dumps(
#                     json_content,
#                     indent=2
#                 ),
#                 overwrite=True
#             )

#         return func.HttpResponse(
#             json.dumps({
#                 "status": "success",
#                 "xmlFile": xml_file_name,
#                 "jsonFile": json_file_name if json_content else None,
#                 "container": container_name
#             }),
#             status_code=200,
#             mimetype="application/json"
#         )

#     except Exception as ex:

#         logging.exception(
#             "Error while uploading file"
#         )

#         return func.HttpResponse(
#             json.dumps({
#                 "status": "error",
#                 "message": str(ex)
#             }),
#             status_code=500,
#             mimetype="application/json"
#         )



#************************************************************************
# XML Valid file to Blob
#************************************************************************

# import azure.functions as func
# from azure.storage.blob import BlobServiceClient
# import logging
# import os
# import json
# import html
# import xml.etree.ElementTree as ET

# app = func.FunctionApp()


# @app.route(
#     route="uploadxml",
#     methods=["POST"],
#     auth_level=func.AuthLevel.FUNCTION
# )
# def UploadXmlToBlob(req: func.HttpRequest) -> func.HttpResponse:
#     """
#     Receives JSON payload:
#     {
#         "fileName": "RegionWiseDFU_20260918_084853.xml",
#         "xml": "&lt;?xml version=\"1.0\" ?&gt;..."
#     }

#     Extracts the XML payload, converts it into valid XML,
#     and uploads it to Azure Blob Storage.
#     """

#     try:

#         # Read request body
#         request_body = req.get_body().decode(
#             "utf-8",
#             errors="replace"
#         )

#         logging.info(
#             f"Request received: {request_body[:500]}"
#         )

#         # Parse JSON
#         try:
#             payload = json.loads(request_body)
#         except json.JSONDecodeError:
#             return func.HttpResponse(
#                 json.dumps({
#                     "status": "error",
#                     "message": "Request body is not valid JSON."
#                 }),
#                 status_code=400,
#                 mimetype="application/json"
#             )

#         # Extract XML payload
#         LN_API_content = payload.get("xml")

#         if not LN_API_content:
#             return func.HttpResponse(
#                 json.dumps({
#                     "status": "error",
#                     "message": "'xml' property not found in JSON payload."
#                 }),
#                 status_code=400,
#                 mimetype="application/json"
#             )

#         # Decode escaped XML characters
#         LN_API_content = html.unescape(LN_API_content)

#         # Remove BOM if present
#         LN_API_content = LN_API_content.lstrip("\ufeff").strip()

#         # Validate XML
#         try:
#             ET.fromstring(LN_API_content)
#         except ET.ParseError as ex:
#             return func.HttpResponse(
#                 json.dumps({
#                     "status": "error",
#                     "message": f"Invalid XML: {str(ex)}",
#                     "sample": LN_API_content[:200]
#                 }),
#                 status_code=400,
#                 mimetype="application/json"
#             )

#         # Get filename from payload
#         file_name = payload.get(
#             "fileName",
#             req.params.get(
#                 "fileName",
#                 "RegionWiseDFU.xml"
#             )
#         )

#         if not file_name.lower().endswith(".xml"):
#             file_name += ".xml"

#         # Get container name
#         container_name = req.params.get(
#             "container",
#             "xml"
#         )

#         # Azure Storage Connection String
#         connection_string = os.getenv(
#             "AzureWebJobsStorage"
#         )

#         if not connection_string:
#             raise ValueError(
#                 "AzureWebJobsStorage environment variable is not configured."
#             )

#         # Create Blob Service Client
#         blob_service_client = BlobServiceClient.from_connection_string(
#             connection_string
#         )

#         container_client = blob_service_client.get_container_client(
#             container_name
#         )

#         # Create container if not exists
#         try:
#             container_client.create_container()
#             logging.info(
#                 f"Created container '{container_name}'"
#             )
#         except Exception:
#             pass

#         # Upload XML file
#         blob_client = container_client.get_blob_client(
#             file_name
#         )

#         blob_client.upload_blob(
#             LN_API_content.encode("utf-8"),
#             overwrite=True
#         )

#         logging.info(
#             f"Successfully uploaded '{file_name}' to '{container_name}'"
#         )

#         return func.HttpResponse(
#             json.dumps({
#                 "status": "success",
#                 "fileName": file_name,
#                 "container": container_name,
#                 "message": "Valid XML file uploaded successfully."
#             }),
#             status_code=200,
#             mimetype="application/json"
#         )

#     except Exception as ex:

#         logging.exception(
#             "Unexpected error occurred"
#         )

#         return func.HttpResponse(
#             json.dumps({
#                 "status": "error",
#                 "message": str(ex)
#             }),
#             status_code=500,
#             mimetype="application/json"
#         )


# @app.route(
#     route="http_trigger2",
#     auth_level=func.AuthLevel.FUNCTION
# )
# def http_trigger2(req: func.HttpRequest) -> func.HttpResponse:

#     name = req.params.get("name")

#     if not name:
#         try:
#             req_body = req.get_json()
#             name = req_body.get("name")
#         except Exception:
#             pass

#     if name:
#         return func.HttpResponse(
#             f"Hello, {name}. This HTTP triggered function executed successfully."
#         )

#     return func.HttpResponse(
#         "This HTTP triggered function executed successfully.",
#         status_code=200
#     )