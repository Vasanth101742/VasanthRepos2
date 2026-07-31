from tsfresh import extract_features
import pandas as pd

# Sample data frame with time and value columns
df = pd.DataFrame({
    'id': [1]*len(ts),
    'time': range(len(ts)),
    'value': ts
})

features = extract_features(df, column_id='id', column_sort='time')
print(features.head())