if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
" Unzip Module <https://github.com/youzee/nginx-unzip-module>
" Enabling fetching of files that are stored in zipped archives.
syn keyword ngxDirectiveThirdParty file_in_unzip_archivefile
syn keyword ngxDirectiveThirdParty file_in_unzip_extract
syn keyword ngxDirectiveThirdParty file_in_unzip


endif
