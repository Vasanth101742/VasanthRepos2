# import spark
# import pyspark as ps
# df = spark.read.parquet(
#     "https://storageaccountelgibi.blob.core.windows.net/elgibi-container/TTCCOM110ALL"
#     # "abfss://container@storageaccount.dfs.core.windows.net/customer/"
# )

# df.show()


import pandas as pd

df = pd.read_parquet(
    "abfs://elgibi-container@storageaccountelgibi.dfs.core.windows.net/TTCCOM110ALL/TTCCOM110ALL \
.parquet",
    storage_options={
        "account_name": "storageaccountelgibi",
        "tenant_id": "YOUR_TENANT_ID",
        "client_id": "YOUR_CLIENT_ID",
        "client_secret": "YOUR_CLIENT_SECRET"
    }
)

print(df.head())