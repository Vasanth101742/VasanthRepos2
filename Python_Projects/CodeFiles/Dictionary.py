Dict = {'Tim': 18,'Charlie':12,'robert':22,'Robert':25}
print (Dict['robert'])
print (Dict['Robert'])
print (Dict.keys())
print (Dict.values())

print('\n\n')
print('Copying the Dictionary')
Dict = {'Tim': 18,'Charlie':12,'Tiffany':22,'Robert':25}
Boys = {'Tim': 18,'Charlie':12,'Robert':25}
Girls = {'Tiffany':22}
studentX=Boys.copy()
studentY=Girls.copy()
print(studentX)
print(studentY)

print('\n\n')
print('Updating the Dictionary')
Dict = {'Tim': 18,'Charlie':12,'Tiffany':22,'Robert':25}
Dict.update({"Sarah":9})
print(Dict)

#Deleting Keys from the Dictionary
print('\n\n')
print('Deleting Keys from the Dictionary')
Dict = {'Tim': 18,'Charlie':12,'Tiffany':22,'Robert':25}
print(Dict)
del Dict ['Charlie']
print(Dict)

#Dictionary items() Method
print('\n\n')
print('#Dictionary items() Method')
Dict = {'Tim': 18,'Charlie':12,'Tiffany':22,'Robert':25}
print("Students Name: %s" % list(Dict.items()))