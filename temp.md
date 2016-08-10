# 【SQLite】Python的数据库操作

SQLite3 可使用 sqlite3 模块与 Python 进行集成。

Python 2.5.x 以上版本默认自带了该模块。

1. [sqlite3的官方文档](https://docs.python.org/3.5/library/sqlite3.html?highlight=sqlite)


### SQL 记录

CREATE TABLE COMPANY (ID INT PRIMARY KEY NOT NULL, NAME TEXT NOT NULL, AGE INT NOT NULL, ADDRESS CHAR(50), SALARY REAL);



### INSERT & SELECT -python
在conn.execute()中执行SQL语句，这里不能够用python中操作string的方法，会导致不安全，易遭受到SQL的注入攻击
> Usually your SQL operations will need to use values from Python variables. You shouldn’t assemble your query using Python’s string operations because doing so is insecure; 
> it makes your program vulnerable to an SQL injection attack (see https://xkcd.com/327/ for humorous example of what can go wrong).

```python
# Never do this -- insecure!
symbol = 'RHAT'
c.execute("SELECT * FROM stocks WHERE symbol = '%s'" % symbol)

# Do this instead, makes t a tuple; don't forget the common at the end
t = ('RHAT',)
c.execute('SELECT * FROM stocks WHERE symbol=?', t)
print(c.fetchone())

# Larger example that inserts many records at a time
purchases = [('2006-03-28', 'BUY', 'IBM', 1000, 45.00),
('2006-04-05', 'BUY', 'MSFT', 1000, 72.00),
('2006-04-06', 'SELL', 'IBM', 500, 53.00),
]
c.executemany('INSERT INTO stocks VALUES (?,?,?,?,?)', purchases)
```                                    
