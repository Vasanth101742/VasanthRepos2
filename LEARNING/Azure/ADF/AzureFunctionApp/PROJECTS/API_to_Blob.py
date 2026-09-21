import azure.functions as func
from azure.storage.blob import BlobServiceClient
import os
import json
from datetime import datetime


def main(req: func.HttpRequest) -> func.HttpResponse:

    try:

        body = req.get_json()

        xml_content = body["xml"]
        file_name = body.get(
            "fileName",
            "RegionWiseDFU.xml"
        )

        connection_string = os.environ[
            "AzureWebJobsStorage"
        ]

        blob_service = BlobServiceClient.from_connection_string(
            connection_string
        )

        container_name = "xml"

        blob_client = blob_service.get_blob_client(
            container=container_name,
            blob=file_name
        )

        blob_client.upload_blob(
            xml_content.encode("utf-8"),
            overwrite=True
        )

        print("hAI")

        return func.HttpResponse(
            json.dumps({
                "status": "success",
                "file": file_name
            }),
            status_code=200,
            mimetype="application/json"
        )

    except Exception as e:

        return func.HttpResponse(
            json.dumps({
                "status": "error",
                "message": str(e)
            }),
            status_code=500,
            mimetype="application/json"
        )
