
import requests
import xml.etree.ElementTree as ET
import pandas as pd


# ============================================================
# 1. API CONFIGURATION
# ============================================================

URL = "https://edex.elgi.com:8443/c4ws/services/RegionWiseDFU/ElgiNewTest"

HEADERS = {
    "Content-Type": "text/xml; charset=utf-8",
    "Accept": "text/xml"
}


# ============================================================
# 2. SOAP REQUEST
# ============================================================

BODY = """<?xml version="1.0" encoding="UTF-8"?>
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


# ============================================================
# 3. CALL API
# ============================================================

def call_api():

    response = requests.post(
        URL,
        headers=HEADERS,
        data=BODY.encode("utf-8"),
        timeout=60
    )

    print("HTTP Status:", response.status_code)

    response.raise_for_status()

    return response.content


# ============================================================
# 4. PARSE XML
# ============================================================

def parse_xml(xml_data):

    try:
        root = ET.fromstring(xml_data)

    except ET.ParseError as e:
        print("XML parsing failed:")
        print(e)
        raise

    return root


# ============================================================
# 5. CHECK SOAP FAULT
# ============================================================

def check_soap_fault(root):

    fault = None

    for element in root.iter():

        if element.tag.endswith("Fault"):
            fault = element
            break

    if fault is not None:

        print("\n========== SOAP FAULT ==========")

        for element in fault.iter():

            if element.text and element.text.strip():

                print(
                    element.tag,
                    ":",
                    element.text.strip()
                )

        return True

    return False


# ============================================================
# 6. FIND GetDFUResponse
# ============================================================

def find_records(root):

    records = []

    for element in root.iter():

        if element.tag.endswith("GetDFUResponse"):

            records.append(element)

    return records


# ============================================================
# 7. CONVERT XML RECORD TO DICTIONARY
# ============================================================

def record_to_dict(record):

    row = {}

    for child in record:

        # Remove namespace if one exists
        tag = child.tag

        if "}" in tag:
            tag = tag.split("}", 1)[1]

        # Extract text
        value = child.text

        if value is None:
            value = ""
        else:
            value = value.strip()

        row[tag] = value

    return row


# ============================================================
# 8. CONVERT ALL RECORDS TO TABLE
# ============================================================

def records_to_dataframe(records):

    rows = []

    for record in records:

        row = record_to_dict(record)

        rows.append(row)

    return pd.DataFrame(rows)


# ============================================================
# 9. MAIN
# ============================================================

def main():

    # Call API
    xml_data = call_api()

    # Parse XML
    root = parse_xml(xml_data)

    # Check SOAP Fault
    if check_soap_fault(root):

        return

    # Find records
    records = find_records(root)

    print(
        "\nNumber of GetDFUResponse records:",
        len(records)
    )

    if not records:

        print("\nNo GetDFUResponse records found.")

        print("\nXML structure:")

        for element in root.iter():
            print(element.tag)

        return

    # Convert to DataFrame
    df = records_to_dataframe(records)

    # Display
    print("\n========== DATA ==========")
    print(df)

    # Display information
    print("\n========== DATAFRAME INFO ==========")
    print(df.info())

    # Save CSV
    df.to_csv(
        "RegionWiseDFU.csv",
        index=False
    )

    # Save Excel
    df.to_excel(
        "RegionWiseDFU.xlsx",
        index=False
    )

    print("\nFiles created:")
    print("RegionWiseDFU.csv")
    print("RegionWiseDFU.xlsx")


# ============================================================
# RUN
# ============================================================

if __name__ == "__main__":
    main()
