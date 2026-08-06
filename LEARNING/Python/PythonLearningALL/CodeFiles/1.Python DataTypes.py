a=[1,3,7,9]
print("a :",a)

#Slicing Method
print("\nSlicing Method")
print ("a[1:] :",a[1:])
print ("a[-1] :",a[-1])
print ("a[:-1] :",a[:-1])
print ("a[-2] :",a[-2])
#print (a[-5]) # IndexError: list index out of range
print ("a[:2] :",a[:2])

#Insert Method
print("\nInsert Method")
b=[0,2,4,6,8]
a.insert(0,b[0])
print(a)
a.insert(0,b[1:])
print(a)
a.insert(0,b)
print(a)  #Output of final list is not in expected format

#extend Method
print("\nextend Method")
a=[0,1,2,3]
b=[4,5,6,7]
a.extend(b)
print(a) #Output of final list is in expected format

#remove method
print("\nRemove Method")
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
print("a : ",a)
a.remove(1) 
print("a.remove(1) : ",a)
a=[[0,1,2,3],'Jan',"Monday","Hai",3+4j]
print("a : ",a)
a.remove(a[1]) #Since 1 is within Quotes , it is considered as String and as a different element
print("a.remove(a[1]) : ",a) 
#a.remove(a[:3]) # ValueError: list.remove(x): x not in list
#print("a.remove(a[:3]) : ",a)
print("a : ",a)
a.pop()
print("a.pop() : ",a)
a=a[:-1]
print("a=a[:-1] : ",a)



#pop Method -->Removes last value available in the list
print("\npop Method")
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
b=[4,5,6,7]
removedValue=a.pop() #Since 1 is within Quotes , it is considered as String and as a different element
print(a)
print(removedValue)

#Reverse Method -->reverses the order of the elements
print("\nReverse Method")
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
b=[4,5,6,7]
a.reverse()
print(a)

#Sort Method
print("\nsort Method")
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
b=[4,15,6,7,3,23,1,5,100,66]
b.sort()
print(b)
b.sort(reverse=True)
print(b)

#Sort without affecting the Original List and save it in another variable
print("\nsorted Method")
a=[4,15,6,7,3,23,1,5,100,66]
b=sorted(a)
print(a)
print(b)

# Min, Max,Sum Methods
print("\nAggregate Method")
a=[4,15,6,7,3,23,1,5,100,66]
print(min(a))
print(max(a))
print(sum(a))

#Finding Index and checking existence
print("\nFinding Index and checking existence")
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
print(a.index("Monday"))
print("Hai" in a)
print("Hello" in a)


# #Looping in Lists
print("\nLooping in Lists")
a=[0,1,2,3,'Jan',"Monday","Hai",3+4j]
for variable1 in a:
    print(variable1)

print("\nLooping with Enumerate Function")
a=[20,11,32,53,'Jan',"Monday","Hai",3+4j]
for index,variable1 in enumerate(a):  #Enumerate function here works as a counter starting from 0,1,...
    print(index, variable1)

#starting from a particular index
print("\nLooping with Enumerate Function using start parameter")
a=[20,11,32,53,'Jan',"Monday","Hai",3+4j]
for index,variable1 in enumerate(a, start=300):  #Enumerate function here works as a counter starting from 300,301,...but all elements are printed as before
    print(index, variable1)

#join Method -->Converts list into string
print("\njoin Method")
a=[20,11,32,53,'Jan',"Monday","Hai",3+4j]
# str1='|'.join(a)  #Error Coccurs as Int elements cannot be converted into String
# print(str1)
b=a[4:7]
str1='|'.join(b)
print(str1)

#split Method -->Converts String into List
print("\nsplit Method")
list1=str1.split("|")
print(list1)

#------------------------------------------------------------------------------
#Tuples Every method associated with the list will work for tuples
#Only differnece is an assignment or modification on the elements cannot be done here.
print("\nTuples")
a=(20,11,32,53,'Jan',"Monday","Hai",3+4j)
#a[1]='Hello' # Assignment cannot be done on Tuples
print(a[1])

#-------------------------------------------------------------------------------
#Sets -->Indexing cannot be used as ordering is not maintained
print("\nSets")
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
print("\nSet Operations")
a={1,2,'3','Hai','Good',2+3j,'2019-12-05',5,4}
b={1,2,'3','Hello',500,44}
print("a :",a)
print("b :",b)
print("a.intersection(b)",a.intersection(b))
print("a.union(b)",a.union(b))
print("a.difference(b)",a.difference(b))
print("b.difference(a)",b.difference(a))

#Defining empty set, list and tuple
print("\nDefining empty set, list and tuple")
a=set()  #This assignment is not working properly also no error is thrown
b={}
print("a,b : ",a,b)
c=[]
d=list()
print("c,d : ",c,d)
e=()
f=tuple()
print("e,f : ",e,f)

#Dictionary
print("\nDictionary")
a={'Name':['Venkat','Selva'],'Team':{'BI','LN'},'Designation':('BI Developer','ERP Developer'), \
   'Company':'ELGi'}  #It accepts values in terms of lists, set ,tuples besides individual values
print("a :",a)
print("a['Name'] : ",a['Name'])
print("a.get('Name') : ",a.get('Name'))
print("a.get('Designation') : ",a.get('Designation'))
print("a.get('Names') : ",a.get('Names'))  #Print Using get function
print("a.get('Names','Key is invalid')",a.get('Names','Key invalid'))

#Add,edit and delete values from Dictionary
print("\nAdd,edit and delete values from Dictionary")
a['Experience']=[5,10]
print(a)
#edit
a['Name']='Vasanth' # if we add a new value to the existing key it gets overwritten 
                    # the old values of the key
a['Name']=['Vasanth']
print(a)
#delete
del a['Team'] # once deleted value is not retrievable
b=a.pop('Designation')  #poping out and storing in a variable inorder to retrieve the values later
                        # pop() removes the key and returns its value.
print(a)
print(b)
b=["Senior " + b[0] , " Senior " + b[1]]
print(b)
a['Designation']=b
print(a)


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
