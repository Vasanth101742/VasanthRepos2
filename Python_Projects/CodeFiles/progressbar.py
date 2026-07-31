from tqdm import tqdm
import time

# Simulate a data loading process
data = range(100)  # A list of 100 items, for example

# Use tqdm to create a progress bar
for item in tqdm(data, desc="Loading data", unit="item"):
    time.sleep(0.05)  # Simulating a time-consuming task, like loading data



#------------------------------------------------------------------------------

# import sys
# import time

# # Simulate a data loading process
# data = range(100)

# def print_progress_bar(iteration, total, length=40):
#     percent = ("{0:.1f}").format(100 * (iteration / float(total)))
#     filled_length = int(length * iteration // total)
#     bar = "#" * filled_length + "-" * (length - filled_length)
#     sys.stdout.write(f'\r|{bar}| {percent}% Complete')
#     sys.stdout.flush()

# # Using the progress bar in a loop
# for i, item in enumerate(data, 1):
#     time.sleep(0.05)  # Simulate some data loading
#     print_progress_bar(i, len(data))
