[powerline-font-github]: https://github.com/powerline/fonts

## 【vim-airline】
参考-vim powerline状态乱码修复
```
sudo apt-get install python-fontforge
sudo ~/.vim/bundle/vim-powerline/fontpatcher/fontpatcher ~/Desktop/UbuntuMono-R.ttf
mkdir ~/.fonts
fc-cache -vf ~/.fonts
```

* [Shell-Powerline](https://github.com/banga/powerline-shell)
* [offical-docs-powershell](https://powerline.readthedocs.io/en/master/installation.html#patched-fonts)
## vim-airline
ubuntu下，从[powerline-font-github]下载字体并安装`./install.sh`，Run `./install.sh` to install all Powerline Fonts

`_vimrc`配置文件中`Vundle.vim`安装，添加下面语句:
```
Plugin 'vim-airline/vim-airline' 
Plugin 'vim-airline/vim-airline-themes'
```

### Ubuntu 14.04 下Powerline的安装
参考链接:[Install Powerline Vim Editor Plugin on Ubuntu 15.04 & Ubuntu 14.04](http://sourcedigit.com/17395-install-powerline-vim-editor-plugin-on-ubuntu-15-04-ubuntu-14-04/)

依赖环境：
* python安装了pip工具
* git

安装步骤：
1. `sudo pip install git+git://github.com/Lokaltog/powerline`
2. Install Powerline Fonts in Linux
    * 下载powerline字体
        ```
        sudo wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
        sudo wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
        ```
    * Run the following command to move the symbol font to a valid X font path. Valid font paths can be listed with `xset q`:
      ```
      sudo mv PowerlineSymbols.otf /usr/share/fonts/
      ```
    * Update font cache for the path the font:
      ```
      sudo fc-cache -vf /usr/share/fonts/
      ```
    * Install the fontconfig file. For newer versions of fontconfig the config path is ~/.config/fontconfig/conf.d/, for older versions it’s ~/.fonts.conf.d/:
      ```
      sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
      ```

Once everything seems fine, it’s time to set Powerline fo Vim Statuslines. Here’s how to configure Powerline for Vim Text Editor.
The first thing you must do is to enable 256color support on Terminal. Add the following line of code to ~/.bashrc file.
```
export TERM=”screen-256color”
```

#### Ubuntu下fonts路径：
1. 个人用户字体文件在~/.local/share/fonts
2. 系统字体文件在/usr/share/fonts
3. 字体配置文件在/etc/fonts/
