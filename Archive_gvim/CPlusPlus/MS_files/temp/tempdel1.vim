let b:winpath2param_vim=substitute(g:vim_path_win, '\\', '\\\\', 'g')
echo substitute(v:this_session,'\..\{-}$','','')
E:\yanweilin\Dropbox\Workspace\Prj_vimrc.session
/home/yanweilin/Dropbox/Workspace/Prj_vimrc.session
let b:ywl='/home/yanweilin/Dropbox/Workspace/Prj_vimrc.session'
let b:ywl_1='E:\yanweilin\Dropbox\Workspace\Prj_vimrc.session'
let b:ywl_2='E:\yanweilin\Dropbox\Workspace\Prj_vimrc.session'
let b:ywl_3='/usr/share/vim/Workspace/Prj_vimrc.session'
let b:ywl_4='<$VIM> C:\Program Files\Vim\vim73'

" for windows
echo substitute(v:this_session,'.\{}\\\(.*\)\..\{-}$','\1','')
" for linux
echo substitute(b:ywl,'.\{}/\(.*\)\..\{-}$','\1','')
" for both system
echo substitute(b:ywl,'.\{}[/\|\\]\(.*\)\..\{-}$','\1','')
echo substitute(substitute(b:ywl_4, b:winpath2param_vim, g:vim_path_ubuntu,'g'), '\\', '/', 'g')

let b:urly='ttsa/adgasd.html'
echo substitute(b:urly,'\(\.html\|\.mkd\)$','','g')
echo substitute(b:urly,'.html.mkd$','.mkd','g')

" 中文 测试
exec '!mv '.g:vimwiki_list[0].path.'public\pdf\'.@+.'.pdf '.g:vimwiki_list[0].path.'public\pdf\test.pdf'

rename(g:vimwiki_list[0].path.'public\pdf\'.@+.'.pdf', g:vimwiki_list[0].path.'public\pdf\test.pdf')
