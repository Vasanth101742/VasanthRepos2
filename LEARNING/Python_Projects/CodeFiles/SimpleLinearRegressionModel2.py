#%matplotlib inline
import numpy as np
from sklearn.metrics import r2_score
import matplotlib.pyplot as plt
from scipy import stats

#1.Input Data
x = np.array([0,1,2,3,4,5,6,7,8,9])
y = np.array([0,2,3,5,8,13,21,34,55,89])
# print(x)
# print(y)

#2. creating OLS regression i.e yp
slope, intercept, r_value, p_value, std_err = stats.linregress(x,y)

print('slope : ',slope)
print('intercept : ',intercept)
print('r_value : ',r_value)
print('p_value : ',p_value)
print('std_err : ',std_err)

def linefitline(b):
    return intercept + slope * b
line1 = linefitline(x)



#plot line
plt.scatter(x,y)
plt.plot(x,line1, c = 'g')
plt.show()


#3. create y cap line
line2 = np.full(10,[y.mean()])
plt.scatter(x,y)
plt.plot(x,line2, c = 'r')
plt.show()



#4. Error Calculation of line1 and line2
diff_line1= line1-y
line1sum = 0
for i in diff_line1:
    line1sum = line1sum + (i*i)

print('line1sum :',line1sum)

diff_line2= line2-y
line2sum = 0
for i in diff_line2:
    line2sum = line2sum + (i*i)

print('line2sum :',line2sum)

#R Square Calculation
r2 = r2_score(y, line1)
print('The rsquared value is: ' + str(r2))


