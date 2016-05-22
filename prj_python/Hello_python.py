# coding:utf-8

squares = []
for x in range (10):
    squares.append(x**2)

print(squares)

squares = [x**2 for x in range(10)]

print(squares)

numbers = [x for x in range(100) if x % 3 == 0]

print(numbers)

noprimes = [j for i in range(2, 8) for j in range(i*2, 50, i)]
primes = [x for x in range(2, 50) if x not in noprimes]

print(primes)
