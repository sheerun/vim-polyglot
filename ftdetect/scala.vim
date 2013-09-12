fun! s:DetectScala()
    if getline(1) == '#!/usr/bin/env scala'
        set filetype=scala
    endif
endfun

au BufRead,BufNewFile *.scala,*.sbt set filetype=scala
au BufRead,BufNewFile * call s:DetectScala()
