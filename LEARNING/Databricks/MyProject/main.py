from pyspark.sql import SparkSession

# Create a local Spark JAVAsession
spark = (
    SparkSession.builder
    .appName("MyFirstPySparkApp")
    .master("local[*]")
    .getOrCreate()
)

# Create sample data
data = [
    ("Alice", 25),
    ("Bob", 30),
    ("Charlie", 35),
]

columns = ["name", "age"]

df = spark.createDataFrame(data, columns)

# Display the data
df.show()

# Run a Spark SQL-style operation
df.filter(df.age >= 30).show()

# Stop Spark
spark.stop()
