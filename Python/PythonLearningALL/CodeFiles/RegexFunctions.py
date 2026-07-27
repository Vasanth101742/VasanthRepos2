import re

#Source: https://www.youtube.com/watch?v=zN8rwVXwRUE


#1. Finding the pattern and convert to Dictionary

Nameage='''
Venkat is 30 and Prem is 70 and
Selva is 35 and Hari is 31
'''
ages=re.findall(r'\d{1,3}',Nameage)
names=re.findall(r'[A-Z][a-z]*',Nameage)

print(ages)
print(names)

agedict={}
x=0

for eachname in names:
    agedict[eachname]=ages[x]
    x+=1
    #print(agedict)

print(agedict)

#-----------------------------------------------------------------------------------------------------------------------
# 2. search for the pattern

if re.search("inform","we need to inform him this information is useful"):
    print("the string contains inform")

#to get all the occurances

a=re.findall("inform","we need to inform him this information is useful")

for i in a:
    print(i)

#to ge the start and end index of a search string

a="we need to inform him this information is useful"

for i in re.finditer("inform",a):
    b=i.span()
    print(b)

#match words with a particular pattern

a="sat,hat,mat,pat"
b=re.findall("[smhp]at",a)

for i in b:
    print(i)

c=re.findall("[h-m]at",a)
for i in c:
    print(i)

d=re.findall("[^h-m]at",a)
for i in d:
    print(i)

#-----------------------------------------------------------------------------------------------------------------------
#replace method

a="hat rat mat pat"
b=re.compile("[r]at")  #a pattern is created from the string
a=b.sub("food",a)
print(a)