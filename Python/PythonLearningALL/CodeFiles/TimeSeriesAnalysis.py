#Timee Series Analysis
#Time series is a set of data points  indexed in time order

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#-----------------------------------------------------------------------------------------------------------------------
#Pandas Time Series Analysis Part 1: DatetimeIndex and Resample
#Source: https://www.youtube.com/watch?v=r0s4slGHwzE&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=14


a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\\aapl_TimeSeries.xlsx","Sheet1",header=[0])
a=pd.DataFrame(a)
print(a)
print(type(a["Date"][0]))
print(type(a.Date[0]))  #Another Method


#DateTimeIndex
a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\\aapl_TimeSeries.xlsx","Sheet1",header=[0],index_col="Date")
a=pd.DataFrame(a)
print(a)
print(a.index)  #it will return the output as DatetimeIndex

b=a["2017-07"].Close.mean() #returns mean value of close column for the period "2017-07"
print(b)

c=a["2017-07-06"]  #Note : to analyse these, datetimeindex should be set earlier in the data frame.
print(c)


c=a["2017-07-06":"2017-07-04"] # date range: max date to min date - 1
print(c)

#Resampling
b=a.Close.resample('M').mean()  # returns monthly "M" frequency mean value of Close column.Also note the date, it is monthend date
print(b)

# b=a.Close.resample('M').mean() # returns monthly "M" frequency mean value of Close column.Also note the date, it is monthend date
# plt.interactive(True)
# b.plot()
# plt.show(block=True)

plt.interactive(True)
a.plot()
plt.show(block=True)


b=a.Close.resample('d').mean() # returns monthly "M" frequency mean value of Close column.Also note the date, it is monthend date
plt.interactive(True)
b.plot(kind="bar")
plt.show(block=True)



# import pandas as pd
# import numpy as np
# import matplotlib.pyplot as plt
# ts = pd.Series(np.random.randn(1000), index=pd.date_range('1//2000',periods=1000))
# ts = ts.cumsum()
# plt.interactive(True)
# ts.plot()
# plt.show(block=True)

# x = np.linspace(0, 6.28, 100)
#
# plt.plot(x, x**0.5, label='square root')
# plt.plot(x, np.sin(x), label='sinc')

#
# ts = pd.Series(np.random.randn(1000), index=pd.date_range('1/1/2000', periods=1000))
#
# ts = ts.cumsum()
# plt.show()


# import numpy as np
# import matplotlib.pyplot as plt
#
# points = np.arange(-5, 5, 0.01)
# dx, dy = np.meshgrid(points, points)pr
# z = (np.sin(dx)+np.sin(dy))
# plt.imshow(z)
# plt.colorbar()
# plt.title('plot for sin(x)+sin(y)')
# plt.show()


#-----------------------------------------------------------------------------------------------------------------------
#Pandas Time Series Analysis Part 2: date_range
#Source: https://www.youtube.com/watch?v=A9c7hGXQ5A8&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=15

a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\\aapl_TimeSeries_nodate.xlsx","Sheet1",header=[0])
a=pd.DataFrame(a)
print(a)

rng=pd.date_range(start="12/1/2019",end="12/12/2019",freq="B")
print(rng)
a.set_index(rng,inplace=True)
print(a)

plt.interactive(True)
a.Close.plot()
plt.show(block=True)

#Include missing dates with previous days value since for stocks sat and sun are holiday, friday value to be replicated.
print(a.asfreq("D",method="pad"))
print(a.asfreq("W",method="pad"))
print(a.asfreq("H",method="pad"))

#Generating Range without using end date
rng=pd.date_range(start="12/1/2019",periods=20,freq="D")
print(rng)
rng=pd.date_range(start="12/1/2019",periods=40,freq="W")
print(rng)

#Generating Random numbers
a=np.random.randint(0,10,len(rng))
print(a)
a=pd.Series(a,index=rng)
print(a)      #These type of sample data creation is useful for performing Sample data testing

#-----------------------------------------------------------------------------------------------------------------------
#Pandas Time Series Analysis 3: Holidays
#Source: https://www.youtube.com/watch?v=Fo0IMzfcnQE&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=16


a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\\aapl_TimeSeries_nodate.xlsx","Sheet1",header=[0])
a=pd.DataFrame(a)
print(a)

rng=pd.date_range(start="12/1/2019",end="12/12/2019",freq="B") # This will remove only sat and sundays of a particular calander.
# but if that is different from other calender say USA Calander, then we have to consider that calander data. also some companies
#will have a specific calander data with predefined holidays for the current year. in such a case we need to incorporate that calander.

from pandas.tseries.holiday import USFederalHolidayCalendar # USFederalHolidayCalendar is a Class
from pandas.tseries.offsets import CustomBusinessDay # CustomBusinessDay is a Class

usb=CustomBusinessDay(calendar=USFederalHolidayCalendar())
print(usb)

rng=pd.date_range(start="12/1/2019",end="12/12/2019",freq=usb) #Note the freq is modified
print(rng)
a.set_index(rng,inplace=True)
print(a)

#------------------------------

#Since Pandas is a Opensource , we can define a new holiday class as below

from pandas.tseries.holiday import AbstractHolidayCalendar, nearest_workday, Holiday
class VasanthBirthdayCalendar(AbstractHolidayCalendar):
    """
    This was defined for a particular day.
    it can be customized for any date range as required.
    Also note , it is multi line comment
    """
    rules =[
        Holiday('Vasanth\'s Birthday',month=11,day=2)# ,observance=nearest_workday) # observance=nearest_workday==> enabling this will declare the immediate previous and next day also as Holiday
    ]

mycalendar=CustomBusinessDay(calendar=VasanthBirthdayCalendar())
print(mycalendar)

rng=pd.date_range(start="11/1/2019",end="11/12/2019",freq=mycalendar) #Note the freq is modified, it will not show the 2nd date as it was declared as holiday
print(rng)


#for countries like egypt, only Friday and saturday is a holiday and sunday is a businessday, so we should include it in our calendar.
b=CustomBusinessDay(weekmask="Sun Mon Tue Wed Thu", holidays=["2019-11-05","2019-11-11"])

rng=pd.date_range(start="11/1/2019",end="11/12/2019",freq=b) #Note the freq is modified, it will not show the 2nd date as it was declared as holiday
print(rng)



#-----------------------------------------------------------------------------------------------------------------------
#Pandas Time Series Analysis 4: to_datetime
#Source: https://www.youtube.com/watch?v=igWjq3jtLYI&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=17


dates=['2017-01-05','Jan 5,2017','01/05/2017','2017.01.05','2017/01/05','20170105']
print(pd.to_datetime(dates))

date1='01/05/2017'
print(pd.to_datetime(date1, dayfirst=True)) # Required to explicitly say the first value is date or month since in US and European date formats are different

date2='01$05$2017'
print(pd.to_datetime(date2,format='%d$%m$%Y'))

date3=['2017-01-05','Jan 5,2017','01/05/2017','2017.01.05','2017/01/05','20170105','abc'] #string is added along with date
print(pd.to_datetime(date3,errors='ignore'))
print(pd.to_datetime(date3,errors='coerce'))


date4=1501356749 #it is an epoch number representing a date
date5=pd.to_datetime(date4, unit='s') #default unit is ns
print(date5)
# date6=date5.view('int64')  #it is not working in Pycharm as available in Jupiter
# print(date6)


#-----------------------------------------------------------------------------------------------------------------------
#Pandas Time Series Analysis 5: Period and PeriodIndex
#Source: https://www.youtube.com/watch?v=3l9YOS4y24Y&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=18

y=pd.Period('2019')
print(y)
print(y.start_time)
print(y.end_time)


y=pd.Period('2019-12',freq='M')
print(y)
print(y.start_time)
print(y.end_time)
y=y+1  #Month got added
print(y)


y=pd.Period('2016-02-28') #Freq is not required to be mentioned here. it will automatically detect it.
print(y)
y=y+1 #day got added. leap year concept is working here
print(y)

y=pd.Period('2019-02-28') #Freq is not required to be mentioned here. it will automatically detect it.
print(y)
y=y+1 #day got added
print(y)

y=pd.Period('2016-02-28 23:00:00', freq='H') #Hourly Frequency
print(y)
print(y.start_time)
print(y.end_time)
y=y+1
print(y)
y=y+pd.offsets.Hour(5) # Adding 5 hours
print(y)


y=pd.Period('2019Q1')  #it indicates Q1 as  Jan1 to Mar31
print(y)
print(y.start_time)
print(y.end_time)

y=pd.Period('2019Q1', freq='Q-MAR') #It indicates Quarter ending in March
print(y)
print(y.start_time)
print(y.end_time)

y2=pd.Period('2020Q2',freq='Q-MAR')
print(y2)
print(y2-y)

#----Period Index----------
idx=pd.period_range('2017','2020',freq='Q') #Jan-Mar is considered as 2017Q1
print(idx)
idx=pd.period_range('2017','2020',freq='Q-MAR') #Jan-Mar is considered as 2017Q4
print(idx)

print(idx[0].start_time)
print(idx[0].end_time)

idx=pd.period_range('2017',periods=10,freq='Q-MAR') #instead of end date, period is mentioned
print(idx)

a=pd.Series(np.random.rand(len(idx)),idx)
print(a)
print(a.index)
print(a['2017'])
print(a['2017':'2018'])
b=a.to_timestamp() #converting the Quarterly index to datewise index i.e Periodindex to Datetime Index conversion.
print(b)
c=b.to_period()  #Datetime Index to Periodindex conversion. we got back period index
print(c)



a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\\wmt_PeriodIndex.xlsx","Sheet1",header=[0])
a=pd.DataFrame(a)
print(a)
a.set_index('LineItem',inplace=True)
print(a)
a=a.T #Transpose the dataframe
print(a)
print(a.index) # the type of the index is dtype='object'.
a.index=pd.PeriodIndex(a.index,freq='Q-MAR') #index type conversion from Object type to Period Type
print(a.index) # the type of the index is dtype='period[Q-MAR]'

a['StartDate']=a.index.map(lambda x:x.start_time)
a['EndDate']=a.index.map(lambda x:x.end_time)
print(a)

#-----------------------------------------------------------------------------------------------------------------------
#Pandas Time Series Analysis 6: Timezone Handling
#Source: https://www.youtube.com/watch?v=9IW2GIJajLs&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=19


a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\\TimeZone.xlsx","Sheet1",header=[1],index_col='DateTime',parse_dates=True)
a=pd.DataFrame(a)
print(a)
print(a.index)  #observe the dtype value in the result

#There are two types of Datetime Objects in Python
# 1.Naive (No TimeZone Awareness)
# 2. TimeZone aware datetime

from pytz import all_timezones
# print(all_timezones)
# print(list(all_timezones))


b=a.tz_localize(tz='US/Eastern')
print(b.index) #observe the dtype value in the result.Also check the time

c=a.tz_localize(tz='Europe/Berlin')
print(c.index) #observe the dtype value in the result.Also check the time

# c=a.tz_convert(tz='Europe/Berlin')  #tz_convert function is not working
# print(c.index) #observe the dtype value in the result.Also check the time


c=a.tz_localize(tz='Asia/Calcutta')
print(c.index) #observe the dtype value in the result.Also check the time


rng=pd.date_range(start='1/1/2020',periods=10,freq='H',tz='Europe/London')
print(rng) #Observe the dtype in output1

#timezone can be added by using pytz or dateutil function
# the main difference between them is pytz contains a list of timezones from python
#whereas the dateutil function considers all the time zones available from the operating system

rng=pd.date_range(start='1/1/2020',periods=10,freq='H',tz='dateutil/Europe/London')
print(rng) #Observe the dtype in output2
s=pd.Series(range(10),index=rng)
print(s)

b=s.tz_convert(tz='Europe/Berlin')  #tz_convert function is working if dateutil function is used before..
print(b)

m=s.tz_convert(tz='Asia/Calcutta')  #tz_convert function is working if dateutil function is used before..
print(m)

print(b+m)

#-----------------------------------------------------------------------------------------------------------------------
#Pandas Time Series Analysis 6: Shifting and Lagging
# Source: https://www.youtube.com/watch?v=0lsmdNLNorY&list=PLeo1K3hjS3uuASpe-1LjfG5f14Bnozjwy&index=20

a=pd.read_excel("C:\\Users\\vasanthk\Desktop\PythonLearning\\FBdata_Shifting_Lagging.xlsx","Sheet1",header=[0],index_col='Date',parse_dates=True)
a=pd.DataFrame(a)
print(a)

b=a.shift(4)
print(b)

c=a.shift(-5)
print(c)

a['PrevDayPrice']=a['Price'].shift(1)  #Adding new column
print(a)

a['1DayChange']=a["Price"]-a["PrevDayPrice"]
print(a)

a['5day%Return']=(a["Price"]-a["Price"].shift(5))*100/a["Price"].shift(5)
print(a)

a=a[["Price"]] #All other columns will be removed, since Date Column is made as an Index column it is not under discussion
print(a)
print(a.index)  #result shows freq =None

a.index=pd.date_range(start='2017-08-15',periods=10,freq='B')
print(a.index)  #result shows freq =B i.e Business day Freeq

b=a.tshift(3) #Date column will be moved by 1 day before but price remains same.
print(b)



