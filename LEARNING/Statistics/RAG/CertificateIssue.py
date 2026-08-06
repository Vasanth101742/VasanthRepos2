

from datetime import date
import calendar

def last_24_month_ends(ref_date=None):
    """
    Returns a list of dates for the last day of each month, for the past 24 months,
    ending with the month prior to ref_date (or prior to today if ref_date is None).
    """
    if ref_date is None:
        ref_date = date.today()
    year, month = ref_date.year, ref_date.month
    #print(year,'-',month)

    results = []
    # we'll go back 24 months
    for i in range(1, 25):
        # compute the year and month for i months ago
        m = month - i
        y = year
        print('Before Change :',y,' ',m)
        # adjust year & month 
        if m <= 0:
            m += 12 
            if m==0:
                m=12
                y -= 1
            y -= 1
        
        
        # find last day of that month
        print('After Change :',y,' ',m)
        last_day = calendar.monthrange(y, m)[1]
        #print(last_day)
        results.append(date(y, m, last_day))
        #formatted = results.strftime("%Y-%m-%d")
        #print(results)
    results=sorted(results,reverse=False)
    return results

# Example usage:
for dt in last_24_month_ends():
    #sorted(dt)
    print(dt)






# from datetime import datetime,timedelta
# from dateutil.relativedelta import relativedelta
# today1=datetime.today()
# result1=today1-timedelta(days=10)

# result2=today1-relativedelta(months=24)
# result2=result2.date()
# print(f"result1={result1}")
# print(f"result2={result2}")





#-------------------------------------------------------------------------------------


# class MyClass:
#     def __init__(self):
#         print("Object created!")

# obj = MyClass()

#--------------------------------------------------------------------------------------

# import langchain
# print(langchain.__version__)
# from langchain_classic.text_splitter import RecursiveCharacterTextSplitter
# print(RecursiveCharacterTextSplitter)

#--------------------------------------------------------------------------------------

# import os
# ca_bundle_path = "D:/SSLCertificate/netskope.pem"  # ← change this to your actual file path
# os.environ['CURL_CA_BUNDLE'] = ca_bundle_path

# from sentence_transformers import SentenceTransformer

# # model_name = "sentence-transformers/all-MiniLM-L6-v2"
# # model_name = "sentence-transformers/all-MiniLM-L12-v2"
# # model_name = "sentence-transformers/all-MiniLM-L12-v2"
# model_name = "sentence-transformers/all-MiniLM-L12-v2"

# model = SentenceTransformer(model_name)
#---------------------------------------------------------------------------------------

# import os
# import requests

# def main():
#     # 1) Set the environment variable pointing to your custom CA bundle
#     ca_bundle_path = "D:/SSLCertificate/netskope.pem"  # ← change this to your actual file path
#     os.environ['CURL_CA_BUNDLE'] = ca_bundle_path
#     # Optionally, you can also set REQUESTS_CA_BUNDLE if you prefer:
#     os.environ['REQUESTS_CA_BUNDLE'] = ca_bundle_path

#     # 2) Make an HTTPS request
#     url = "https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2/resolve/main/modules.json"
#     try:
#         response = requests.get(url)
#         response.raise_for_status()
#         print("Response status:", response.status_code)
#         print("Content snippet:", response.text[:200])
#     except requests.exceptions.SSLError as ssl_err:
#         print("SSL verification failed:", ssl_err)
#     except Exception as e:
#         print("Request failed:", e)

# if __name__ == "__main__":
#     main()
