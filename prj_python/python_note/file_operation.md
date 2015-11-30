## [python][file]文件的读写基本操作
[python|file|open|write]

## File Open() & Write() & read()
```
with open('./file_example.txt','a') as f :
    f.write("hello world!\r")
with open('./file_example.txt','r') as f :
    print(f.read())
```
### open(), 获取一个文件对象；  
  打开了文件之后，处理完我们需要的操作之后，最后一部是调用f.close()来关闭文件
  如果文件不存在，将抛出 IOError 的异常，此时可能不会调用 f.close()来释放资源
  可以使用 try...finally来保证，或者是with...as 语句来自动调用

```
try:
    f = open('./file_example.txt', 'r')
    print(f.read())
finally:
    if f:
        f.close()
```
或者是

```
with open('./file_example.txt','r') as f :
    print (f.read())
```

* 'r' open for reading (default)
* 'w' open for writing, truncating the file first
* 'x' open for exclusive creation, failing if the file already exists
* 'a' open for writing, appending to the end of the file if it exists
* 'b' binary mode
* 't' text mode (default)
* '+' open a disk file for updating (reading and writing)
* 'U' universal newlines mode (deprecated)


### f.write()方法写入文件  

可以反复调用write()来写入文件，但是务必要调用f.close()来关闭文件。

当我们写文件时，操作系统往往不会立刻把数据写入磁盘，而是放到内存缓存起来，空闲的时候再慢慢写入。只有调用close()方法时，操作系统才保证把没有写入的数据全部写入磁盘。忘记调用close()的后果是数据可能只写了一部分到磁盘，剩下的丢失了。

所以，还是用with语句来得保险：

```
with open('./file_example.txt','w') as f :
    f.write("hello world!")
```

### f.read()方法

* f.read()可以一次性读取文件的内容
* f.read(size) 方法，每次最多读取 size 个字节的内容
* f.readline() : 如果是配置文件，使用 f.readline()会更加方便.

```
for line in f.readline():
    print(line.strip()) # 去掉末尾的 '\n'
```




