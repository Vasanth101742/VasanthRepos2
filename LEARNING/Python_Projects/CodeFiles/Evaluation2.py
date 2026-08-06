import pandas as pd
from statsmodels.tsa.stattools import adfuller
from pandas.api.types import CategoricalDtype

cat_type = CategoricalDtype(categories=['Monday','Tuesday',
                                        'Wednesday',
                                        'Thursday','Friday',
                                        'Saturday','Sunday'],
                            ordered=True)


def create_features(df, label=None):
    """
    Creates time series features from datetime index.
    """
    df = df.copy()
    print(df)
    df['date'] = df.index
    df['hour'] = df['date'].dt.hour
    df['dayofweek'] = df['date'].dt.dayofweek
    df['weekday'] = df['date'].dt.day_name()
    df['weekday'] = df['weekday'].astype(cat_type)
    df['quarter'] = df['date'].dt.quarter
    df['month'] = df['date'].dt.month
    df['year'] = df['date'].dt.year
    df['dayofyear'] = df['date'].dt.dayofyear
    df['dayofmonth'] = df['date'].dt.day
    #df['weekofyear'] = df['date'].dt.weekofyear
    df['date_offset'] = (df.date.dt.month*100 + df.date.dt.day - 320)%1300

    df['season'] = pd.cut(df['date_offset'], [0, 300, 602, 900, 1300], 
                          labels=['Spring', 'Summer', 'Fall', 'Winter']
                   )
    X = df[['hour','dayofweek','quarter','month','year',
           'dayofyear','dayofmonth',#'weekofyear',
           'weekday','season']]
    if label:
        y = df[label]
        return X, y
    return X


def adf_test(series, autolag='AIC', regression='c'):
    result = adfuller(series, autolag=autolag, regression=regression)
    #print("Result : \n",result)
    output = pd.Series(result[0:4], 
                       index=['ADF Test Statistic', 'p-value', 'Lags Used', 'No of Observations'])
    for key, val in result[4].items():
        output[f'Critical Value ({key})'] = val
    output2=pd.Series(result[5:6], index=['Max Information Criterion'])
    output=pd.concat([output,output2])
    return output
