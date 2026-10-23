from pyspark.sql import SparkSession

# Create a local Spark JAVAsession
spark = (
    SparkSession.builder
    .appName("MyFirstPySparkApp")
    .master("local[*]")
    .getOrCreate()
)

# ADLS Gen2 path
parquet_path = (
    "abfss://elgibi-container@storageaccountelgibi.dfs.core.windows.net/"
    "TTCCOM110ALL/TTCCOM110ALL"
)

# Read Parquet data
df = spark.read.parquet(parquet_path)

# Display the first 100 records
df.show(100, truncate=False)

# Print schema
df.printSchema()