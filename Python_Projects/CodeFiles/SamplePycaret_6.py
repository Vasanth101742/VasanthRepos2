# import pandas as pd
# from openpyxl import load_workbook

# def append_df_to_excel(filename, df, sheet_name='Sheet1'):
#     try:
#         # Try to open an existing workbook
#         book = load_workbook(filename)
#         writer = pd.ExcelWriter(filename, engine='openpyxl', mode='a')
#         writer.book = book

#         if sheet_name in book.sheetnames:
#             startrow = book[sheet_name].max_row
#         else:
#             startrow = 0

#         # Write without writing the header if appending
#         df.to_excel(writer, sheet_name=sheet_name, startrow=startrow, index=False, header=False)
#         writer.save()
#         writer.close()
#     except FileNotFoundError:
#         # File does not exist, create it with headers
#         df.to_excel(filename, sheet_name=sheet_name, index=False)

# # Example usage:
# data = pd.DataFrame({
#     'A': [10, 20],
#     'B': [30, 40]
# })

# append_df_to_excel('my_data.xlsx', data)

#-------------------------------------------------------------------------

# import pandas as pd

# df = pd.DataFrame(0, index=range(3), columns=['X', 'Y', 'Z'])
# print(df)

# for i in range(len(df)):
#     for j, col in enumerate(df.columns):
#         df.at[i, col] = i + j

# print(df)


#------------------------------------------------------------------
# from datetime import datetime, timedelta
# MonthsConsidered=24
# import pandas as pd
# # startdate=datetime.today()
# # startdate=startdate.replace(day=1)
# # startdate=startdate.date()
# # print(startdate)

# import TimeSeries_Pycaretver2
# df1=TimeSeries_Pycaretver2.filtered_df
# print(df1)

# # #Method 2:  If Monthend Dates are considered------------------------------------------
# today = datetime.today()
# date_24_days_ago = today - timedelta(days=MonthsConsidered)
# date_24_days_ago=date_24_days_ago.date()

# Index_date= pd.date_range(start=date_24_days_ago, periods=MonthsConsidered #+forecaststeps
#                           , freq='D')
# #print(Index_date)
# #print(type(Index_date))
# df1_new2=pd.DataFrame(Index_date)
# #print(type(df1))
# #print(df1_new)

# #data1=File1.df1
# # print(df1.dtypes)
# # print(df1)

# df1_new2[['MonthEndDate','Qty']]=df1[['MonthEndDate','Qty']]
# df1_new2.columns = ['Index_date', 'MonthEndDate', 'Qty']
# #df1_new2.set_index('Index_date', inplace=True)
# df1_new2['Qty'] = df1_new2['Qty'].fillna(0)


# print(df1_new2)

#-------------------------------------------------------------------


# import pandas as pd

# df = pd.DataFrame(columns=['A', 'B'])

# for i in range(5):
#     new_row = pd.DataFrame({'A': [i], 'B': [i * 2]})
#     df = pd.concat([df, new_row], ignore_index=True)

# print(df)


#-----------------------------------------------------------------


# import pandas as pd
# import pyarrow as pa
# import turbodbc

# # Example DataFrame
# df = pd.DataFrame({
#     'id': [1, 2, 3],
#     'transaction_dt': pd.to_datetime(['2025-07-01', '2025-07-02', '2025-07-03']),
#     'units': [4, 5, 6],
#     'measures': [30.5, 26.3, 28.1],
# })

# # Convert DataFrame to pyarrow Table (zero-copy where possible)
# table = pa.Table.from_pandas(df)

# # Build a SQL Server connection with turbodbc
# conn = turbodbc.connect(
#     driver='{ODBC Driver 17 for SQL Server}',
#     server='your_server',
#     database='your_db',
#     uid='your_user',
#     pwd='your_password'
# )
# cursor = conn.cursor()

# # Bulk insert using column-wise binding
# insert_sql = """
# INSERT INTO dbo.your_table (id, transaction_dt, units, measures)
# VALUES (?, ?, ?, ?)
# """
# cursor.executemanycolumns(insert_sql, table)
# conn.commit()
# cursor.close()
# conn.close()

# #-----------------------------------------------------------------------------

# import pandas as pd

# df = pd.DataFrame({'date': ['2021-02', '2021-03'], 'Count': [100, 200]})
# # Convert string to Period(M)
# df['date'] = pd.to_datetime(df['date']).dt.to_period('M')
# print(df['date'])
# # dtype is period[M]

# # Convert Period to Timestamp
# df['date_ts'] = df['date'].dt.to_timestamp()
# print(df['date_ts'])
# # dtype is datetime64[ns]

# # Format or use as datetime
# df['formatted'] = df['date_ts'].dt.strftime('%Y-%m-%d %H:%M:%S')

# #------------------------------------------------------------------------------

# #1. Select a Single Row by Label

# df.loc['row_label']

# #2. Select Specific Rows and Columns

# df.loc[['row1', 'row2'], ['col1', 'col2']]

# #3. Select Rows Based on a Condition

# df.loc[df['Age'] > 30]

# #4. Select Rows and Columns with a Condition

# df.loc[df['Age'] > 30, ['Name', 'City']]

# #5. Modify Values in a DataFrame

# df.loc[df['Age'] > 30, 'Status'] = 'Senior'


from datetime import datetime, timedelta
import pandas as pd
import File1

# Step 1: DateMaster Generation--------------------------------------------------

startdate=datetime.today() - pd.DateOffset(months=24)
print("startdate : ",startdate)
startdate=startdate.replace(day=1)
startdate=startdate.date()
Index_date= pd.date_range(start=startdate
                          ,periods=24
                           ,freq='M')

print(Index_date)

df_DateMaster=pd.DataFrame(Index_date)
#print(type(df1_new))

df_DateMaster.columns = ['Index_date']
print('df_DateMaster before : \n',df_DateMaster)
# df_DateMaster['Index_date']=df_DateMaster['Index_date'].dt.date() #Error: Series Object is not callable
# print('df_DateMaster after : \n',df_DateMaster)

#End : Step 1: DateMaster Generation------------------------------------------------------
#Step 2: Source Data Generation------------------------------------------------------
df=File1.df11
df_data=df.loc[(df['Organ'] == 'India') & (df['item'] == '000111770'),['Organ','item','Item_desc','MonthEndDate','Qty']]
print(df_data)

# print('df.dtypes',df.dtypes)
# print('result.dtypes',df_DateMaster.dtypes)

#End : Step 2: Source Data Generation------------------------------------------------------
#Step 3: Time Series Data Generation------------------------------------------------------
result = pd.merge(df_DateMaster, df_data, left_on='Index_date', right_on='MonthEndDate', 
                  how='left', suffixes=('_left', '_right'))
#print(result,len(pd.notna(result['Organ']))>3)

#Updating the Missing Values
#result.loc[result['Organ'].isna(), 'Organ'] = result.loc[result['Organ'].notna(), 'Organ'] #No Use
#df.assign(y=df.y.where(~(df.x>3),50))
#result.assign(Organ=result.Organ.where(~(result.len(pd.notna(result['Organ']))>3),'Hai'))

print(result)
#End : Step 3: Time Series Data Generation------------------------------------------------------



