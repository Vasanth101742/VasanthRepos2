import azure.functions as func
from azure.storage.blob import BlobServiceClient
import logging
import os
import json

app = func.FunctionApp()

@app.route(
    route="uploadxml",
    methods=["POST"],
    auth_level=func.AuthLevel.FUNCTION
)
def UploadXmlToBlob(req: func.HttpRequest) -> func.HttpResponse:
    """
    Upload XML content to Azure Blob Storage.
    """

    try:
        body = req.get_json()

        xml_content = body.get("xml")
        file_name = body.get("fileName", "RegionWiseDFU.xml")
        container_name = body.get("container", "xml")

        if not xml_content:
            return func.HttpResponse(
                json.dumps({
                    "status": "error",
                    "message": "XML content is required."
                }),
                status_code=400,
                mimetype="application/json"
            )

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

        try:
            container_client.create_container()
            logging.info(f"Created container: {container_name}")
        except Exception:
            pass

        blob_client = container_client.get_blob_client(file_name)

        blob_client.upload_blob(
            xml_content,
            overwrite=True
        )

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