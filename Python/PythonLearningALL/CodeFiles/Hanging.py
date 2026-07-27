import multiprocessing
import time


def hang():
    while True:
        print ('hanging..')
        time.sleep(5)


def main():
    p = multiprocessing.Process(target=hang)
    p.start()
    time.sleep(5)
    print ('main process exiting..')


if __name__ == '__main__':
    main()
