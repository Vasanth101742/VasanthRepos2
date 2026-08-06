# import pandas as pd

# # Sample data for the left DataFrame
# df_left = pd.DataFrame({
#     'user_id': [1, 2, 3, 4],
#     'name': ['Alex', 'Amy', 'Allen', 'Alice'],
#     'subject_id': ['sub1', 'sub2', 'sub4', 'sub6']
# })

# # Sample data for the right DataFrame
# df_right = pd.DataFrame({
#     'student_id': [2, 3, 4, 5],
#     'name': ['Billy', 'Brian', 'Bran', 'Bryce'],
#     'subject_id': ['sub2', 'sub4', 'sub3', 'sub6']
# })

# # Performing a left outer join
# result = pd.merge(df_left, df_right, left_on=['user_id', 'subject_id'], right_on=['student_id', 'subject_id'], how='left', suffixes=('_left', '_right'))

# print(result)

#-----------------------------------------------------------------------
import pandas as pd

# Determine start and end
end = pd.Timestamp.today().normalize()
start = end - pd.DateOffset(months=24) + pd.Timedelta(days=1)  # inclusive of start month

# Full daily range
dates = pd.date_range(start=start, end=end, freq='D')

# Optional: convert to DataFrame
df = pd.DataFrame({'date': dates})
print(df)