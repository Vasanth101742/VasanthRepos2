import datetime                 # AttributeError: module 'datetime' has no attribute 'today'
from datetime import datetime   # in order to use the today() function, should be declared like this only



date=datetime.now()
print("datetime.now() :",date)
date=datetime.today()
print("datetime.today() :",date)
date=datetime.today().strftime("%Y-%m-%d")
print("datetime.today().strftime(""%Y-%m-%d"") :",date)

time=datetime.now().isoformat()
print ("time :",time)
#-------------------------------------------------------------------------------------------------------------

from datetime import date

today=date.today()
print(today)


d1 = today.strftime("%d/%m/%Y")
print("d1 =", d1)

# Textual month, day and year
d2 = today.strftime("%B %d, %Y")
print("d2 =", d2)

# mm/dd/y
d3 = today.strftime("%m/%d/%y")
print("d3 =", d3)

# Month abbreviation, day and year
d4 = today.strftime("%b-%d-%Y")
print("d4 =", d4)
