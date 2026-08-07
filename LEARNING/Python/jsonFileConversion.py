import json
import pandas as pd

# Read JSON file
with open("USA_DFU_master.json", "r") as f:
    data = json.load(f)

# Extract rows
rows = [item["values"][0] for item in data["value"]]

# Specify column names
columns = ["Region", "Item", "Item_Description", "Item_Category", "Demand_Forecasting_Unit_DFU", "India_TPL", "Variant", "Frame", "Product group", "GSC_class", "RRS_classification", "Supplier"]

# Create DataFrame
df = pd.DataFrame(rows, columns=columns)

# Save to Excel
df.to_excel("output.xlsx", index=False)

# Or save to CSV
df.to_csv("output.csv", index=False)

print(df)