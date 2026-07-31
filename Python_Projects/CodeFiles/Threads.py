import threading
import time
# Function that will run in each thread
def print_numbers():
    for i in range(5):
        print(i)
        time.sleep(1)  # Simulate a time-consuming task (e.g., I/O)

# Create thread objects
thread1 = threading.Thread(target=print_numbers)
thread2 = threading.Thread(target=print_numbers)

# Start threads
thread1.start()
thread2.start()

# Wait for both threads to finish
thread1.join()
thread2.join()

print("Both threads have finished executing.")
#------------------------------------------------------------------


def print_message(message):
    print(message)

# Create a thread with an argument
thread1 = threading.Thread(target=print_message, args=("Hello from the thread 1",))
thread2 = threading.Thread(target=print_message, args=("Hello from the thread 2",))
thread3 = threading.Thread(target=print_message, args=("Hello from the thread 3",))
thread4 = threading.Thread(target=print_message, args=("Hello from the thread 4",))

# Start the thread
thread1.start()
thread2.start()
thread3.start()
thread4.start()
#thread1=thread.start()

# Wait for the thread to finish
thread1.join()
thread2.join()
thread3.join()
thread4.join()


print("Main thread finished.")


#----------------------------------------------------------
#Multi Threading creatio and using Locks to prevent Race condition
# Shared resource
counter = 0

# Lock to synchronize threads
lock = threading.Lock()

# Function to increment counter
def increment1():
    global counter
    with lock:  # Locking ensures that only one thread can increment at a time
        local_counter = counter
        local_counter += 1
        counter = local_counter


# Function to increment counter Without Lock
def increment2():
    global counter
    #with lock:  # Locking ensures that only one thread can increment at a time
    local_counter = counter
    local_counter += 1
    counter = local_counter



# Create multiple threads
threads = [threading.Thread(target=increment1) for _ in range(10)]
print(threads)

# Start all threads
for thread in threads:
    thread.start()

# Wait for all threads to finish
for thread in threads:
    thread.join()

print("Final counter value:", counter)