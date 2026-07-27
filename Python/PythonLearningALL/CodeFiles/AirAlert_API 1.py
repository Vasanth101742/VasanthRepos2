import requests
import json
import urllib3
import pyodbc

# ==========================================
# DISABLE SSL CERTIFICATE WARNING
# ==========================================
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# ==========================================
# SQL SERVER CONNECTION
# ==========================================

print("Connecting to SQL Server...")

conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=10.50.0.4;'
    'DATABASE=ELGi_LN;'
    'UID=bisadmin;'
    'PWD=ElgiP0w3r@20#23;'
)

print("SQL Connection Successful")

cursor = conn.cursor()

# ==========================================
# TRUNCATE TABLE BEFORE LOAD
# ==========================================
cursor.execute("TRUNCATE TABLE AirAlert_EquipmentDetails")
conn.commit()

print("AirAlert_EquipmentDetails Table Truncated Successfully")

# ==========================================
# LOGIN API
# ==========================================
LOGIN_URL = "https://torapis.tor-iot.com/Auth/login"

login_payload = {
    "username": "elgilevel3",
    "password": "Pa$$w0rd"
}

try:

    # ==========================================
    # LOGIN REQUEST
    # ==========================================
    login_response = requests.post(
        LOGIN_URL,
        json=login_payload,
        verify=False
    )

    print("\nLogin Status Code:", login_response.status_code)

    login_data = login_response.json()

    # ==========================================
    # TOKEN EXTRACTION
    # ==========================================
    token = login_data.get("token")

    if not token:
        print("\nToken not found")
        exit()

    print("\nToken Generated Successfully\n")

    # ==========================================
    # API HEADER
    # ==========================================
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }

    # ==========================================
    # EQUIPMENT DETAILS API
    # ==========================================
    EQUIPMENT_URL = "https://torapis.tor-iot.com/EquipDetails/GetEquipmentDetails"

    # ==========================================
    # START PAGE LOOP
    # ==========================================
    page_no = 1

    while True:

        print(f"\nFetching Page No : {page_no}")

        equipment_payload = {
            "hardwareId": "",
            "pageNo": page_no
        }

        # ==========================================
        # API REQUEST
        # ==========================================
        equipment_response = requests.post(
            EQUIPMENT_URL,
            headers=headers,
            json=equipment_payload,
            verify=False
        )

        print("Equipment API Status Code:", equipment_response.status_code)

        # ==========================================
        # CONVERT RESPONSE TO JSON
        # ==========================================
        equipment_data = equipment_response.json()

        # ==========================================
        # CHECK RECORDS
        # ==========================================
        if not equipment_data:
            print("\nNo More Records Found")
            break

        print(f"Total Records In Page {page_no} : {len(equipment_data)}")

        # ==========================================
        # LOOP THROUGH ALL RECORDS
        # ==========================================
        for item in equipment_data:

            equipmentId = item.get("equipmentId")
            equipmentCode = item.get("equipmentCode")
            description = item.get("description")
            deviceId = item.get("deviceId")
            customerCode = item.get("customerCode")
            latitude = item.get("latitude")
            longitude = item.get("longitude")
            modelCode = item.get("modelCode")
            siteName = item.get("siteName")
            siteCode = item.get("siteCode")
            hierarchyName = item.get("hierarchyName")
            subCategoryName = item.get("subCategoryName")
            manufacturingYear = item.get("manufacturingYear")
            commissioningDate = item.get("commissioningDate")
            warrantyExpiry = item.get("warrantyExpiry")
            sectorName = item.get("sectorName")
            fuelConfigurationName = item.get("fuelConfigurationName")
            active = item.get("active")

            # ==========================================
            # INSERT INTO SQL SERVER
            # ==========================================
            cursor.execute("""
            INSERT INTO AirAlert_EquipmentDetails
            (
                equipmentId,
                equipmentCode,
                description,
                deviceId,
                customerCode,
                latitude,
                longitude,
                modelCode,
                siteName,
                siteCode,
                hierarchyName,
                subCategoryName,
                manufacturingYear,
                commissioningDate,
                warrantyExpiry,
                sectorName,
                fuelConfigurationName,
                active
            )
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
            """,

            equipmentId,
            equipmentCode,
            description,
            deviceId,
            customerCode,
            latitude,
            longitude,
            modelCode,
            siteName,
            siteCode,
            hierarchyName,
            subCategoryName,
            manufacturingYear,
            commissioningDate,
            warrantyExpiry,
            sectorName,
            fuelConfigurationName,
            active
            )

        # ==========================================
        # COMMIT PAGE DATA
        # ==========================================
        conn.commit()

        print(f"Page {page_no} Loaded Successfully")

        # ==========================================
        # NEXT PAGE
        # ==========================================
        page_no += 1

    print("\nAll Pages Loaded Successfully Into SQL Server")

except Exception as e:
    print("\nError:", str(e))

finally:
    cursor.close()
    conn.close()