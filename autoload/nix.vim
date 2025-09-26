if polyglot#init#is_disabled(expand('<sfile>:p'), 'nix', 'autoload/nix.vim')
  finish
endif

function! nix#find_drv_position()
  let line = search("description")
  if line == 0
    let line = search("name")
  endif
  if line == 0
    echo "error: could not find derivation"
    return
  endif

  return expand("%") . ":" . line
endfunction

function! nix#edit(attr)
  let output = system("nix-instantiate --eval ./. -A " . a:attr . ".meta.position")
  if match(output, "^error:") == -1
    let position = split(split(output, '"')[0], ":")
    execute "edit " . position[0]
    execute position[1]
    " Update default command to nix-build.
    let b:dispatch = 'nix-build --no-out-link -A ' . a:attr
  endif
endfunction
