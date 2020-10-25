" Restore 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

let s:disabled_packages = {}
let s:new_polyglot_disabled = []

if exists('g:polyglot_disabled')
  for pkg in g:polyglot_disabled
    let base = split(pkg, '\.')
    if len(base) > 0
      let s:disabled_packages[pkg] = 1
      call add(s:new_polyglot_disabled, base[0]) 
    endif
  endfor
else
  let g:polyglot_disabled_not_set = 1
endif


let s:base = expand('<sfile>:p:h:h:h')

func polyglot#util#Filter(idx, val)
  let val = fnamemodify(a:val . '/', ':p:h')
  return resolve(val) !=? s:base && stridx(val, $VIMRUNTIME) == -1 && val !~? '/after$'
endfunc

let s:rtp = join(filter(split(&rtp, ','), function('polyglot#util#Filter')), ',')

func polyglot#util#IsEnabled(type, file)
  if a:file != "ftdetect"
    let file = a:file[len(s:base) + 1:]
    let files = globpath(s:rtp, file, 1, 1)
    if !empty(files)
      exec 'source' files[0]
      return 0
    endif
  endif
  if a:type == "jsx"
    return !has_key(s:disabled_packages, "jsx") && !has_key(s:disabled_packages, "javascript")
  endif
  return !has_key(s:disabled_packages, a:type)
endfunc

func! polyglot#util#Verify()
  if exists("g:polyglot_disabled_not_set")
    if exists("g:polyglot_disabled")
      echohl WarningMsg
      echo "vim-polyglot: g:polyglot_disabled should be defined before loading vim-polyglot"
      echohl None
    endif

    unlet g:polyglot_disabled_not_set
  endif
endfunc

" Save polyglot_disabled without postfixes
if exists('g:polyglot_disabled')
  let g:polyglot_disabled = s:new_polyglot_disabled
endif

" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
