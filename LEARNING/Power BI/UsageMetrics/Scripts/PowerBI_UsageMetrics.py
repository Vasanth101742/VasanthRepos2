import os
import time
import requests
import pandas as pd

from azure.identity import ClientSecretCredential




# ---------------------------------------------------------
# Configuration
# ---------------------------------------------------------

#Method 1:
# TENANT_ID = os.environ["POWERBI_TENANT_ID"]
# CLIENT_ID = os.environ["POWERBI_CLIENT_ID"]
# CLIENT_SECRET = os.environ["POWERBI_CLIENT_SECRET"]

#Method 2:
TENANT_ID     = "50f40674-931c-4d09-ae8a-bb8fde36b912"
CLIENT_ID     = "403fbac6-e27b-4fc4-866f-7d8520ba0941"
CLIENT_SECRET = "FLR8Q~8F083PJK.0BBFijWgOcyk88QjBzoArhc8u"



POWERBI_BASE_URL = "https://api.powerbi.com/v1.0/myorg"


# ---------------------------------------------------------
# Authentication
# ---------------------------------------------------------

credential = ClientSecretCredential(
    tenant_id=TENANT_ID,
    client_id=CLIENT_ID,
    client_secret=CLIENT_SECRET
)


def get_access_token():

    token = credential.get_token(
        "https://analysis.windows.net/powerbi/api/.default"
    )

    return token.token


# ---------------------------------------------------------
# Generic GET request
# ---------------------------------------------------------

def powerbi_get(url, params=None):

    token = get_access_token()

    headers = {
        "Authorization": f"Bearer {token}"
    }

    response = requests.get(
        url,
        headers=headers,
        params=params,
        timeout=60
    )

    # Throttling
    if response.status_code == 429:

        retry_after = int(
            response.headers.get("Retry-After", "60")
        )

        print(
            f"API throttled. Waiting {retry_after} seconds..."
        )

        time.sleep(retry_after)

        return powerbi_get(url, params)

    response.raise_for_status()

    return response.json()


# ---------------------------------------------------------
# Get all reports
# ---------------------------------------------------------

def get_all_reports():

    print("Getting Power BI reports...")

    url = (
        f"{POWERBI_BASE_URL}"
        "/admin/reports"
    )

    response = powerbi_get(url)

    reports = response.get(
        "value",
        []
    )

    print(
        f"Reports returned: {len(reports)}"
    )

    return reports


# ---------------------------------------------------------
# Get activity events for one day
# ---------------------------------------------------------

def get_activity_events(
    start_datetime,
    end_datetime
):

    print(
        f"Getting activity events: "
        f"{start_datetime} → {end_datetime}"
    )

    url = (
        f"{POWERBI_BASE_URL}"
        "/admin/activityevents"
    )

    params = {
        "startDateTime": f"'{start_datetime}'",
        "endDateTime": f"'{end_datetime}'",
    }

    all_events = []

    while True:

        response = powerbi_get(
            url,
            params
        )

        events = response.get(
            "activityEventEntities",
            []
        )

        all_events.extend(events)

        continuation_token = response.get(
            "continuationToken"
        )

        continuation_uri = response.get(
            "continuationUri"
        )

        if continuation_token:

            print(
                f"Continuation token received. "
                f"Events so far: {len(all_events)}"
            )

            params = {
                "continuationToken":
                    continuation_token
            }

        elif continuation_uri:

            print(
                "Continuation URI received."
            )

            url = continuation_uri
            params = None

        else:

            break

    print(
        f"Total events: {len(all_events)}"
    )

    return all_events


# ---------------------------------------------------------
# Filter ViewReport events
# ---------------------------------------------------------

def filter_view_reports(events):

    view_events = [
        event
        for event in events
        if event.get("Activity") == "ViewReport"
    ]

    print(
        f"ViewReport events: {len(view_events)}"
    )

    return view_events


# ---------------------------------------------------------
# Create usage dataframe
# ---------------------------------------------------------

def create_usage_dataframe(events):

    if not events:

        return pd.DataFrame()

    df = pd.DataFrame(events)

    columns = [
        "CreationTime",
        "UserId",
        "WorkspaceId",
        "ReportId",
        "ReportName",
        "ConsumptionMethod"
    ]

    available_columns = [
        col
        for col in columns
        if col in df.columns
    ]

    df = df[available_columns]

    df["CreationTime"] = pd.to_datetime(
        df["CreationTime"],
        errors="coerce"
    )

    return df


# ---------------------------------------------------------
# Aggregate usage
# ---------------------------------------------------------

def aggregate_usage(df):

    if df.empty:

        return pd.DataFrame()

    usage = (
        df
        .groupby(
            [
                "WorkspaceId",
                "ReportId",
                "ReportName"
            ],
            dropna=False
        )
        .agg(
            Views=(
                "ReportId",
                "count"
            ),

            UniqueUsers=(
                "UserId",
                "nunique"
            ),

            LastViewed=(
                "CreationTime",
                "max"
            )
        )
        .reset_index()
    )

    return usage


# ---------------------------------------------------------
# Main
# ---------------------------------------------------------

def main():

    # 1. Get report inventory

    reports = get_all_reports()

    reports_df = pd.DataFrame(
        reports
    )

    print(
        f"Report inventory rows: "
        f"{len(reports_df)}"
    )


    # 2. Get yesterday's activity

    start_datetime = (
        "2026-09-03T00:00:00.000Z"
    )

    end_datetime = (
        "2026-09-03T23:59:59.999Z"
    )


    events = get_activity_events(
        start_datetime,
        end_datetime
    )


    # 3. Filter ViewReport

    view_events = filter_view_reports(
        events
    )


    # 4. Convert to dataframe

    event_df = create_usage_dataframe(
        view_events
    )


    # 5. Aggregate

    usage_df = aggregate_usage(
        event_df
    )


    # 6. Save raw events

    event_df.to_parquet(
        "powerbi_view_events.parquet",
        index=False
    )


    # 7. Save aggregated usage

    usage_df.to_parquet(
        "powerbi_report_usage.parquet",
        index=False
    )


    # 8. Save CSV for easy inspection

    usage_df.to_csv(
        "powerbi_report_usage.csv",
        index=False
    )


    print(
        "\nCompleted successfully."
    )


if __name__ == "__main__":

    main()
