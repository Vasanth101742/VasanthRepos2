import streamlit as st
from datetime import date
import fbprophet
from fbprophet import prophet
import yfinance
from fbprophet.plot import plot_plotly
from plotly import graph_objs as go

StartDate="2023-04-01"
EndDate=date.today().strftime("%Y-%m-%d")
print(StartDate)
print(EndDate)