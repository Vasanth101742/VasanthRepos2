import pandas as pd
import sqlite3  # Using SQLite for this example

# Sample DataFrame
df = pd.DataFrame({
    'A': [1, 2, 3, 4],
    'B': [5, 6, 7, 8]
})

# Create a connection to SQLite database
conn = sqlite3.connect('example.db')

# Define the name of the table to insert into
table_name = 'sample_table'

# Initialize the row counter
rows_processed = 0

# Write the data to SQL in chunks (e.g., chunk size of 2)
chunksize = 2
for chunk_start in range(0, len(df), chunksize):
    chunk_end = chunk_start + chunksize
    chunk = df.iloc[chunk_start:chunk_end]
    
    # Write the chunk to the SQL database
    chunk.to_sql(table_name, conn, if_exists='replace', index=False, method='multi')
    
    # Update the row count
    rows_processed += len(chunk)

print(f"Number of rows processed: {rows_processed}")

# Close the connection
conn.close()