
#Problem 1
#on a specific Day, 20 customers purchased items from an outlet. Calculate

#1.Probability that exactly 5 customers will return the items.
#2.Probability that max of  5 customers will return the items.
#3.Probability that more than  5 customers will return the items.
#Average number of Customers likely to return the items and the variance and SD of the number of returns

#Solution
#1.P(X=5)
from scipy import stats
pmf=stats.binom.pmf(5,20,0.1)
print('P(X=5)  :',round(pmf,4))

#2.P(X<=5)
cdf=stats.binom.cdf(5,20,0.1)
print('P(X<=5) :',round(cdf,4))

#3.P(X>5)
cdf2=1-stats.binom.cdf(5,20,0.1)
print('P(X>5)  :',round(cdf2,4))

#4.Mean and Variance
[Mean,Variance]=stats.binom.stats(20,0.1)
print('Average :',Mean)
print("Variance :",Variance)

#Binomial Distribution of the above case
import pandas as pd
import seaborn as sn
from matplotlib import pyplot as plt


# #here using square bracket returns TypeError: 'type' object is not subscriptable:
#Binomial_df=pd.DataFrame({'Success':range(1,21),'PMF': list[stats.binom.pmf(range(1,21),20,0.1)]})

Binomial_df=pd.DataFrame({'Success':range(1,21),'PMF': list(stats.binom.pmf(range(1,21),20,0.1))})
sn.barplot(x=Binomial_df.Success,y=Binomial_df.PMF)
plt.title("Binomial Distribution")
plt.xlabel("No of Items Returned")
plt.ylabel("PMF")
plt.show()