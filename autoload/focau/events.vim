"" WARNING: For focus-events to work in tmux, you need to set this option
" inside your tmux.conf:   set -g focus-events on
" WARNING: must be outside this 'if' in s:focau_modes_enable, as it will not
" work in tmux on_disable!

if exists('$TMUX') || $TERM =~? 'screen\|tmux'  " FIXED for [tmux -> ssh | vim]
  " Disable bkgd color erase and don't truncate highlighting
  " So highlighted line does go all the way across screen
  set t_ut=
  function! s:wrap(s)
    return "\ePtmux;". substitute(escape(a:s, ' '),
          \ "\e\\|\<Esc>", "\e\e", 'g') ."\e\\"
  endfunction
else
  function! s:wrap(s)
    return escape(a:s, ' ')
  endfunction
endif


function! focau#events#auto_choose()
  " if $TERM =~? '\v^%(dumb|linux)'
  " echom "Err: your terminal don't support focus events $TERM=" . $TERM
  " echom "Err: Can't auto-derive termfocus codes for your $TERM=" . $TERM
  " echom "Disabled. If you disagree, set escape codes by yourself:)"
  if $TERM =~? '^rxvt'
    return ["\e]777;focus;on\x7", "\e]777;focus;off\x7"]
  endif
  " if $TERM =~? '\v^%(xterm|st|screen|tmux)' || exists('$ITERM_PROFILE')
  return ["\e[?1004h", "\e[?1004l"]
endfunction


" ALT:
" augroup focau_focus
"   autocmd!
"   if a:state
"     au VimEnter    * call s:focau_cso('on')
"     au VimLeavePre * call s:focau_cso('off')
"   endif
" augroup END
function! focau#events#enable(state)
  let g:focau.active = a:state
  if !g:focau.active | let &t_ti = '' | let &t_te = '' | return | endif
  " CHECK: Is it necessary to be able toggle dynamically?
  " exec 'silent !echo -ne "'. g:focau.focuses[1] .g:focau.screens[1] .'"'

  "" FIX: add two color groups based on language, not permanent. See xkb.
  let color = focau#cursor#auto_color(0)
  let codes = ['t_EI', 't_SI', 't_SR']
  " Install insert mode autohooks -- on enter/leave
  for i in range(3)| if exists('&'.codes[i])
    exe 'set '.codes[i].'='.s:wrap(g:focau.cursors[i] . l:color)
  endif | endfor

  let on_init = &t_EI . s:wrap(g:focau.focuses[0]) . g:focau.screens[0]
  let on_exit = s:wrap(g:focau.focuses[1]) . g:focau.screens[1]

  " Install focus autohooks -- on startup/shutdown
  let &t_ti = on_init | let &t_te = on_exit

  " CHECK: Is it necessary to be able toggle dynamically?
  " exec 'silent !echo -ne "'.&t_EI.g:focau.focuses[0].g:focau.screens[0].'"'
endfunction
