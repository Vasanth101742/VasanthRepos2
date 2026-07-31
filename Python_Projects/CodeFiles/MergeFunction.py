import pandas as pd


India1=pd.DataFrame({
    "City":["Coimbatore","Delhi","Mumbai","Delhi"],
    "Temp":[27,27,29,100],
    "Fact":[1,2,3,4]
    }
    #,index=[1,2,3,4]
    )

India2=pd.DataFrame({
    "City":["Coimbatore","Delhi","Mumbai"],
    "Temp":[27,30,29],
    "Value":[10,20,30]
    }
    #,index=[1,2,3]
   )
print(India1.keys())
print(India1.index)
print(India1.head())
India1.set_index("City",inplace=True)

# a=pd.merge(India1,India2,on="City",how="outer",indicator=True)
# print(a) #While printing the output column names will be suffixed by x and y

a=pd.merge(India1,India2,left_on=["City","Temp"],right_on=["City","Temp"],how="left",indicator=True
           #suffixes=["_df1","_df2"]
           )
print(a)
