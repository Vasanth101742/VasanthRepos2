import pycaret
print(pycaret.__version__)

# from pycaret.datasets import get_data
# data=get_data("pycaret_downloads")
# print(data)

from pycaret.time_series import *
s=setup(data,fold=3,fh=12,session_id=123)

print(check_stats)