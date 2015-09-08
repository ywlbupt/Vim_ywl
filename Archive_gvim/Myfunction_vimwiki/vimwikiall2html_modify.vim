function! Myfunction_vimwiki()
	"glob获取文件列表，split将文件列表变换为字典。
	"vimwiki的delete html配置文件在vimfiles文件里的autoload的html.vim里面。
	"将Archive文件夹里面的Myfunction_vimwiki文件夹重命名拷贝至E:\tmp，
	"可看到作用。
	"此函数未完成，仅供参考。
	let a:ypath='E:\tmp\'
	"let a:txtfilea=split(glob('E:\tmp\'.'**1/*.txt'),'\n')
	let a:txtfilea=split(glob(a:ypath.'**'),'\n')
	"let a:txtfilea=split(glob(a:ypath.'**/*.txt'),'\n')
	let a:txtfileb=split(glob(a:ypath.'*'),'\n')
	echo a:txtfilea
	echo a:txtfileb
	let a:txtfilec=filter(a:txtfileb,'v:val !~ "\\(\\\\\\|\\/\\)tmp\\(\\\\\\|\\/\\)abc$"')
	"let a:txtfileb=glob('E:\tmp\'.'abc/**/*.txt')
	echo a:txtfilec
	"echo filter( a:txtfilea,'v:val !~ "\\(\\\\\\|\\/\\)tmp\\(\\\\\\|\\/\\)abc\\(\\\\\\|\\/\\)"')
endfunction
