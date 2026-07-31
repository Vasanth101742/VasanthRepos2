
# 1. Use in Intrepreter
# 5 + 4
# _  + 1 # prints the value as 10 in the Intrepreter. it wont work in the .py file

#2. Ignoring Values

#2.1 Ignoring Single Value
(a,_,b)=[1,2,3]
print("a =",a,"b =",b, end=' ') # here end implies blank space. by default end will be \n in python
print("a =",a,"b =",b)          #See where this line is printing and observe a new line after printing this.

#2.1 Ignoring Multiple Values (called as Extended Unpacking)
(a, *_, b) = (7, 6, 5, 4, 3, 2, 1)
print(a,b)
print(*_)


#3.1 Use in Looping
for _ in range(5):
    print(_)

#3.2 iterating over a list using _
## you can use _ same as a variable
languages = ["Python", "JS", "PHP", "Java"]
for _ in languages:
    print(_, end="\t")

#3.3 Acting as a variable
_=5
while _<=10:
    print(_,end=' ')
    _+=1

#4 Seperating Digits of Numbers

million = 1_000_000
binary = 0b_0010
octa = 0o_64
hexa = 0x_23_ab

print("\n",million)
print(binary)
print(octa)
print(hexa)

#5 Naming Using Underscore


