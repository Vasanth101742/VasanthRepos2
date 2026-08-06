import pandas as pd

def create_calendar_df(start='2025-04-01', end='2026-03-31'):
    # Generate a date range
    dates = pd.date_range(start=start, end=end, freq='D')
    
    # Create a DataFrame
    df = pd.DataFrame({
        'Date': dates,
        'Day': dates.day_name(),
        'DayOfWeek': dates.weekday,
        'Week': dates.isocalendar().week,
        'Month': dates.month,
        'Quarter': dates.quarter,
        'Year': dates.year,
        'YearHalf': (dates.month - 1) // 6 + 1,
        'MonthName': dates.month_name(),
        'DayOfYear': dates.dayofyear,
        'IsLeapYear': dates.is_leap_year,
        'IsWeekend': dates.weekday >= 5,
        'IsHoliday': dates.isin(pd.to_datetime([
            '2025-01-01', '2025-12-25', '2025-10-02', '2025-08-15', '2025-11-14'
        ]))
    })
    
    # Reset index to add a unique date_id
    
    #df.reset_index(drop=True, inplace=True) #Commented by Vasanth
    #df.index.name = 'date_id'
    
    #df.set_index('Date', inplace=False) #Added by Vasanth
    
    return df

# # Example usage
# calendar_df = create_calendar_df()
# #print(calendar_df.head())


# today = pd.to_datetime('today')
# end_date = today + pd.DateOffset(months=3)
# print(end_date)


def ForecastPeriod(): 
    # Example usage
    calendar_df = create_calendar_df()
    #print(calendar_df.head())

    today = pd.to_datetime('today')
    end_date = today + pd.DateOffset(months=3)
    print(end_date)

    Forecast_Period_df = calendar_df[(calendar_df['Date'] >= today) & (calendar_df['Date'] <= end_date)]
    #print(Forecast_Period_df)
    ForecastDates=Forecast_Period_df['Date']
    #print(ForecastDates)
    #print(type(ForecastDates))
    ForecastDays=Forecast_Period_df['Date'].count()
    #print(ForcastDays)
    Forecastinfo=[ForecastDays,ForecastDates]
    # print(Forecastinfo[0])
    # print(Forecastinfo[1])
    return Forecastinfo


a=ForecastPeriod()
print(a)