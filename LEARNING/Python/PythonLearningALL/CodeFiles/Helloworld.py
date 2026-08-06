import  pandas as pd





# Declare a variable and initialize it
f = 101
f='hai'
print(f)
# Global vs. local variables in functions
def someFunction():
# global f
    f = 'I am learning Python'
    print(f)

someFunction()
print(f)

df1=pd.\
    read_csv('C:\\Users\\vasanthk\\Desktop\\PythonLearning\\Book1.csv')
#print(df1)
print(type(df1))