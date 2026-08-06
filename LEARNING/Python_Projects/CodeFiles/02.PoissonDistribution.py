#Problem 1: Calls arriving a call center follows Poisson distribution at 10 calls per hour
#Calculate
#1.Probability that no of calls will be maximum 5
#2.Probability that no of calls over a three hour period will exceed 30

#Solution:
#1.P(X=5)
from scipy import stats
cdf=stats.poisson.cdf(5,10)
print('P(X=5) :',round(cdf,4))

#2.P(X>30)
cdf2=1-stats.poisson.cdf(30,30)
print('P(X>30) :',round(cdf2,4))

#3.Poisson Distribution
import pandas as pd
import seaborn as sn
from matplotlib import pyplot as plt
Poisson_df=pd.DataFrame({'Success':range(1,31),'PMF':list(stats.poisson.pmf(range(1,31),10))})
sn.barplot(x=Poisson_df.Success,y=Poisson_df.PMF)
plt.title("Poisson Distribution")
plt.xlabel
plt.ylabel("PMF")
plt.show()