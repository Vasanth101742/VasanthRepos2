

print('Arithmatic Operators')

#Floor Division
print(-11//3)
print(11//3)

#IF Condition
var = 100
if ( var == 100 ) :
    print("Value of expression is 100")

print("Good bye!")

#IF Else Condition
var1 = 100
if var1:
   print("1 - Got a true expression value")
   print(var1)
else:
   print("1 - Got a false expression value")
   print(var1)

var2 = 0
if var2:
   print("2 - Got a true expression value")
   print(var2)
else:
   print( "2 - Got a false expression value")
   print(var2)

print("Good bye!")


# Nested IF

var = 500
if var < 200:
   print( "Expression value is less than 200")
   if var == 150:
      print ("Which is 150")
   elif var == 100:
      print ("Which is 100")
   elif var == 50:
      print ("Which is 50")
   elif var < 50:
      print ("Expression value is less than 50")
else:
   print ("Could not find true expression")

print ("Good bye!")



#Looping Statements

#While Loop
count = 0
while (count <= 10):
   print('The count is:', count)
   count = count + 1

print ("Good bye!")

#infinite Loop
#var = 1
#while var == 1 :  # This constructs an infinite loop
# num = input("Enter a number  :")
# print ("You entered: ", num)
# print ("Enter Ctrl +F2 to exit from this program")

print ("Good bye!")


count = 0
while count < 5:
   print(count, " is  less than 5")
   count = count + 1
else:
   print (count, " is not less than 5")



# Nested Loops

i = 2
while(i < 100):
   j = 2
   while(j <= (i/j)):
      if not(i%j): break
      j = j + 1
   if (j > i/j) : print (i, " is prime")
   i = i + 1

print ("Good bye!")

#For Loop
for letter in 'Python':     # First Example
   print ('Current Letter :', letter)

fruits = ['banana', 'apple',  'mango']
for fruit in fruits:        # Second Example
   print ('Current fruit :', fruit)

#For Loop by index
fruits = ['banana', 'apple',  'mango']
for index in range(len(fruits)):
   print ('Current fruit :', fruits[index])


#Using else Statement with Loops
for num in range(10,20):     #to iterate between 10 to 20
   for i in range(2,num):    #to iterate on the factors of the number
      if num%i == 0:         #to determine the first factor
         j=num/i             #to calculate the second factor
         print ('%d equals %d * %d' % (num,i,j))
         break #to move to the next number, the #first FOR
   else:                  # else part of the loop
      print (num, 'is a prime number')

#Break Statement
for letter in 'Python':  # First Example
    if letter == 'h':
        break
    print('Current Letter :', letter)

var = 10  # Second Example
while var > 0:
    print ('Current variable value :', var)
    var = var - 1
    if var == 5:
        break

print ("Good bye!")


#Continue Statement
for letter in 'Python':     # First Example
   if letter == 'h':
      continue
   print ('Current Letter :', letter)

var = 10                    # Second Example
while var > 0:
   var = var -1
   if var == 5:
      continue
   print ('Current variable value :', var)


#Pass Statement

for letter in 'Python':
   if letter == 'h':
      pass
      print ('This is pass block')
      print ('This is also pass block')
   print ('Current Letter :', letter)

print ("Good bye!")

