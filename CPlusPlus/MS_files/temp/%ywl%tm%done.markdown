```
    # alias 别名 
    # 这样调整后，可以让ls,grep,dir输出彩色显示
    # 另外加上命令的-h选项，这样文件大小以K,M,G显示，方便阅读。
    alias df='df -h'
    alias du='du -h'
     
    alias whence='type -a'                        # where, of a sort
    alias grep='grep --color'                     # show differences in colour
    alias egrep='egrep --color=auto'              # show differences in colour
    alias fgrep='fgrep --color=auto'              # show differences in colour
     
    alias ls='ls -h --color=tty'                 # classify files in colour
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
    alias ll='ls -l'                              # long list
    alias la='ls -A'                              # all but . and ..
    alias l='ls -CF'                              #
    alias wch='which -a'
```
