var1 = 'Hello World!'
var2 = "Python Programming"

print ("var1[0]: ", var1[0])
print ("var1[-1]: ", var1[-1])
print ("var1[-2]: ", var1[-2])
print ("var2[1:5]: ", var2[17:100])  # no error will be shown when index is out of the range

#Update the Strings
var1 = 'Hello World!'
print ("Updated String :- ", var1[:6] + 'Python')

#Format Specifiers
print( "My name is %s and weight is %d kg!" % ('Zara', 21))

#Triple Quotes
para_str = """this is a long string that is made up of
several lines and non-printable characters such as
TAB ( \t ) and they will show up that way when displayed.
NEWLINEs within the string, whether explicitly given like
this within the brackets [ \n ], or just a NEWLINE within
the variable assignment will also show up.
"""
print (para_str)

print ('C:\nowhere')
print ('C:\\nowhere')
print (r'C:\nowhere')  #usage of raw string
print (u'Hello, world!') #Unicode String


#Built in String Functions
str = "this is string example....wow!!!";
print ("str.capitalize() : ", str.capitalize())  #Capitalizes first letter of the string

str = "this is string example....wow!!!"
print ("str.center(40, 'a') : ", str.center(40, 'a'))  #At both sides of the string, a is filled to match the length of 40


str = "this is string example....wow!!!";
sub = "e";
print ("str.count(sub, 4, 40) : ", str.count(sub, 4, 40)) #starting at 4th position and going upto 40 len, count the substring
sub = "wow";
print ("str.count(sub) : ", str.count(sub))


import codecs
import base64
Str = "this is string example....wow!!!"
Str=Str.encode('utf-8',Str)  #b notation is added to the string but encoding not happened
print ("Encoded String: " , Str)

Str = "this is string example....wow!!!"
Str = base64.b64encode(bytes(Str, 'utf-8')) #Encoding Method
print ("Encoded String: " , Str)
Str = base64.b64decode(Str)                #Decoding Method
print ("Decoded String: " , Str)



str = "this is string example....wow!!!";
suffix = "wow!!!";
print(str.endswith(suffix))      #Return TRUE or FALSE based on the suffix match
print(str.endswith(suffix,20))
suffix = "is";
print(str.endswith(suffix, 2, 4))
print(str.endswith(suffix, 2, 6))



str = "this is\tstring example....wow!!!";
print ("Original string: " + str)
print ("Defualt exapanded tab: " +  str.expandtabs())
print ("Double exapanded tab: " +  str.expandtabs(100))



str1 = "this is string example....wow!!!";
str2 = "exam";
print (str1.find(str2))
print (str1.find(str2, 10))
print (str1.find(str2, 10,40))
print (str1.find(str2, 20,40))
print (str1.find(str2, 20))