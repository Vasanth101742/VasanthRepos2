import pandas as pd
import numpy as np

#Equation of the Simple Linear Regression Model
#Y=a0+a1(X)+e

#Setting Pandas print option to print decimal values upto 4 decimal places
np.set_printoptions(precision=4,linewidth=100)

mba_salary_df=pd.read_excel("MBA_Salary.xlsx","Sheet1")
print(mba_salary_df.info())

#Creating Feature Set(X) and Outcome Variable (Y)
import statsmodels.api as sm   #api imported here is used only for calculating the coefficient a1
X=sm.add_constant(mba_salary_df['10thPercentage']) #hence we are adding a0 constant value explicitly
#print(X)

Y=mba_salary_df['Salary']

#Splitting the input data into Training and Test data sets--------------------------------------------------------------
from sklearn.model_selection import train_test_split
[train_X,test_X,train_Y,test_Y]=train_test_split(X,Y,train_size=0.8,random_state=100)
# print("\n train_X \n",train_X.info())
# print("\n test_X \n",test_X.info()) #It is showing the output as None because it is a series object
# print("\n test_X \n",test_X) #but here the output is displayed, why??!!
print("\n train_X \n",train_X)
#print("\n train_Y \n",train_Y.info()) #'Error: Series' object has no attribute 'info'
#print("\n test_Y \n",test_Y.info()) #'Error: Series' object has no attribute 'info'
print("\n train_Y \n",train_Y)
#print("\n test_Y \n",test_Y) #but here the output is displayed, why??!!


#Fitting the Model------------------------------------------------------------------------------------------------------
mba_salary_lm=sm.OLS(train_Y,train_X).fit()  #OLS => ordinary least squares regression
print(mba_salary_lm.params)

#the above output can be written as
#MBA_Salary=30587.285652 + 3560.587383*(10thPercentage)

#Evaluating the Model Performance---------------------------------------------------------------------------------------

#1. R Squared Test (Coefficient of Determination)
# from sklearn.metrics import r2_score
# r2 = r2_score(train_Y, train_X)
# print('r2 score for perfect model is', r2)
