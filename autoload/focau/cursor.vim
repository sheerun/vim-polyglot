function! focau#cursor#auto_shape()
  if $TERM =~? '\v^%(dumb|linux)'
    " echom "Shape escape codes: can't autodetect for $TERM=" . $TERM
    return ['', '', '']
  elseif $TERM =~? '^konsole' || exists('$ITERM_PROFILE')
    return ["\e]50;CursorShape=0\x7", "\e]50;CursorShape=1\x7", "\e]50;CursorShape=2\x7"]
  endif

  "" DISABLED: to reduce startup time, and it will not work through ssh
  " let uver = eval(substitute(system('urxvt -h 2>&1'),
  "       \ '\v.*v(\d+)\.(\d+).*', '\1+\2.0/100', ''))
  " return ["\e[2 q", (l:uver<9.21? "\e[4 q": "\e[6 q"), "\e[4 q"]
  " let l:uver = substitute(split(system('urxvt -help 2>&1'), '\n')[0],
  "       \ '.*v\([0-9.]\+\).*', '\1', '')
  " return ["\e[2 q", (9.21 <= l:uver ? "\e[6 q" : "\e[4 q")]

  " [1,2] -> [blinking,solid] block
  " [3,4] -> [blinking,solid] underscore
  " [5,6] -> [blinking,solid] vbar/I-beam (only in xterm > 282),
  "     urxvt got I-beam only in v9.21 2014-12-31, build from recent git.

  " if $TERM =~? '\v^%(xterm|rxvt|st|screen|tmux|nvim)'
  " NOTE:(old xterm) ["\e[2 q", "\e[6 q", '']
  return ["\e[2 q", "\e[6 q", "\e[4 q"]
endfunction


function! focau#cursor#auto_color(idx)
  " SEE: http://stackoverflow.com/questions/11494029/how-do-i-change-the-color-of-current-cursor-position-indicator
  if !g:focau.auto
    let colors = g:focau.colors
  elseif $TERM =~? '\v^%(xterm|st|screen|tmux|rxvt)'
    "" ALT: ["\e]12;white\x9c", "\e]12;orange\x9c"]
    " use default \003]12;gray\007 for gnome-terminal
    let colors = [ "\e]12;". g:focau.colors[0] ."\x7",
                 \ "\e]12;". g:focau.colors[1] ."\x7" ]
  else
    " echom "Err: can't detect esc codes for cursor colors in $TERM=".$TERM
    let colors = ['', '']
  endif
  return l:colors[a:idx]
endfunction


function! focau#cursor#shape_preserve()
  "" Preserve previous cursor state and restore upon exit
  let s:old_SI=&t_SI | let s:old_EI=&t_EI | if exists('&t_SR')
      \| let s:old_RS=&t_SR | endif
  " BUG: has no effect on restoring color after exit.
  "" There are sequence to change color, but not the one to restore to default
  " SEE Maybe save/restore the screen -- works for cursor? -- seems NO.
  au focau VimLeave * let &t_SI = s:old_SI | let &t_EI = s:old_EI
      \| if exists('&t_SR') | let &t_SR = s:old_RS | endif
endfunction

