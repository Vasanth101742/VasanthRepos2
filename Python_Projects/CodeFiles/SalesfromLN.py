import pandas as pd
from sqlalchemy import create_engine
import LNConnection as LN
#-----------------------------------------------------------------------------------------------------------------------


engine = create_engine(LN.oracle_connection_string)
con=engine.connect()
#print(con)

# #Method1
# a=pd.read_sql("select t$sfcp,t$tran from erpnln.tcisli305400",engine)  #as set with 5 rows
# b=pd.read_sql("select t$sfcp,t$tran from erpnln.tcisli305401",engine)
# a=pd.DataFrame(a)
# b=pd.DataFrame(b)
# c=pd.concat([a,b])#,ignore_index=True,sort=False)
# print(c)

#-----------------------------------------------------------------------------------------------------------------------
#Method2
Company=[400]
a=pd.DataFrame() #Empty dataframe

# for count1 in Company:
#     #Query="select "+str(count1)+" as Company,t$sfcp,t$tran from erpnln.tcisli305"+str(count1)
#     #a = pd.read_sql(Query, engine)
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# tcisli305=a
# a=pd.DataFrame() #Empty dataframe
# print(tcisli305)


for count1 in Company:
    #Query="select "+str(count1)+" as Company,t$sfcp,t$tran from erpnln.tcisli310"+str(count1)
    Query = "select "+str(count1)+''' as Company, t$cofc as cofc, t$tran as tran, t$orno as orno, t$pono as pono, 
    t$idoc as idoc, t$ofbp as ofbp, t$item as item, t$rate$1 as rate1, t$rate$2 as rate2, t$txai as txai,
    sum(t$amth$1) as amth1, sum(t$txah$1) as txah1,
    sum(t$amti) as amti, sum(t$pric) as pric,
    sum(t$dqua) as dqua, sum(t$amth$1) as amth1,t$sotp as sotp
        from erpnln.tcisli310''' + str(count1) + \
        " group by t$cofc, t$tran, t$orno, t$pono, t$idoc, t$ofbp, t$item, t$rate$1, t$rate$2, t$txai,t$sotp"
    a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
tcisli310=a
a=pd.DataFrame() #Empty dataframe
print(tcisli310)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,t$sfcp,t$tran from erpnln.tcisli315"+str(count1)
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# tcisli315=a
# a=pd.DataFrame() #Empty dataframe
# print(tcisli315)

# for count1 in Company:
#     Query="select "+str(count1)+" as Company,t$ncmp,t$h$cofc from erpnln.tzzsls885"+str(count1)
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# tzzsls885=a
# a=pd.DataFrame() #Empty dataframe
# print(tzzsls885)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,t$ofbp,t$orno from erpnln.ttdsls400"+str(count1)
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# ttdsls400=a
# a=pd.DataFrame() #Empty dataframe
# print(ttdsls400)

#---------memory error occur for 401 company
# for count1 in Company:
#     #Query="select "+str(count1)+" as Company,erpnln.ttdsls401"+str(count1)+".* from erpnln.ttdsls401"+str(count1)
#     Query="select "+str(count1)+" as Company,t_ofbp,t_orno from erpnln.ttdsls401"+str(count1)
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# ttdsls401=a
# a=pd.DataFrame() #Empty dataframe
# print(ttdsls401)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.ttdsls406"+str(count1)+".* from erpnln.ttdsls406"+str(count1) #t$orno,t$pono
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# ttdsls406=a
# a=pd.DataFrame() #Empty dataframe
# print(ttdsls406)

# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.ttdsls094"+str(count1)+".* from erpnln.ttdsls094"+str(count1) #t$sotp,t$dsca
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# ttdsls094=a
# a=pd.DataFrame() #Empty dataframe
# print(ttdsls094)

# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.tcisli220"+str(count1)+".* from erpnln.tcisli220"+str(count1) #t$sfcp,t$msid
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# tcisli220=a
# a=pd.DataFrame() #Empty dataframe
# print(tcisli220)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.tcisli225"+str(count1)+".* from erpnln.tcisli225"+str(count1) #t$sfcp,t$msid
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# tcisli225=a
# a=pd.DataFrame() #Empty dataframe
# print(tcisli225)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.tcisli939"+str(count1)+".* from erpnln.tcisli939"+str(count1) #t$srcp,t$srtp
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# tcisli939=a
# a=pd.DataFrame() #Empty dataframe
# print(tcisli939)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.tzzsls326"+str(count1)+".* from erpnln.tzzsls326"+str(count1) #t$cbrn,t$dsca
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# tzzsls326=a
# a=pd.DataFrame() #Empty dataframe
# print(tzzsls326)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.twhinh430"+str(count1)+".* from erpnln.twhinh430"+str(count1)  #t$shpm,t$load
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# twhinh430=a
# a=pd.DataFrame() #Empty dataframe
# print(twhinh430)

# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.twhinh431"+str(count1)+".* from erpnln.twhinh431"+str(count1) #t$shpm,t$pono
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# twhinh431=a
# a=pd.DataFrame() #Empty dataframe
# print(twhinh431)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.tzzsls320"+str(count1)+".* from erpnln.tzzsls320"+str(count1) #t$orno,t$rem1
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# tzzsls320=a
# a=pd.DataFrame() #Empty dataframe
# print(tzzsls320)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.ttdsls100"+str(count1)+".* from erpnln.ttdsls100"+str(count1) #t$qono,t$ofbp
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# ttdsls100=a
# a=pd.DataFrame() #Empty dataframe
# print(ttdsls100)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.ttdsls101"+str(count1)+".* from erpnln.ttdsls101"+str(count1) #t$qono,t$ofbp
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# ttdsls101=a
# a=pd.DataFrame() #Empty dataframe
# print(ttdsls101)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.ttdsls402"+str(count1)+".* from erpnln.ttdsls402"+str(count1) #t$orno,t$pono
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# ttdsls402=a
# a=pd.DataFrame() #Empty dataframe
# print(ttdsls402)


# for count1 in Company:
#     Query="select "+str(count1)+" as Company,erpnln.twhinh480"+str(count1)+".* from erpnln.twhinh480"+str(count1) #t$orno,t$pono
#     a = pd.DataFrame.append(a, pd.read_sql(Query, engine))
# twhinh480=a
# a=pd.DataFrame() #Empty dataframe
# print(twhinh480)


con.close()




