## Python3 Note
### 数据类型检查

func isinstance()
下列代码只允许整数和浮点数的参数类型，出错会抛出异常信息`raise TypeError`。
如果参数个数不对，Python解释器会自动检查出来，并抛出TypeError：
``` python
if not isinstance(x, (int, float)):
    raise TypeError('bad operand type')
```
并且还可以判断一个变量是否是某些类型中的一种，比如下面的代码就可以判断是否是list或者tuple：

    >>> isinstance([1, 2, 3], (list, tuple))
    True
    >>> isinstance((1, 2, 3), (list, tuple))
    True

另外，可以使用type()函数检查变量类型

    >>> import types
    >>> def fn():
    ...     pass
    ...
    >>> type(fn)==types.FunctionType
    True
    >>> type(abs)==types.BuiltinFunctionType
    True
    >>> type(lambda x: x)==types.LambdaType
    True
    >>> type((x for x in range(10)))==types.GeneratorType
    True

### 函数参数

可变参数、关键字参数、命名的关键字参数

#### 函数参数，可变参数，*args 调用List或者tuple作为函数的可变参数

*args

在Python函数中，还可以定义可变参数。顾名思义，可变参数就是传入的参数个数是可变的，可以是1个、2个到任意个，还可以是0个。

我们以数学题为例子，给定一组数字a，b，c……，请计算a2 + b2 + c2 + ……。

要定义出这个函数，我们必须确定输入的参数。由于参数个数不确定，我们首先想到可以把a，b，c……作为一个list或tuple传进来，这样，函数可以定义如下：

    def calc(numbers):
        sum = 0
        for n in numbers:
            sum = sum + n * n
        return sum

但是调用的时候，需要先组装出一个list或tuple：

    >>> calc([1, 2, 3])
    14
    >>> calc((1, 3, 5, 7))
    84

如果利用可变参数，调用函数的方式可以简化成这样：

    >>> calc(1, 2, 3)
    14
    >>> calc(1, 3, 5, 7)
    84

所以，我们把函数的参数改为可变参数：

    def calc(*numbers):
        sum = 0
        for n in numbers:
            sum = sum + n * n
        return sum

定义可变参数和定义一个list或tuple参数相比，仅仅在参数前面加了一个*号。在函数内部，参数numbers接收到的是一个tuple，因此，函数代码完全不变。但是，调用该函数时，可以传入任意个参数，包括0个参数：
如果已经有一个list或者tuple，要调用一个可变参数怎么办？可以这样做：

```
>>> nums = [1, 2, 3]
>>> calc(nums[0], nums[1], nums[2])
14
```
这种写法当然是可行的，问题是太繁琐，所以Python允许你在list或tuple前面加一个*号，把list或tuple的元素变成可变参数传进去：
```
>>> nums = [1, 2, 3]
>>> calc(*nums)
14
```
`*nums`表示把`nums`这个list的所有元素作为可变参数传进去。这种写法相当有用，而且很常见。

#### 函数参数，关键字传递, **kw

**kw
可变参数允许你传入0个或任意个参数，这些可变参数在函数调用时自动组装为一个tuple。而关键字参数允许你传入0个或任意个含参数名的参数，这些关键字参数在函数内部自动组装为一个dict。请看示例：

    def person(name, age, **kw):
        print('name:', name, 'age:', age, 'other:', kw)

函数person除了必选参数name和age外，还接受关键字参数kw。在调用该函数时，可以只传入必选参数：

    >>> person('Michael', 30)
    name: Michael age: 30 other: {}

也可以传入任意个数的关键字参数：

    >>> person('Bob', 35, city='Beijing')
    name: Bob age: 35 other: {'city': 'Beijing'}
    >>> person('Adam', 45, gender='M', job='Engineer')
    name: Adam age: 45 other: {'gender': 'M', 'job': 'Engineer'}

关键字参数有什么用？它可以扩展函数的功能。比如，在person函数里，我们保证能接收到name和age这两个参数，但是，如果调用者愿意提供更多的参数，我们也能收到。试想你正在做一个用户注册的功能，除了用户名和年龄是必填项外，其他都是可选项，利用关键字参数来定义这个函数就能满足注册的需求。

和可变参数类似，也可以先组装出一个dict，然后，把该dict转换为关键字参数传进去：

    >>> extra = {'city': 'Beijing', 'job': 'Engineer'}
    >>> person('Jack', 24, city=extra['city'], job=extra['job'])
    name: Jack age: 24 other: {'city': 'Beijing', 'job': 'Engineer'}

当然，上面复杂的调用可以用简化的写法：

    >>> extra = {'city': 'Beijing', 'job': 'Engineer'}
    >>> person('Jack', 24, **extra)
    name: Jack age: 24 other: {'city': 'Beijing', 'job': 'Engineer'}

`**extra`表示把extra这个dict的所有key-value用关键字参数传入到函数的`**kw`参数，kw将获得一个dict，**注意kw获得的dict是extra的一份拷贝**，对kw的改动不会影响到函数外的extra。

#### 小结

Python的函数具有非常灵活的参数形态，既可以实现简单的调用，又可以传入非常复杂的参数。

默认参数一定要用不可变对象，如果是可变对象，程序运行时会有逻辑错误！

要注意定义可变参数和关键字参数的语法：

*args是可变参数，args接收的是一个tuple；

**kw是关键字参数，kw接收的是一个dict。

以及调用函数时如何传入可变参数和关键字参数的语法：

可变参数既可以直接传入：func(1, 2, 3)，又可以先组装list或tuple，再通过`*args`传入：`func(*(1, 2, 3))`；

关键字参数既可以直接传入：func(a=1, b=2)，又可以先组装dict，再通过`**kw`传入：`func(**{'a': 1, 'b': 2})`。

使用*args和**kw是Python的习惯写法，当然也可以用其他参数名，但最好使用习惯用法。

命名的关键字参数是为了限制调用者可以传入的参数名，同时可以提供默认值。

定义命名的关键字参数不要忘了写分隔符*，否则定义的将是位置参数。

### 递归函数

递归函数的栈优化，尾递归函数
Python 并未对尾递归函数做特殊的优化

### 列表生成式中 if else 句式的应用

如下 [s.lower() if isinstance() else s for s in L]

例子1 ：

    L = ['Java' , 'C' , 'Swift' , 'Python' , 123]
    print([s.lower() if isinstance(s , str) else s for s in L])

例子2：

    sentence = "your mother was a hamster"
    vowels = 'aeiou'
    nonvowels = ''.join(l if not in vowels else '0' for l in sentence)
    print(nonvowels)

这个例子使用列表生成式创建一个字母列表，字母列表的字母来自sentence句子的非元音字母。然后我们把生成的列表传给join()函数去转换为字符串。
例子2的另一种方法：

    nonvowels = ''.join(l for l in sentence if not l in vowels)

注意，这里去掉了方括号。这是因为join函数接收任意可迭代的数据，包括列表或者生成器。这个没有方括号的语法使用了生成器。这产生（与列表生成式）同样的结果，相对于之前把所有条目包装成一个列表,生成器在我们遍历时才产生相应的条目。这可以使我们不必保存整个列表到内存，并且这对于处理大量数据更有效率。

### 类关键字

TBD

### Debug,pdb

pdb, pdb.set_trace()

#### pdb

第4种方式是启动Python的调试器pdb，让程序以单步方式运行，可以随时查看运行状态。我们先准备好程序：

```
    # err.py
    s = '0'
    n = int(s)
    print(10 / n)
```

然后启动：

``` python
    $ python3 -m pdb err.py
    > /Users/michael/Github/learn-python3/samples/debug/err.py(2)<module>()
    -> s = '0'
```

以参数-m pdb启动后，pdb定位到下一步要执行的代码-> s = '0'。输入命令l来查看代码：

```
    (Pdb) l
    1     # err.py
    2  -> s = '0'
    3     n = int(s)
    4     print(10 / n)
```

输入命令n可以单步执行代码：

```
    (Pdb) n
    > /Users/michael/Github/learn-python3/samples/debug/err.py(3)<module>()
    -> n = int(s)
    (Pdb) n
    > /Users/michael/Github/learn-python3/samples/debug/err.py(4)<module>()
    -> print(10 / n)
```

任何时候都可以输入命令p 变量名来查看变量：

```
    (Pdb) p s
    '0'
    (Pdb) p n
    0
```

输入命令q结束调试，退出程序：

```
    (Pdb) q
```

这种通过pdb在命令行调试的方法理论上是万能的，但实在是太麻烦了，如果有一千行代码，要运行到第999行得敲多少命令啊。还好，我们还有另一种调试方法。

#### pdb.set_trace()

这个方法也是用pdb，但是不需要单步执行，我们只需要import pdb，然后，在可能出错的地方放一个pdb.set_trace()，就可以设置一个断点：

``` python
    # err.py
    import pdb

    s = '0'
    n = int(s)
    pdb.set_trace() # 运行到这里会自动暂停
    print(10 / n)
```

运行代码，程序会自动在pdb.set_trace()暂停并进入pdb调试环境，可以用命令p查看变量，或者用命令c继续运行：

``` python
    $ python3 err.py 
    > /Users/michael/Github/learn-python3/samples/debug/err.py(7)<module>()
    -> print(10 / n)
    (Pdb) p n
    0
    (Pdb) c
    Traceback (most recent call last):
    File "err.py", line 7, in <module>
    print(10 / n)
    ZeroDivisionError: division by zero
```

这个方式比直接启动pdb单步调试效率要高很多，但也高不到哪去。

### with 语句

TBD

### Process, multiprocessing

1. 进程之间的通信可以通过`Queue`, `Pipes` 来实现
2. 进程之间的同步可以通过Pool来实现
TBD

### Next

TBD
