# coding:utf-8

<<<<<<< HEAD
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
=======
import logging

# 配置日志信息
logging.basicConfig(level=logging.DEBUG,
format='%(asctime)s %(name)-12s %(levelname)-8s %(message)s',
datefmt='%m-%d %H:%M',
filename='myapp.log',
filemode='w')
# 定义一个Handler打印INFO及以上级别的日志到sys.stderr
console = logging.StreamHandler()
console.setLevel(logging.INFO)
# 设置日志打印格式
formatter = logging.Formatter('%(name)-12s[line:%(lineno)3d]:%(levelname)-8s %(message)s')
console.setFormatter(formatter)
# 将定义好的console日志handler添加到root logger
logging.getLogger('').addHandler(console)

logging.info('Jackdaws love my big sphinx of quartz.')

logger1 = logging.getLogger('myapp.area1')
logger2 = logging.getLogger('myapp.area2')

logger1.debug('Quick zephyrs blow, vexing daft Jim.')
logger1.info('How quickly daft jumping zebras vex.')
logger2.warning('Jail zesty vixen who grabbed pay from quack.')
logger2.error('The five boxing wizards jump quickly.')

>>>>>>> origin/master
