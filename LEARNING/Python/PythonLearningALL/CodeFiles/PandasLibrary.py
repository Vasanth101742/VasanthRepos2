import pandas as pd
import numpy as np
import csv
import excel
import matplotlib.pyplot as plt
# import xlrd
# import openpyxl




#series1= pd.tseries()
#print(series1)

#Source: https://www.youtube.com/watch?v=F6kmIpWWEdU&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=2

#File Input -----------------------------------------------------------------------------------------------------------
df1=pd.read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book1.csv')
print(df1)


print((df1['Collection'].sum())/2)
print(df1['Area Code'].min())
print(df1['Area Code'].max())


df1.fillna(0,inplace=True)  #Replace NaN with 0 in the dataframe
print(df1['Collection'].mean())


#print(df1['Due Date'].min())  # Date is not automatically detectable
#df1['Due Date']=df1['Due Date'].astype('datetime') #Error
print(df1['Due Date'])

#Method 1: Date Conversion
df1['Due Date']=pd.to_datetime(df1['Due Date'], errors='coerce')
print(df1['Due Date'])
print(df1['Due Date'].min())


#Method 2: Date Conversion for two or more columns
cols = ['Docdt','Due Date']
df1[cols] = df1[cols].apply(pd.to_datetime)
print(df1[cols])


df2=df1['Collection'][df1['Due Date']==df1['Due Date'].min()]   #Fetch the collection amounts on the Min Due date
#df1['Collection'].sum()[df1['Due Date']==df1['Due Date'].min()]
print(df2)

#-----------------------------------------------------------------------------------------------------------------------
#DataFrame Introduction

#Creating DF from the CSV File
df1=pd.read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book1.csv')
df1.fillna(0,inplace=True)  #Replace NaN with 0 in the dataframe, inplace=True indicates to modify the original one
print(df1)

#Creating DF using Dictionary
EmpDF={
    'EmpCode':[1,2,3,4,5],
    'EmpName':['Ram','Venkat','Priya','Prem','Arun'],
    'Experience':[5,2,7,1,6],
    'Salary':[20,15,50,15,40]
}

#EmpDF=pd.DataFrame([EmpDF])  #Note the difference with next line(58)
EmpDF=pd.DataFrame(EmpDF)  #Converting the Dictionary into DataFrame
print(EmpDF)

[rows,columns]=EmpDF.shape    # shape() --Returns error as Tuple object is not callable
print(rows,columns)



#Data Slicing in DataFrame
print(EmpDF)         #Print all rows
print(EmpDF[:])      #Print all rows
print(EmpDF[2:5])    #Print 2,3 and 4th row
print(EmpDF.head(2)) #print only top two rows
print(EmpDF.tail(2)) #print only bottom two rows

print(EmpDF.columns)            #Printing the Column: Method1

for col in EmpDF.columns:       #Printing the Column: Method2
     print(col)

print(EmpDF['EmpName'])         #Printing a specific column values

print(type(EmpDF['EmpName']))   #By default, type of a data frame is series

print(EmpDF[['EmpName','Experience']])  #Printing only the required columns



#Conditional selection of data
print(EmpDF[EmpDF['EmpName']=='Prem'])
print(EmpDF[EmpDF['Salary']>=20])
#print(EmpDF[EmpDF['Salary']>=20 and EmpDF['Salary']<50])  #Fetching data based on two conditions
print(EmpDF[EmpDF['Salary']==EmpDF['Salary'].max()])

print(EmpDF['EmpName'][EmpDF['Salary']>=20])  #Print only the EmpName values matching to the condition
print(EmpDF[['EmpName','Experience']][EmpDF['Salary']>=20])  #Print only the specified columns values matching to the condition


#Replacing Index with one of the Field in Data Frame
EmpDF.set_index('EmpCode',inplace=True)  #inplace=True indicates to modify the original one
print(EmpDF)

print(EmpDF.loc[4])  #Fetching data baed on new index

EmpDF.reset_index(inplace=True)  #Resetting the Index
print(EmpDF)


#Any Column of any data type can be used as Index
EmpDF.set_index('EmpName',inplace=True)  #inplace=True indicates to modify the original one
print(EmpDF)
print(EmpDF.loc['Arun'])
EmpDF.reset_index(inplace=True)

#Static operations
# print(EmpDF['Salary'].sum())
# print(EmpDF['Salary'].min())
# print(EmpDF['Salary'].max())
#
#
# df1.fillna(0,inplace=True)  #Replace NaN with 0 in the dataframe
# print(EmpDF['Salary'].mean())
# print(EmpDF['Salary'].var())
# print(EmpDF['Salary'].std())
# print(EmpDF.describe())     #Print the complete statistics

#-----------------------------------------------------------------------------------------------------------------------
#Different ways of creating a Data Frame

#Source: Python Pandas Tutorial 3: Different Ways Of Creating DataFrame
#https://www.youtube.com/watch?v=3k0HbcUGErE&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=3


#Creating DF from CSV and Excel Files
df1=pd.read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book1.csv')
print(df1)
print(df1.head(5))


df1=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\Book2.xlsx","Book1")
print(df1)
print(df1.tail(5))


#Creating DF using Dictionary
EmpDF={
    'EmpCode':[1,2,3,4,5],
    'EmpName':['Ram','Venkat','Priya','Prem','Arun'],
    'Experience':[5,2,7,1,6],
    'Salary':[20,15,50,15,40]
}

#EmpDF=pd.DataFrame([EmpDF])  #Note the difference with next line(58)
EmpDF=pd.DataFrame(EmpDF)  #Converting the Dictionary into DataFrame
print(EmpDF)

# Creating DF using Tuples

#a=[
#     (1,2,3,4,5),
#     ('Ram','Venkat','Priya','Prem','Arun'),
#     (5,2,7,1,6),
#     (20,15,50,15,40)
#]

a=[
    (1,'Ram',5,20),
    (2,'Venkat',2,15),
    (3,'Priya',7,50),
    (4,'Prem',1,15),
    (5,'Arun',6,40)
]

EmpDF=pd.DataFrame(a,columns=["EmpCode","EmpName","Experience","Salary"]) # while converting data from tuple data gets Transposed.
#EmpDF=EmpDF.transpose
print(EmpDF)

#Creating DF using list of Dictionaries
a=[
    {"EmpCode":1,"EmpName":"Ram","Experience":5,"Salary":20},
    {"EmpCode":2,"EmpName":"Venkat","Experience":2,"Salary":15},
    {"EmpCode":3,"EmpName":"Priya","Experience":7,"Salary":50},
    {"EmpCode":4,"EmpName":"Prem","Experience":1,"Salary":15},
    {"EmpCode":5,"EmpName":"Arun","Experience":6,"Salary":40}
]
print(a)
EmpDF=pd.DataFrame(a)
print(EmpDF)


#-----------------------------------------------------------------------------------------------------------------------
#Read Write Excel CSV Fie
#Source : https://www.youtube.com/watch?v=-0NwrcZOKhQ&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=4

CustDF=pd.read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book3.csv') #View the column names in the output
print(CustDF)
CustDF=pd.read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book3.csv',skiprows=1) #Data will be fetched by skipping 1st row in the file
print(CustDF)
CustDF=pd.read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book3.csv',header=1) #Data will be fetched by skipping 1st row in the file; Header=0 implies first row
print(CustDF)

#if column names are not available in the input file
CustDF=pd.read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book3.1.csv',header=None,names=['C1','C2','C3','C4','C5','C6','C7','C8','C9'])
print(CustDF)

#Filteing rows and replacing Nulls

CustDF=pd.read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book3.csv',header=1,nrows=3,na_values=['not available','null',-1])
print(CustDF)
#Data will be fetched by skipping 1st row in the file; Header=0 implies first row
#wherever 'not available' or 'nulls' or -1 in the input data, they are replaced by NaN.
# if we do not want to replace nulls of any particular column then we have to go for dictionaries as below.

CustDF=pd.read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book3.csv',header=1,nrows=3,
                   na_values={'Cust Name':['CU1P01781','null',-1], #values in this list are replaced by NaN for Cust Name column
                              'Company':[401]   #values in this list are replaced by Company column
                              }
                   )
print(CustDF)


#Writing to CSV File

CustDF.to_csv('CustDF.csv',index=False) # in this output NaN values are shown as blanks.
CustDF.to_csv('CustDF.csv',index=False,columns=['Company','Area Code']) # only these two columns will be in the output file. Automatically overwritten the old file
CustDF.to_csv('CustDF.csv',index=False,header=False) # column names will be skipped.

# reading and manipulating Excel File data

def convert_AreaName_cellwise(cell):
    if cell=="PUNE":
        return "PUNE Converted"
    #if cell!="PUNE":
     #   return None
    return cell




df1=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\Book2.xlsx","Book1",
                  converters={
                      "Area Name":convert_AreaName_cellwise
                  })
# Converters Argument will consider only Dictionary by default.
#print(df1.head(5))
#converter can be used for replacing Nulls , NA or any data to be replaced in a column of an excel file. go to line 230

df1.to_excel("df1.xlsx",sheet_name="Collection")
df1.to_excel("df2.xlsx",sheet_name="Collection",index=None)
df1.to_excel("df3.xlsx",sheet_name="Collection",startrow=2,startcol=2)


#Multiple dataframes into an Excel File
a={
    'EmpCode':[1,2,3,4,5],
    'EmpName':['Ram','Venkat','Priya','Prem','Arun'],
    'Experience':[5,2,7,1,6],
    'Salary':[20,15,50,15,40]
}
a=pd.DataFrame(a)

b=[
    {"EmpCode":1,"EmpName":"Ram","Experience":5,"Salary":20},
    {"EmpCode":2,"EmpName":"Venkat","Experience":2,"Salary":15},
    {"EmpCode":3,"EmpName":"Priya","Experience":7,"Salary":50},
    {"EmpCode":4,"EmpName":"Prem","Experience":1,"Salary":15},
    {"EmpCode":5,"EmpName":"Arun","Experience":6,"Salary":40}
]
b=pd.DataFrame(b)

with pd.ExcelWriter("TwoDataFrames.xlsx") as writer:
    a.to_excel(writer,sheet_name="a")
    b.to_excel(writer, sheet_name="b")



#-----------------------------------------------------------------------------------------------------------------------
#Python Pandas Tutorial 5: Handle Missing Data: fillna, dropna, interpolate
#Source: https://www.youtube.com/watch?v=EaGbS7eWSs0&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=5

a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\WeatherData.xlsx","Sheet1",parse_dates=["day"])
# parse_dates function implies conversion of dates from string format to date format
a.set_index('day',inplace=True)
print(a)

#Method 1
# a.fillna(0,inplace=True)
# print(a)

# #Method 2
# a.fillna({
#     'temperature':0,
#     'windspeed':0,
#     'event':'no event'
# }
#     ,inplace=True
#     )
# print(a)

#Method 3
# a.fillna(method="ffill",limit=1,inplace=True)  #Forward fill only to next nullable row
# print(a)

# a.fillna(method="bfill",inplace=True)  #backward fill rowwise
# print(a)

#a.fillna(method="bfill",axis="columns",inplace=True)  #backward fill columnwise. Note: Direct manipulation not working here
# b=a.fillna(method="bfill",axis="columns")  #backward fill columnwise
# print(b)

#Method 4
# a.interpolate(inplace=True)  #Linear prediction by python by means of previous and next values in the row
# print(a)
# a.interpolate(method="time",inplace=True)  #Linear prediction by python by means of previous and next values in the row
# print(a)

#Method 5
# a.dropna(inplace=True) #if any NaN is there in the row, that row will be dropped.
# #above method removes all the data if atleast one column have NaN in a row
# print(a)

# a.dropna(how="all",inplace=True) #implies if all the columns have NaN in a row, only that particular row needs to be removed.
# print(a)

#a.dropna(thresh=1,inplace=True) #If a row has atleast one non  NaN value, keep that row
a.dropna(thresh=2,inplace=True)  #If a row has atleast two non  NaN value, keep that row
print(a)

#Since index is to be in continous order from the above result, 2017-01-04 is missing, inorder to avoid that
#follow the below indexing method
dt=pd.date_range("2017-01-01","2017-01-15")
idx=pd.DatetimeIndex(dt)
a=a.reindex(idx)
print(a)

#-----------------------------------------------------------------------------------------------------------------------
#Python Pandas Tutorial 6. Handle Missing Data: replace function
#Source: https://www.youtube.com/watch?v=XOxABiMhG2U&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=6

a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\WeatherData2.xlsx","Sheet1",parse_dates=["day"])
a=pd.DataFrame(a)
print(a)

#Method1: Using List
# a=a.replace([-99999,88888,0],np.NaN)
# print(a)

#Method2: using Dictionary(more customized approach)
a=a.replace({
    "temperature":[-99999,88888],
    "windspeed":[-99999,88888],
    "event":0},np.NaN)
print(a)

a=a.replace({"snow":"HEAVY SNOW",
             np.NaN:"Not available"
             })
print(a)

#Method3: using Dictionary(Pattern replacement)
a=a.replace({"temperature" : ["Not"],
             "event":["avai"]
             },'NA',regex=True)
print(a)

#Method4: using List(series of values replacement)
a=a.replace(['Rain','Sunny','Snow','HEAVY SNOW','Not NAlable'],[1,2,3,4,"No Data"])
print(a)

#-----------------------------------------------------------------------------------------------------------------------
#Python Pandas Tutorial 7. Group By (Split Apply Combine)
#Source: https://www.youtube.com/watch?v=Wb2Tp35dZ-I&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=7


a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\WeatherData3.xlsx","Sheet1",parse_dates=["day"])
a=pd.DataFrame(a)
print(a)

b=a.groupby('city')
print(b)

for city in b:
    print(city)

print(b.get_group('mumbai'))
print (b.max())
#print (b.describe())

# plt.plot()
# plt.show()


#-----------------------------------------------------------------------------------------------------------------------
#Python Pandas Tutorial 8. Concat Dataframes
#Source: https://www.youtube.com/watch?v=WGOEFok1szA&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=8

India=pd.DataFrame({
    "City":["Coimbatore","Delhi","Mumbai"],
    "Temp":[27,30,29],
    "humidity": [80,82,90]
    })

usa=pd.DataFrame({
    "City":["NewYork","Texas","Chigago"],
    "humidity": [70,92,85],
    "CityID":[1,2,3],
    "Temp":[23,20,19]
    })

print(India)
print(usa)

#a=pd.concat([India,usa],sort=False)
a=pd.concat([India,usa],ignore_index=True,sort=False) #No of coumns in each dataframe is different but also it works !!
#ignore index option helps to get the continuity in the index instead of 0,1,2,0,1,2
print(a)


a=pd.concat([India,usa],keys=["India","USA"],sort=False) #if keys option is used, ignore_index should not be used
print(a)

print(a.loc["India"])  #getting a subset of a dataframe
print(a.loc["USA"])  #getting a subset of a dataframe


#Column level append: Method1
India1=pd.DataFrame({
    "City":["Coimbatore","Delhi","Mumbai"],
    "Temp":[27,30,29]
    })

India2=pd.DataFrame({
    "City":["Mumbai","Coimbatore","Delhi"],
    "humidity": [80,82,90]
    })
a=pd.concat([India1,India2],axis=1)  #axis=0 by default implies row level append ,axis=1 column level append
print(a)


#Column level append :Method2 with index for correct mapping of data
India1=pd.DataFrame({
    "City":["Coimbatore","Delhi","Mumbai"],
    "Temp":[27,30,29]
    },index=[1,2,3])

India2=pd.DataFrame({
    "City":["Mumbai","Coimbatore","Delhi"],
    "humidity": [80,82,90]
    },index=[3,1,2])
a=pd.concat([India1,India2],axis=1)  #axis=0 by default implies row level append ,axis=1 column level append
print(a)

#Adding a New column
b=pd.Series(["humid","Dry","Rain"],name="event")
print(b)
a=pd.concat([a,b],axis=1)
print(a)

#-----------------------------------------------------------------------------------------------------------------------
#Python Pandas Tutorial 9. Merge Dataframes
#Source : https://www.youtube.com/watch?v=h4hOPGo4UVU&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=9

#Since for concat function we need to explicitly mention the index of each dataframes in order to avoid
# incorrect mapping, we are going for merge function

India1=pd.DataFrame({
    "City":["Coimbatore","Delhi","Mumbai"],
    "Temp":[27,30,29]
    },index=[1,2,3])

India2=pd.DataFrame({
    "City":["Chennai","Coimbatore","Delhi"],
    "humidity": [80,82,90]
    },index=[3,1,2])
a=pd.merge(India1,India2,on="City")  #This will work as inner join i.e intersection
print(a)
a=pd.merge(India1,India2,on="City",how="outer",indicator=True) #indicator implies data obtained from which dataframe
print(a)

#Suffixes: when two data frames having same column name
India1=pd.DataFrame({
    "City":["Coimbatore","Delhi","Mumbai"],
    "Temp":[27,30,29]
    },index=[1,2,3])

India2=pd.DataFrame({
    "City":["Coimbatore","Delhi","Mumbai"],
    "Temp":[27,30,29]
    },index=[1,2,3])

a=pd.merge(India1,India2,on="City",how="outer",indicator=True)
print(a) #While printing the output column names will be suffixed by x and y

a=pd.merge(India1,India2,on="City",how="outer",indicator=True,suffixes=["_df1","_df2"])
print(a)

#-----------------------------------------------------------------------------------------------------------------------
#Python Pandas Tutorial 10. Pivot table
#Source: https://www.youtube.com/watch?v=xPPs59pn6qU&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=10

a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\WeatherData3.xlsx","Sheet1",parse_dates=["day"])
a=pd.DataFrame(a)
print(a)

#converting a specific column datatype in a data frame : below example Just for information
#a[day]=pd.to_datetime(a["day"])

b=a.pivot(index="day",columns="city")
print(b)





#Pivot table allows to summarize and aggregate the data
c=a.pivot_table(index="city",columns="event",aggfunc="sum",margins=True)
print(c)

d=a.pivot_table(index="city",columns="event",aggfunc="count")
print(d)

#Grouper
e=a.pivot_table(index=pd.Grouper(freq="M",key="day"),columns="city") #observe the date is automatically shown as Monthend date
print(e)


#-----------------------------------------------------------------------------------------------------------------------
# Python Pandas Tutorial 11. Reshape dataframe using melt
#Source: https://www.youtube.com/watch?v=oY62o-tBHF4&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=11


a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\MeltFunctionData.xlsx","Sheet1")
a=pd.DataFrame(a)
print(a)

b=pd.melt(a,id_vars=["Day"])
print(b)
print(b[b["variable"]=="Chennai"])

b=pd.melt(a,id_vars=["Day"],var_name="City",value_name="Temperature") #Explicitly defining the column names
print(b)

#-----------------------------------------------------------------------------------------------------------------------
#Python Pandas Tutorial 12. Stack Unstack
#Source: https://www.youtube.com/watch?v=BUOy4RUUepg&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=12


a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\StackUnStack.xlsx","Sheet1",header=[0,1])
a=pd.DataFrame(a)
print(a)
a_stacked=a.stack(level=0) # stack function will take the innermost header column and transpose it
print(a_stacked)  #Result not expected as shown in Jupiter Software tool
a_unstacked=a_stacked.unstack()
print(a_unstacked) #Result not expected as shown in Jupiter Software tool


#-----------------------------------------------------------------------------------------------------------------------
#Python Pandas Tutorial 13. Crosstab -->Contingency tables which displays the frequency distribution of the variables
#Source: https://www.youtube.com/watch?v=I_kUj-MfYys&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=13


a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\survey_Crosstab.xlsx","Sheet1",header=[0])
a=pd.DataFrame(a)
print(a)

b=pd.crosstab(a.Nationality,a.Handedness) #pd.crosstab(row to be displayed, column to be displayed)
print(b)

#Multiple columns
b=pd.crosstab(a.Sex,[a.Handedness,a.Nationality],margins=True) #include margins for getting column wise total
print(b)


#Multiple rows
b=pd.crosstab([a.Handedness,a.Nationality],a.Sex,margins=True) #include margins for getting column wise total
print(b)

b=pd.crosstab(a.Nationality,a.Handedness,normalize="index") #normalize implies dividing all the value by sum of the value
print(b)

#Aggregating the fact data based on other columns or dimensions
b=pd.crosstab(a.Sex,a.Handedness,values=a.Age,aggfunc=np.average) #normalize implies dividing all the value by sum of the value
print(b)