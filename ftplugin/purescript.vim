if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'purescript') == -1

setlocal comments=s1fl:{-,mb:\ \ ,ex:-},:--\ \|,:--
setlocal include=^import
setlocal includeexpr=printf('%s.purs',substitute(v:fname,'\\.','/','g'))

let s:PS = []
fun! InitPureScript()
  let dirs = map(
	\ findfile("psc-package.json", expand("%:p:h") . ";/", -1),
	\ { idx, val -> fnamemodify(val, ":p:h") }
	\ )
  if empty(dirs)
    let dirs = map(
	  \ findfile("bower.json", expand("%:p:h") . ";/", -1),
	  \ { idx, val -> fnamemodify(val, ":p:h") }
	  \ )
    if empty(dirs)
      return
    endif
  endif

  let path = expand("%:p")
  for p in s:PS
    if stridx(path, p[0], 0) == 0
      let &l:path=p[1]
      return
    endif
  endfor

  let dir = dirs[len(dirs) - 1]
  let gp = globpath(dir, "src/**/*.purs", v:true, v:true)
  if empty(gp)
    return
  endif

  let &l:path=join([dir, dir . "/bower_components/**", dir . "/src/**"], ",")
  call add(s:PS, [dir, &l:path])
endfun
call InitPureScript()

endif
