import pandas as pd
from sqlalchemy import create_engine
import LNConnection as LN
import numpy as np
import re
#-----------------------------------------------------------------------------------------------------------------------

engine = create_engine(LN.oracle_connection_string)
con=engine.connect()
#401

Company=[400,411,412,413,414,415,551,552,600]#,416,417,418,419,420,440,450,465,470,480,490,500,581,611,612,613,614,615,616,617,618,619,620,621,622,640,951]
a=pd.DataFrame() #Empty dataframe



for count1 in Company:
    #Query="select "+str(count1)+" as Company,t$sfcp,t$tran from erpnln.tcisli310"+str(count1)
    print("Fetcing data for :tcisli310"+str(count1))
    Query = "select "+str(count1)+''' as company, t$cofc as dpst, t$tran as trantype, t$orno as orderno, t$pono as positionno,
    t$idoc as invoice, t$ofbp as custcode, to_char(t$item) as item, t$rate$1 as rate1, t$rate$2 as rate2, t$txai as ed_amount,
    sum(t$amth$1) as amth1, sum(t$txah$1) as txah1,
    sum(t$amti) as foreign_currency_amount, sum(t$pric) as unitprice,
    sum(t$dqua) as deliveryqty, sum(t$amth$1) as sales_amount,t$sotp as saleordertype,t$stoa as stoa,t$cvat as taxcode
    from erpnln.tcisli310''' + str(count1) + \
    " group by t$cofc, t$tran, t$orno, t$pono, t$idoc, t$ofbp, t$item, t$rate$1, t$rate$2, t$txai,t$sotp,t$stoa,t$cvat"
    a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
tcisli310=pd.DataFrame(a)
a=pd.DataFrame() #Empty dataframe
#print(tcisli310.keys()) #Column Names of a data frame
#print(type(tcisli310.item[10]))  #ensure the data type
#print(tcisli310['item'])
#tcisli310.to_csv("tcisli310.csv")


for count1 in Company:
    print("Fetcing data for :ttdsls400" + str(count1))
    Query = "select " + str(count1) + '''as company, t$odat as orderdate,t$orno as orderno,t$ofbp as custcode,
    t$oref as segment, t$cbrn as lobcode, t$crep as salesrepcode
    from erpnln.ttdsls400''' + str(count1)
    # +" where cast(t$odat as date) < '26/Jan/2020' " \
    # +" and  "+str(count1)+" =401"
    a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
ttdsls400=a
a=pd.DataFrame() #Empty dataframe
print(ttdsls400.keys())
#ttdsls400.to_csv("ttdsls400.csv")
#print(type(ttdsls400.odat[1])) # how to find the datatype of a column

print("OrderDate Merge Started")
LN_Sales=pd.merge(tcisli310,ttdsls400[['company','orderno','custcode','orderdate']],\
        left_on=['company','orderno','custcode'],\
        right_on=['company','orderno','custcode'],how="left")#,left_index=False, right_index=False,validate=None,indicator=True)
#LN_Sales.to_csv("LN_Sales.csv")
#print(LN_Sales)
print("OrderDate Merge Completed")


#Remove white spaces i.e trim operation
#Method 1 : to be corrected
# LN_Sales_obj = LN_Sales.select_dtypes(['object'])
# print (LN_Sales_obj)
#LN_Sales[LN_Sales_obj.columns] = LN_Sales_obj.apply(lambda x: x.str.strip()) #not working

#Method 2: Working
#print(LN_Sales['item'])
LN_Sales['item'] = LN_Sales['item'].str.strip()
#print(LN_Sales['item'])




Query="select distinct trim(t$CADR) as cadr, concat(concat(t$BLDG,t$BLFL),t$BLUN) as deladdress  from erpnln.ttccom130400"
a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
ttccom130400=a
a=pd.DataFrame() #Empty dataframe
#print(ttccom130400)


print("DelAddress Merge Started")
LN_Sales=pd.merge(LN_Sales,ttccom130400[['cadr','deladdress']],left_on=['stoa'],right_on=['cadr'],how="left")#,left_index=False, right_index=False,validate=None,indicator=True)
LN_Sales.drop('cadr',axis=1,inplace=True)
print("DelAddress Merge Completed")
LN_Sales.to_csv("LN_Sales.csv")

# print(LN_Sales[(LN_Sales['company']==400) & (LN_Sales['saleordertype']=='222') ]) #condition based selection of data
# print(type(LN_Sales.company[0]))
# print(type(LN_Sales.saleordertype[0]))
# print(type(LN_Sales.orderno[0]))
# print(type(LN_Sales.dpst[0]))
#
# #Selecting a column based on Multiple conditions
# #print(LN_Sales[(LN_Sales['company']==400) & (LN_Sales['saleordertype']=='222') & (LN_Sales['orderno']=='280000001') & (LN_Sales['dpst']=='90110')]['custcode'])
# #Replacing a particular column value
# # LN_Sales.replace(to_replace=LN_Sales[(LN_Sales['company']==400) & (LN_Sales['saleordertype']=='222') & (LN_Sales['orderno']=='280000001') & (LN_Sales['dpst']=='90110')][['custcode']],\
# #                  value='it is working',inplace=True)
# #Selecting more than two columns based on Multiple conditions
# # print(LN_Sales[(LN_Sales['company']==400) & (LN_Sales['saleordertype']=='222') & (LN_Sales['orderno']=='280000001') & (LN_Sales['dpst']=='90110')]\
# #        [['company','saleordertype','orderno','dpst','custcode']])
#
LN_Sales.replace(to_replace=LN_Sales[(LN_Sales['company']==401) & (LN_Sales['saleordertype']=='217') & (LN_Sales['orderno']=='290001079') & (LN_Sales['dpst']=='70226')][['dpst']],\
                  value='70026',inplace=True)
LN_Sales.replace(to_replace=LN_Sales[(LN_Sales['company']==490) & (LN_Sales['saleordertype']=='219') & (LN_Sales['orderno']=='292003196') & (LN_Sales['dpst']=='70228')][['custcode']],\
                  value='70028',inplace=True)
#
# # print(LN_Sales[(LN_Sales['company']==401) & (LN_Sales['saleordertype']=='217') & (LN_Sales['orderno']=='290001079') & (LN_Sales['dpst']=='70226')]\
# #        [['company','saleordertype','orderno','dpst','custcode']])
# # print(LN_Sales[(LN_Sales['company']==490) & (LN_Sales['saleordertype']=='219') & (LN_Sales['orderno']=='292003196') & (LN_Sales['dpst']=='70228')]\
# #        [['company','saleordertype','orderno','dpst','custcode']])


#salesrepcode Updation

#SalesRepcode for Special Indents
Query='''select distinct 600 as Company,T$ORNO as orderno,T$REM1 as Segment,T$REM2 as salesrepcode,
      trim(T$REM10) as subdivision,T$REM11 as buyback from erpnln.tzzsls320600 '''
a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
tzzsls320600=a
a=pd.DataFrame() #Empty dataframe

print("SalesRep Merge Started")
#
# #if merge function contains sliced dataframe then only the sliced data will be stored in the LHS.
# #LN_Sales=pd.merge(LN_Sales[LN_Sales['company']==600],tzzsls320600,left_on=['orderno'],right_on=['orno'],how="left")#,left_index=False, right_index=False,validate=None,indicator=True)
#
LN_Sales=pd.merge(LN_Sales,tzzsls320600[['company','orderno','salesrepcode']],left_on=['company','orderno'],right_on=['company','orderno'],how="left")#,left_index=False, right_index=False,validate=None,indicator=True)

# #print(LN_Sales[LN_Sales['salesrepcode_y']=='NA']) #not working
# #print(LN_Sales[LN_Sales['salesrepcode_y']==np.NaN]) #not working
LN_Sales['salesrepcode'].fillna('NA1', inplace=True)

LN_Sales_Temp1=pd.merge(LN_Sales[LN_Sales['salesrepcode']=='NA1'],ttdsls400[['company','orderno','salesrepcode']],left_on=['company','orderno'],right_on=['company','orderno'],how="left")#,left_index=False, right_index=False,validate=None,indicator=True)
#LN_Sales_Temp1.replace(to_replace=LN_Sales_Temp1[LN_Sales_Temp1['salesrepcode_x']=='NA'][['salesrepcode_x']],value=LN_Sales_Temp1[LN_Sales_Temp1['salesrepcode_y']],inplace=True) #ValueError: cannot index with vector containing NA / NaN values
LN_Sales.drop(LN_Sales[LN_Sales['salesrepcode']=='NA1'].index,axis=0,inplace=True) #Condition based row deletion
LN_Sales_Temp1.drop('salesrepcode_x',axis=1,inplace=True)
LN_Sales_Temp1.rename(columns={'salesrepcode_y':'salesrepcode'},inplace=True)
LN_Sales_Temp1.to_csv("LN_Sales_Temp1.csv")

# LN_Sales.drop(LN_Sales[LN_Sales['salesrepcode_y']=='NA'].index,axis=0,inplace=True) #Condition based row deletion
Temp1=pd.DataFrame.append(LN_Sales,LN_Sales_Temp1,ignore_index=True)
LN_Sales=Temp1

# LN_Sales_Temp1.to_csv("LN_Sales_Temp1.csv")



for count1 in Company:
    print("Fetcing data for :tzzsls885" + str(count1))
    Query = "select distinct " + str(count1) + '''as company,t$lorn as orderno,t$h$crep as salesrepcode
    from erpnln.tzzsls885''' + str(count1)
    # +" where cast(t$odat as date) < '26/Jan/2020' " \
    # +" and  "+str(count1)+" =401"
    a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
tzzsls885=a
a=pd.DataFrame() #Empty dataframe
#print(tzzsls885)

LN_Sales=pd.merge(LN_Sales,tzzsls885[['company','orderno','salesrepcode']],left_on=['company','orderno'],right_on=['company','orderno'],how="left")#,left_index=False, right_index=False,validate=None,indicator=True)
LN_Sales['salesrepcode_y'].fillna('NA2', inplace=True)
#LN_Sales.replace(to_replace= ['salesrepcode_x'],value='Hello',inplace=True) #not working when columns are used for values section  #LN_Sales[['salesrepcode_y']]
LN_Sales['salesrepcode_x']=LN_Sales[LN_Sales['salesrepcode_y']!='NA2']['salesrepcode_y'] #Simple replace ha ha
LN_Sales.drop('salesrepcode_y',axis=1,inplace=True)
LN_Sales.rename(columns={'salesrepcode_x':'salesrepcode'},inplace=True)
#LN_Sales.to_csv("LN_Salesaftersalesrepcode.csv")

Company2=[400,600]
for count1 in Company2:
    print("Fetcing data for :TTCCOM001" + str(count1))
    Query = "select distinct " + str(count1) + ''' as company,t$emno as emno,t$nama as salesrep
    from erpnln.TTCCOM001''' + str(count1)
    # +" where cast(t$odat as date) < '26/Jan/2020' " \
    # +" and  "+str(count1)+" =401"
    a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
TTCCOM001=a
a=pd.DataFrame() #Empty dataframe
#print(TTCCOM001)

LN_Sales=pd.merge(LN_Sales,TTCCOM001[['emno','salesrep']],left_on='salesrepcode',right_on='emno',how='left')
LN_Sales.drop('emno',axis=1,inplace=True)

print("SalesRep Merge Completed")
#LN_Sales.to_csv("LN_Salesaftersalesrep.csv")


#LOB Updation

LN_Sales=pd.merge(LN_Sales,ttdsls400[['company','orderno','lobcode']],left_on=['company','orderno'],right_on=['company','orderno'],how='left')

Query="select distinct 400 as Company,T$CBRN as lobcode,T$DSCA as lineofbusiness from erpnln.ttcmcs031400"
a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
ttcmcs031400=a
a=pd.DataFrame() #Empty dataframe

LN_Sales=pd.merge(LN_Sales,ttcmcs031400,left_on=['lobcode'],right_on=['lobcode'],how='left')
LN_Sales.drop('company_y',axis=1,inplace=True)
LN_Sales.rename(columns={'company_x':'company'},inplace=True)
LN_Sales.to_csv("LN_SalesafterLOB.csv")

#Segment Updation
#print(tzzsls320600)
LN_Sales=pd.merge(LN_Sales,tzzsls320600[['company','orderno','segment','subdivision','buyback']],left_on=['company','orderno'],right_on=['company','orderno'],how='left')
LN_Sales['subdivision'].fillna('NA1', inplace=True)
#LN_Sales=LN_Sales.replace("","",regex=True) not working
#LN_Sales.replace(to_replace ='[|]', value='NA2',inplace=True) #not Working
#LN_Sales[LN_Sales['subdivision'].str.len()==1][['subdivision']]='NA2' #not Working
#LN_Sales[LN_Sales['subdivision']==' '][['subdivision']]='NA2' #not Working
#LN_Sales=re.sub('|','',LN_Sales['lineofbusiness'])
#print(LN_Sales.lineofbusiness)



print("Pattern replacement started")

#Method 1:
LN_Sales['lineofbusiness']=LN_Sales['lineofbusiness'].replace("[|]","",regex=True)

#Method 2:
#LN_Sales['lineofbusiness'].replace("[|]","",regex=True,inplace=True)

#Method 3: To be corrected
# a=LN_Sales['lineofbusiness']
# print(a)
# b=re.compile("[|]")
# a=b.sub("",str(a))
# print(a)
# print(type(a))
# cnt=0
#pattern1=re.compile("[|]")
# for i in a:
#     a1=pd.concat(a[cnt],axis=0)
#     cnt+=1
#
# print(type(a1))
# a1.to_csv('a1.csv')


print("Pattern replacement completed")

#Invoice date Updation

for count1 in Company:
    print("Fetcing data for :TCISLI305" + str(count1))
    Query = "select distinct " + str(count1) + ''' as company,t$tran as trantype,t$idoc as invoice,t$idat as invoice_date
    from erpnln.TCISLI305''' + str(count1)
    # +" where cast(t$odat as date) < '26/Jan/2020' " \
    # +" and  "+str(count1)+" =401"
    a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
TCISLI305=a
a=pd.DataFrame() #Empty dataframe



#Note: Convert the Invoice date to Date Format
LN_Sales=pd.merge(LN_Sales,TCISLI305[['company','trantype','invoice','invoice_date']],\
                        left_on=['company','trantype','invoice'],right_on=['company','trantype','invoice'],how='left')

print(type(TCISLI305.company[1])) #why it is not showing the datatype
print(type(TCISLI305.company[0])) #why it is not showing the datatype
#print(TCISLI305[(TCISLI305['company']==400)])
#print(TCISLI305[(TCISLI305['company']==400)& (TCISLI305['trantype']=='142')&(TCISLI305['invoice']==17000015)][['company','trantype','invoice','invoice_date']])
#print(LN_Sales_Temp1[(LN_Sales_Temp1['company']==400)& (LN_Sales_Temp1['trantype']=='142')&(LN_Sales_Temp1['invoice']==17000015)][['company','trantype','invoice','invoice_date']])

#China Sales------------------------------------------------------------------------------------------------------------


#End: China Sales-------------------------------------------------------------------------------------------------------

#TaxCode Updation --Already updated in the first merge statement

#DPST updation for Australia and Indonesia------------------------------------------------------------------------------

Query="select distinct 551 as company, t$ctyp as ctyp, t$item as item, t$dsca as dsca from erpnln.TTCIBD001551"
a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
TTCIBD001551=a
a=pd.DataFrame() #Empty dataframe
TTCIBD001551['item'] = TTCIBD001551['item'].str.strip()
TTCIBD001551['dsca'] = TTCIBD001551['dsca'].str.strip()
print(TTCIBD001551)


Producttype_Aust_Master=pd.read_excel("C:\\Users\\vasanthk\\PycharmProjects\\Project1\\MasterData\\Producttype_Aust_Master.xlsx","Sheet1")
#print(type(Producttype_Aust_Master.dpst[0]))
Producttype_Aust_Master["dpst"]=Producttype_Aust_Master["dpst"].astype(str) #working : Datattype conversion of a column in dataframe
#print(type(Producttype_Aust_Master.dpst[0]))
#print(Producttype_Aust_Master)

Producttype_Aust_Master=pd.merge(TTCIBD001551[['company','item','ctyp']],Producttype_Aust_Master, on='ctyp',how='inner')
print(Producttype_Aust_Master)


LN_Sales_Temp1=pd.merge(LN_Sales[(LN_Sales['invoice_date']>='2017-04-01')& (LN_Sales['company']==551)],Producttype_Aust_Master,left_on=['company','item'],right_on=['company','item'],how='left')
LN_Sales.drop(LN_Sales[(LN_Sales['invoice_date']>='2017-04-01')& (LN_Sales['company']==551)].index,axis=0,inplace=True) #Condition based row deletion
LN_Sales_Temp1.drop('dpst_x',axis=1,inplace=True)
LN_Sales_Temp1.rename(columns={'dpst_y':'dpst'},inplace=True)
LN_Sales_Temp1.to_csv("LN_Sales_Temp1.csv")
Temp1=pd.DataFrame.append(LN_Sales,LN_Sales_Temp1,ignore_index=True)
LN_Sales=Temp1



Query="select distinct 552 as company, t$ctyp as ctyp, t$item as item, t$dsca as dsca from erpnln.TTCIBD001552"
a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
TTCIBD001552=a
a=pd.DataFrame() #Empty dataframe
TTCIBD001552['item'] = TTCIBD001551['item'].str.strip()
TTCIBD001552['dsca'] = TTCIBD001551['dsca'].str.strip()
#print(TTCIBD001552)


Producttype_Indo_Master=pd.read_excel("C:\\Users\\vasanthk\\PycharmProjects\\Project1\\MasterData\\Producttype_Indo_Master.xlsx","Sheet1")
#print(type(Producttype_Aust_Master.dpst[0]))
Producttype_Indo_Master["dpst"]=Producttype_Indo_Master["dpst"].astype(str) #working : Datattype conversion of a column in dataframe
#print(type(Producttype_Aust_Master.dpst[0]))
#print(Producttype_Aust_Master)

Producttype_Indo_Master=pd.merge(TTCIBD001552[['company','item','ctyp']],Producttype_Indo_Master, on='ctyp',how='inner')
print(Producttype_Indo_Master)


LN_Sales_Temp1=pd.merge(LN_Sales[(LN_Sales['invoice_date']>='2017-04-01')& (LN_Sales['company']==552)],Producttype_Indo_Master,left_on=['company','item'],right_on=['company','item'],how='left')
LN_Sales.drop(LN_Sales[(LN_Sales['invoice_date']>='2017-04-01')& (LN_Sales['company']==552)].index,axis=0,inplace=True) #Condition based row deletion
LN_Sales_Temp1.drop('dpst_x',axis=1,inplace=True)
LN_Sales_Temp1.rename(columns={'dpst_y':'dpst'},inplace=True)
LN_Sales_Temp1.drop('ctyp_x',axis=1,inplace=True)
LN_Sales_Temp1.rename(columns={'ctyp_y':'ctyp'},inplace=True)

LN_Sales_Temp1.to_csv("LN_Sales_Temp1.csv")
Temp1=pd.DataFrame.append(LN_Sales,LN_Sales_Temp1,ignore_index=True)
LN_Sales=Temp1

#LN_Sales_Temp1=LN_Sales[LN_Sales['invoice_date']>='2017-04-01']
print(LN_Sales_Temp1)
LN_Sales_Temp1.to_csv('LN_Sales_Temp1.csv')


#End: DPST updation for Australia and Indonesia-------------------------------------------------------------------------

#check the line 131-135 and ensure there is no duplication during appending : ensured on 5-2-2020

#vw_Business_Partner----------------------------------------------------------------------------------------------------

Query='''select  a.t$bpid as custcode,a.t$nama as custname1,b.t$creg as CustAreaCode,c.t$cfcg as FinCustGrp,
        trim(d.t$nama) || \' \' || trim(d.t$namb) || \' \' || trim(d.t$namc) || \' \' || trim(d.t$BLDG) || \' \' || 
        trim(d.t$BLFL) || \' \' || trim(d.t$BLUN) as CustAddress,
        c.t$ccur as Currency  
        from erpnln.TTCCOM100400 a
        left outer join erpnln.TTCCOM110400 b
        on a.t$bpid=b.t$ofbp
        left outer join (select distinct t$itbp,t$cfcg,t$ccur from erpnln.TTCCOM112400)  c
        on a.t$bpid=c.t$itbp
        left outer join erpnln.TTCCOM130400 d
        on a.t$cadr=d.t$cadr
        '''

a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
Business_Partner=a
a=pd.DataFrame() #Empty dataframe
#TTCCOM100400['item'] = TTCIBD001551['item'].str.strip()
#TTCCOM100400['dsca'] = TTCIBD001551['dsca'].str.strip()
Business_Partner["custareacode"]=Business_Partner["custareacode"].astype(str)
print(Business_Partner)
Business_Partner.to_csv('Business_Partner.csv')



Company_Master=pd.read_excel("C:\\Users\\vasanthk\\PycharmProjects\\Project1\\MasterData\\CompanyMaster.xlsx","Sheet1")
#print(Company_Master)


#(LN_Sales[['company']] in [551,552,951])

#ix=[i for i in df.index if i not in blacklist]
# ix=[i for i in Company if i not in [551,552,951,600]]
# print(ix)
# print(LN_Sales.columns.values)

#LN_Sales[(LN_Sales.columns.values[LN_Sales['company'].isin([551,552,951]))]
#LN_Sales_Temp1=pd.merge(LN_Sales[(LN_Sales[['company']] != [551,552,951])],Business_Partner[['custcode','custname1','fincustgrp']],on ='custcode',how='left') #ValueError: Unable to coerce to Series, length must be 1: given 3
# LN_Sales_Temp1=pd.merge(LN_Sales[['company','custcode','deladdress','deliveryqty','ed_amount','foreign_currency_amount',
#                                   'invoice','invoice_date','item','lineofbusiness','lobcode','orderdate','orderno','positionno']][(LN_Sales[['company']].isin([551,552,951]))],Business_Partner[['custcode','custname1','fincustgrp']],on ='custcode',how='left') #ValueError: Unable to coerce to Series, length must be 1: given 3

# LN_Sales_Temp1=pd.merge(LN_Sales[(LN_Sales[['company','custcode','deladdress','deliveryqty','ed_amount','foreign_currency_amount',
#'invoice','invoice_date','item','lineofbusiness','lobcode','orderdate','orderno','positionno']]['company'].isin([551,552,951]))],
#Business_Partner[['custcode','custname1','fincustgrp']],on ='custcode',how='left') #Fetching only specified columns of Ln_Sales Note:For condition column only single square bracket

# select  company from ELGI_Companies_Master where Company not in (551,552,951) and CompanyGroup in ('ELGi','ATS'))

#print(Company_Master)
companylist=Company_Master[(Company_Master['companygroup'].isin(['ELGI','ATS'])) & (~Company_Master['company'].isin([551,552,951]))]#[['company']]
#company_temp=Company_Master[(Company_Master['company'].isin(['551','552','951'])) & (Company_Master['companygroup'].isin(['ELGi','ATS']))]
#companylist=list([companylist])
print(companylist)
#print(type(companylist))



LN_Sales_Temp1=pd.merge(LN_Sales[LN_Sales['company'].isin(companylist['company'])],Business_Partner[['custcode','custname1','fincustgrp']],on ='custcode',how='left') #Fetching all columns of Ln_Sales
#print(LN_Sales_Temp1)
LN_Sales_Temp1.to_csv('LN_Sales_Temp1.csv')

print(LN_Sales[LN_Sales['company'].isin(companylist['company'])])

#End : vw_Business_Partner----------------------------------------------------------------------------------------------------


# update LN_Sales_Details_ver2 set custname=a.custname1,FinCustGrp=a.FinCustGrp
# from vw_Business_Partner a
# where LN_Sales_Details_ver2.custcode=a.custcode
# and LN_Sales_Details_ver2.company in (select  company from ELGI_Companies_Master
# where Company not in (551,552,951) and CompanyGroup in ('ELGi','ATS'))

LN_Sales.to_csv("LN_SalesafterSegment.csv")

