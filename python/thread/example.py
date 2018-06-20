import threading
import time

cont = 0
max_for = 1000000
parallel = True

lock = threading.Lock()

def sum():
    global cont
    for i in range(0, max_for):
        lock.acquire()
        cont += 1
        lock.release()

start_time = time.time()
if parallel:
    t1 = threading.Thread(target=sum)
    t2 = threading.Thread(target=sum)
     
    t1.start()
    t2.start()

    t1.join()
    t2.join()
else:
    sum()
    sum()
end_time = time.time() - start_time

print(end_time)
print(cont)


# mode serial is faster
# gil is always releasing when it hass I/O operations, URL reading, file reading on disk
