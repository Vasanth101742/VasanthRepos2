var1 = 'Guru99!'
var2 = "Software Testing"
print ("var1[0]:",var1[0])
print ("var2[1:5]:",var2[1:5])

x = "Hello World!"
print(x[:3])
print(x[0:6] + "Guru99")

#String Replace
oldstring = 'I like Sweets'
newstring = oldstring.replace('like', 'love')
print(newstring)

#Upper and Lower Case Strings
string="python at guru99"
print(string.upper())

string="PYTHON AT GURU99"
print(string.lower())

#Join Function
print(":".join("Python"))

#Reversing String
string="12345"
print(''.join(reversed(string)))

#Split Strings
word="guru99 career guru99"
print(word.split(' '))

print(word.split('r'))

#Strings are Immutable
x = "Guru99"
x.replace("Guru99","Python")
print(x)

x = x.replace("Guru99","Python")
print(x)
