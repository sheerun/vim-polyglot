let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'autoload/zig/config.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'zig') == -1

function! zig#config#ListTypeCommands() abort
  return get(g:, 'zig_list_type_commands', {})
endfunction

function! zig#config#ListType() abort
  return get(g:, 'zig_list_type', '')
endfunction

function! zig#config#ListAutoclose() abort
  return get(g:, 'zig_list_autoclose', 1)
endfunction

function! zig#config#ListHeight() abort
  return get(g:, "zig_list_height", 0)
endfunction

function! zig#config#FmtAutosave() abort
  return get(g:, "zig_fmt_autosave", 0)
endfunction

function! zig#config#SetFmtAutosave(value) abort
  let g:zig_fmt_autosave = a:value
endfunction

function! zig#config#FmtCommand() abort
  return get(g:, "zig_fmt_command", ['zig', 'fmt', '--color', 'off'])
endfunction

function! zig#config#FmtFailSilently() abort
  return get(g:, "zig_fmt_fail_silently", 0)
endfunction

function! zig#config#FmtExperimental() abort
  return get(g:, "zig_fmt_experimental", 0)
endfunction

function! zig#config#Debug() abort
  return get(g:, 'zig_debug', [])
endfunction

endif
