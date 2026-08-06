import numpy as np
a=np.array([1,2,3,4,5])
print(a)

a=np.arange(10)
print(a)

b=a.reshape(2,5)
print(b)
print(b.shape)        #Specifies no of rows and columns
print(b.dtype.name)   #Datatype of the array
print(b.ndim)        #No of dimensions of the array

#Convert List into Numpy Array
list1=[1,2,3,'a','Hai','Python','2019-12-09']
nparr1=np.array(list1)
print(nparr1)
print(type(nparr1))

#Convert Nested List into Numpy Array
list1=[1,2,3,'a','Hai','Python','2019-12-09',[100,200,300]]
nparr1=np.array(list1)
print(nparr1)
print(type(nparr1))

#Creating Zero Array and Unit Array
nparr1=np.zeros(100)
nparr1=nparr1.reshape(10,10)
print(nparr1)

nparr1=np.ones(100)
nparr1=nparr1.reshape(4,25)
print(nparr1)

#Identity Array
nparr1=np.eye(6)  #6 elements in rows and columns
print(nparr1)
nparr1=nparr1.reshape(6,3,2) # 6 elements in 3 rows and 2 columns
print(nparr1)


#empty and Full Array
#nparr1=np.empty(3,2) # returns error as dimensions to be mentioned as a tuple
nparr1=np.empty((3,2))
print(nparr1)

nparr1=np.full((3,2),5)
print(nparr1)


#---------------------------------------------------------------------------
#Numpy Array Operations and Indexing
a=np.random.random((2,3))
b=np.random.random((2,3))
print(a)
print(b)
c=a+b
print(c)
d=a-b
print(d)
e=a*b
print(e)
f=a/b
print(f)

a=np.arange(5)
print(a)
b=a**2
print(b)


#Array Indexing
a=np.arange(20)
print(a)
print(a[19])
#print(a[20]) #Error:Out of range
print(a[10:])
print(a[-1])

a[1]=100 # assignment
print(a)

a[15:]=7
print(a)

#Copy Function
b=a.copy()
print(b)

#-----------------------------------------------------------------------------------------
#Numpy Multi Dimensional Arrays
a=np.arange(100)
a=a.reshape(5,20)
print(a)
print(a[0,0])
print(a[1,3])  #row and column index starts from 0 to n-1
print(a[1][3])
# reshape to 3 dimensional array

b=a.reshape(10,2,5)   #10 rows each containing a matrix of 2 rows and 5 columns
print(b)
print(b[0])     #indexing outer row
print(b[0][1])  #indexing outer and inner row
print(b[0,1,1]) #indexing the element

a=np.arange(12)
a=a.reshape(2,3,2)
b=np.arange(12)
b=b.reshape(2,3,2)
c=np.add(a,b)
print(a)
print(b)
print(c)


a=[[[1,5],[42,23],[77,6],[109,67],[23,89]],[[10,20],[45,89],[6,34],[30,55],[0,1]]]
a1=[[[11,5],[4,23],[7,6],[19,600],[203,8]],[[1,20],[4,89],[16,34],[3,55],[100,1]]]
b=np.array(a) #converting list into array
#print(a.shape) #error as shape method will not work for list
print(b.shape)
print(b.ndim)
c=np.minimum(a,a1)
print(c)
d=np.maximum(a,a1)
print(d)


#Transpose of an array
a=np.arange(10).reshape(2,5)  #two methods in a single line
print(a)
a=a.transpose()
print(a)

#Statistic Operations
print(a.sum())
print(a.mean())
print(a.std())
print(a.var())

#Where Condition in array
a=np.arange(10).reshape(2,5)
print(a)
b=np.where(a<3,0,a)
print(b)