import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sklearn
import sklearn.datasets as sk
import random
import sklearn.linear_model as skmodel
import sklearn.metrics as skm
import sklearn.preprocessing as skp
import matplotlib.colors as mplc

#Linear Regression------------------------------------------------------------------------------------------------------

boston=sk.load_boston()
bos=pd.DataFrame(boston.data)
print(bos.head(10))

bos.columns=boston.feature_names
print(bos.columns)

bos["PRICE"]=boston.target #New column added
#print(bos)
y=bos["PRICE"] #print(y)
x=bos.drop("PRICE",axis=1) #drop the price column
print(x)

# price=intercept + b1*bos["CRIM"] + b2*bos["ZN"] + b3*bos["INDUS"] + b4*bos["CHAS"] + b5*bos["NOX"] + b6*bos["RM"] + \
#       b7*bos["AGE"] + b8*bos["DIS"] + b9*bos["RAD"] + b10*bos["TAX"] + b11*bos["PTRATIO"] + b12*bos["B"] + b13*bos["LSTAT"]

print(y.head())

#a=1#,2,3,4,5,6,7,8,9,10
#random(0.2,a,seed=4) #error: 'module' object is not callable


from sklearn.linear_model import LinearRegression
[x_train,x_test,y_train,y_test]=sklearn.model_selection.train_test_split(x,y,test_size=0.33,random_state=5)
#test_size implies how much amount of the data is taken among the population
#random_state implies selection of same set of elements only we changing the model while training.

print(x_train.shape)
print(x_test.shape)
print(y_train.shape)
print(y_test.shape)

lm=LinearRegression()
lm.fit(x_train,y_train) #implies fit the linearRegression model between x_train and y_train
#this fit function calculates the intercepts such as b,b1,b2,b3,... for all the features in the input
#Actually we are telling the module to learn the coefficients for different x values given y values in the training dataset.
y_train_pred=lm.predict(x_train)
#once the lm learnt the coefficients or intercepts,
y_test_pred=lm.predict(x_test)
df=pd.DataFrame(y_test_pred,y_test)
print(df)

mse=skm.mean_squared_error(y_test,y_test_pred)
print("Mean Squared Error : ",mse)


fig,ax=plt.subplots()
ax.scatter(y_test,y_test_pred)
ax.plot([y_test.min(),y_test.max()],[y_test.min(),y_test.max()],'k--',lw=3)
ax.set_xlabel('Measured')
ax.set_ylabel('Predicted')
plt.show()


#-----------------------------------------------------------------------------------------------------------------------
#Logistic Regression

#df1=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\LogisticRegression.xlsx","Sheet1")
df1=pd.read_csv("C:\\Users\\vasanthk\Desktop\PythonLearning\Social_Network_Ads.csv")  #File Downloaded fron github
print(df1)

x=df1.iloc[:,[2,3]].values # : implies all the rows,[2,3] implies 3rd and 4th columns as index starts with 0 , it is referred as 2 and 3
y=df1.iloc[:,[4]].values

# print(x[0:2]) #List form of representation
# print(y[0:4])

#x=list(x)
#y=list(y)
print(x) #List form of representation
print(y)

#Spitting the dataset into the Training set and the Test Set
[x_train,x_test,y_train,y_test]=sklearn.model_selection.train_test_split(x,y,test_size=0.25,random_state=0)


print("x_train \n",x_train)
print("x_test \n",x_test)
print("y_train \n",y_train)
print("y_test \n",y_test)



#Feature Scaling
sc=skp.StandardScaler()
x_train=sc.fit_transform(x_train)
x_test=sc.transform(x_test)

# print(x_train[0:5,]) #List form of representation with comma seperation
#
# print(x_train.shape)
# print(x_test.shape)
# print(y_train.shape)
# print(y_test.shape)



#Fitting Logistic Regression to the training datatset
classifier=skmodel.LogisticRegression(random_state=0)
#classifier.fit(x_train,y_train) #ValueError: This solver needs samples of at least 2 classes in the data, but the data contains only one class: 0
#it occured because Purchased column contains only zeros.
#scenario1: Run the script keeping thePurchased column value as it is
#scenario2: Run the script after modifying one or two row's of the Purchased column value to '1'


#if len(np.sum(y_train)) in [sum(y_train),0]:
#if len(str(np.sum(y_train))) ==1 :
if len(str(y_train)) == 1:
    print ("y_train vector has only one value( i.e only 1 class ),so the classifier doesn't really need to do any work, "\
           "since all predictions should just be the one class")
    #do something else
else:
    #OK to proceed
    classifier.fit(x_train,y_train)



#Predicting the test set results
y_test_pred=classifier.predict(x_test)

#Making the Confusion Matrix
print([y_test])  #Warning message occuring. need to check it.
print(y_test_pred)
cm=skm.confusion_matrix(y_test,y_test_pred)
print("Confusion Matrix :\n",cm)

# print(type(cm[0]))
# print(cm[0][0])
# print(cm[0][1])
# print(cm[1][0])
# print(cm[1][1])

Accuracy=(cm[0][0]+cm[1][1])/(cm[0][0]+cm[0][1]+cm[1][0]+cm[1][1])
print("Model Accuracy :\n",Accuracy)


#visualizing the Training set results #Some coding functionality error is there . need to study it.
[x_set,y_set]=[x_train,y_train]
[x1,x2]=np.meshgrid(np.arange(start=x_set[:,0].min()-1,stop=x_set[:,0].max()+1,step=0.01),
                  np.arange(start=x_set[:,1].min()-1,stop=x_set[:,1].max()+1,step=0.01))
plt.contourf(x1,x2,classifier.predict(np.array([x1.ravel(),x2.ravel()]).T).reshape(x1.shape),
        alpha=0.75,cmap=mplc.ListedColormap('red','green'))
plt.xlim(x1.min(),x1.max())
plt.ylim(x2.min(),x2.max())
for i,j in enumerate(np.unique(y_set)):
    plt.scatter(x_set[y_set == [j,0]],x_set[y_set == [0,j]],c=mplc.ListedColormap(('red','green'))(i), label = j)
plt.title('Logistic Regression (Training Set)')
plt.xlabel('Age')
plt.ylabel('Estimated Salary')
plt.legend()
plt.show()

#-----------------------------------------------------------------------------------------------------------------------
#Deep Learning
#use python 2.7
#import tensorflow_core as tf
#import tensorflow_estimator as tf

import tensorflow.compat.v1 as tf
tf.disable_v2_behavior()

#print(tf.version)
hello_constant=tf.constant("Hello world !")


with tf.Session() as sess:
    print(hello_constant)
    output=sess.run(hello_constant)
    print(output)

