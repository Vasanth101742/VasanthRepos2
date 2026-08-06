import pandas as pd
from datetime import datetime
from datetime import timedelta
#import requests
import time
import random

#Step 1: Creating Json data---------------------------------------------------------------------------------------------

# Class for data generation

def data_generation():
    surr_id=random.randint(1,3)
    speed=random.randint(20,200)
    date=datetime.today().strftime("%Y-%m-%d")
    time=datetime.now().isoformat()

    return(surr_id,speed,date,time)


#Defining Main Function

if __name__=='__main__':
    data_raw=[]
    for i in range(1):
        row=data_generation()
        data_raw.append(row)
        print("Raw Data :",data_raw)

    #Set the Header Record
    header=["surr_id","speed","date","time"]

    #Create a DataFrame
    df1=pd.DataFrame(data_raw,columns=header)

    #Convert to json format
    data_json=bytes(df1.to_json(orient="records"),encoding='utf-8')
    print("json data : ",data_json)

#End: Step 1: Creating Json data----------------------------------------------------------------------------------------

