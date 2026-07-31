a=[1,3,7,9]
print(a)

#S1.licing Method
print (a[1:])
print (a[-1])
print (a[:2])

#2.Insert Method
b=[0,2,4,6,8]
a.insert(0,b[0])  #Two arguments index and value are mandatory while inserting into the list
print(a)
a.insert(0,b[1:])
print(a)
a.insert(0,b)
print(a)


#3.extend Method
a=[0,1,2,3]
b=[4,5,6,7]
a.extend(b)
print(a)

#4.remove method
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
b=[4,5,6,7]
a.remove(1) #Since 1 is within Quotes , it is considered as String and as a different element
print(a)
#a.remove(a[:3]) # Not supporting
#a.remove(a[3:]) # Not supporting
print(a)

#5.pop Method -->Removes last value available in the list
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
b=[4,5,6,7]
removedValue=a.pop() #Since 1 is within Quotes , it is considered as String and as a different element
print(a)
print(removedValue)

#6.Reverse Method -->reverses the order of the elements
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
b=[4,5,6,7]
a.reverse()
print(a)

#7.Sort Method
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
b=[4,15,6,7,3,23,1,5,100,66]
b.sort()
print(b)
b.sort(reverse=True)
print(b)

#Sort without affecting the Original List and save it in another variable
a=[4,15,6,7,3,23,1,5,100,66]
b=sorted(a)
print(a)
print(b)

#8. Min, Max,Sum Methods
a=[4,15,6,7,3,23,1,5,100,66]
print(min(a))
print(max(a))
print(sum(a))

#9.Finding Index and checking existence
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
print(a.index("Monday"))
print("Hai" in a)
print("Hello" in a)


#10.Looping in Lists
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
for variable1 in a:
    print(variable1)

a=[20,11,32,53,'Jan',"Monday","Hai",3+4j]
for index,variable1 in enumerate(a):  #Enumerate function here works as a counter starting from 0,1,...
    print(index, variable1)

#starting from a particular index
a=[20,11,32,53,'Jan',"Monday","Hai",3+4j]
for index,variable1 in enumerate(a, start=300):  #Enumerate function here works as a counter starting from 300,301,...but all elements are printed as before
    print(index, variable1)

#11. join Method -->Converts the list items into a single string
a=[20,11,32,53,'Jan',"Monday","Hai",3+4j]
# str1='|'.join(a)  #Error Coccurs as Int elements cannot be converted into String
# print(str1)
b=a[4:7]
str1='|'.join(b)
print(str1)

#12. split Method -->Converts String(with a seperator) into List items
list1=str1.split("|")
print(list1)

#------------------------------------------------------------------------------
#Tuples Every method associated with the list will work for tuples
#Only differnece is an assignment or modification on the elements cannot be done here.

a=(20,11,32,53,'Jan',"Monday","Hai",3+4j)
#a[1]='Hello' # Assignment cannot be done on Tuples
print(a[1])

#-------------------------------------------------------------------------------
#Sets -->Indexing cannot be used as ordering is not maintained

a={20,11,32,53,'Jan',"Monday","Hai",3+4j}
print(a)

#Removes the duplicates automatically
a={1,1,1,2,2,3,4,5,5}
print(a)

# Check the existence of the element in a Set
print(3 in a)
print(30 in a)
print('3' in a)


# Set Operations
a={1,2,'3','Hai','Good',2+3j,'2019-12-05',5,4}
b={1,2,'3','Hello',500,44}
print(a.intersection(b))
print(a.union(b))
print(a.difference(b))
print(b.difference(a))

#Defining empty set list and tuple
a=()  # Empty Tuple can be created but values cannot be assigned to it later.
b={}
print(a,b)
c=[]
d=list()
print(c,d)
e=()
f=tuple()
print(e,f)

#Dictionary
a={'Name':['Venkat','Selva'],'Team':{'BI','LN'},'Designation':('BI Developer','ERP Developer'),'Company':'ELGi'}  #It accepts values in terms of lists, set ,tuples besides individual values
print(a)
print(a['Name'])
print(a.get('Name'))
print(a.get('Designation'))
print(a.get('Names'))  #Print Using get function
print(a.get('Names','Key is invalid'))

#Add,edit and delete values from Dictionary
#Add a New Key
a['Experience']=[5,10]
print(a)

#edit
a['Name']='Vasanth' # if we add a new value to the existing key it gets overwritten the old values of the key
print(a)

#delete
del a['Team'] # once deleted value is not retrievable
b=a.pop('Designation')  #poping out and storing in a variable inorder to retrieve the values later
print(a)
print(b)

#Methods in Dictionary
print(a)
print(len(a))
print(a.keys())
print(a.values())
print(a.items())

#Loop through Dictionary
for key in a:
    print(key)

# for key,value in a:
#     print(key,value) #It reurns Error: too many values to unpack

for key,value in a.items():
     print(key,value) #It reurns expected result
