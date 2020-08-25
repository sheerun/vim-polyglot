function! TestExtension(filetype, filename, content)
  try
    exec "e " . a:filename
    exec "if &filetype != '" . a:filetype . "' \nthrow &filetype\nendif"
  catch
    echo 'Filename "' . a:filename  . '" does not resolve to extension "' . a:filetype . '"'
    echo '  instead received: "' . v:exception . '"'
    exec ':cq!'
  endtry
endfunction

call TestExtension('blade', 'test.blade.php', '')
call TestExtension('yaml.ansible', 'playbook.yml', '')
call TestExtension('yaml.ansible', 'host_vars/foobar', '')
call TestExtension('yaml.ansible', 'handlers.foo.yaml', '')
call TestExtension('yaml.ansible', 'requirements.yaml', '')
