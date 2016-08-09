要在写入一个 *.html 文件时插入当前日期和时间: >
## [Autocmd][template].md
```bash
  :autocmd BufWritePre,FileWritePre *.html   ms|call LastMod()|'s
  :fun LastMod()
  :  if line("$") > 20
  :    let l = 20
  :  else
  :    let l = line("$")
  :  endif
  :  exe "1," . l . "g/Last modified: /s/Last modified: .*/Last modified: " .
  :  \ strftime("%Y %b %d")
  :endfun
```
要这段代码工作，你需要在文件开始的 20 行里有这行 "Last modified: <date
time>"。 Vim 把 <date time> (包括该行其后的任何内容) 替换为当前的日期和时间。
解释:
```
ms        保存当前位置到 's' 标记
call LastMod()  调用 LastMod() 函数完成工作
`s        光标回到旧的位置
```
LastMode() 函数先检查文件是否少于 20 行，然后用 ":g" 命令查找包含 "Last
Modified:" 的行。在这些行上执行 ":s" 命令实现从已有的时间到当前时间的替换。
":execute" 命令使 ":g" 和 ":s" 命令可以使用表达式。日期用 strftime() 函数取
得。它可以用别的参数取得不同格式的日期字符串。
