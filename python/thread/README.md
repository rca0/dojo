Asyncio works with:
- competition
- parallelism

competition X parallelism

Competition -> A coffee machine for two queues

QUEUE 1 -> [] [] [] [] \

COFFEE -------------- X

QUUEU 2 -> [] [] [] [] /

Parallelism -> A coffee machine for each queue

QUEUE 1 -> [] [] [] [] -> X

QUEUE 2 -> [] [] [] [] -> X

GIL -> Global Interprer Lock
Two queues, two coffee machine, one coffee packet

QUEUE 1 -> [] [] [] [] -> X \

COFFEE / PACKET ------- P

QUEUE 2 -> [] [] [] [] -> X /


