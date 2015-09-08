vimwiki
===

目录： `/autoload/vimwiki/html.vim`
----------
* 函数： `s:delete_html_files`
```
    function! s:delete_html_files(path) "
      " 还是遍历耗时了
      " let ywlhtmlfiles = split(glob(a:path.'**/*.html'), '\n')
      " let htmlfiles = filter(ywlhtmlfiles,'v:val !~ "\\(\\\\\\|\\/\\)vimwiki\\(\\\\\\|\\/\\)Material\\(\\\\\\|\\/\\)"')
    
       let htmlfiles = split(glob(a:path.'**/*.html'), '\n')
      for fname in htmlfiles
        " ignore user html files, e.g. search.html,404.html
        if stridx(g:vimwiki_user_htmls, fnamemodify(fname, ":t")) >= 0
          continue
        endif
    
        " delete if there is no corresponding wiki file
        let subdir = vimwiki#base#subdir(VimwikiGet('path_html'), fname)
        let wikifile = VimwikiGet('path').subdir.
              \fnamemodify(fname, ":t:r").VimwikiGet('ext')
        if filereadable(wikifile)
          continue
        endif
    
        try
          call delete(fname)
        catch
          echomsg 'vimwiki: Cannot delete '.fname
        endtry
      endfor
    endfunction "
```
