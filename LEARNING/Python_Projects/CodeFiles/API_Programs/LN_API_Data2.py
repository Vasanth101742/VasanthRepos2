import requests
import xml.etree.ElementTree as ET


url = "https://edex.elgi.com:8443/c4ws/services/RegionWiseDFU/ElgiNewTest"

headers = {
    "Content-Type": "text/xml; charset=utf-8",
    "Accept": "text/xml"
}

body = """
<soapenv:Envelope
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:reg="http://www.infor.com/businessinterface/RegionWiseDFU">

    <soapenv:Body>

        <reg:Create>

            <CreateRequest>

                <DataArea>

                    <RegionWiseDFU>
                        <RequestType>GET</RequestType>
                        <Company>400</Company>
                    </RegionWiseDFU>

                </DataArea>

            </CreateRequest>

        </reg:Create>

    </soapenv:Body>

</soapenv:Envelope>
""".strip()


# Call API
response = requests.post(
    url,
    headers=headers,
    data=body.encode("utf-8"),
    timeout=60
)

print("HTTP Status:", response.status_code)

# Parse XML
root = ET.fromstring(response.content)


# Namespace for the SOAP envelope
ns = {
    "soapenv": "http://schemas.xmlsoap.org/soap/envelope/",
    "reg": "http://www.infor.com/businessinterface/RegionWiseDFU"
}


# Find GetDFUResponse
responses = root.findall(".//GetDFUResponse")

print("Number of GetDFUResponse records:", len(responses))


# Extract data
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




#------------------------------------------------------------
import pandas as pd

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
