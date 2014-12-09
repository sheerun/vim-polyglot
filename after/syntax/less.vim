" Language:     Colorful CSS Color Preview
" Author:       Aristotle Pagaltzis <pagaltzis@gmx.de>

if !( has('gui_running') || &t_Co==256 ) | finish | endif

" variable               | property       | multiline      | end-of-line | plugin
" -----------------------+----------------+----------------+-------------+---------
"                lessCssAttribute         | lessCssComment | lessComment | https://github.com/genoma/vim-less
"                 lessAttribute           | lessCssComment | lessComment | https://github.com/KohPoll/vim-less
" lessVariableValue      | lessDefinition | cssComment     | lessComment | https://github.com/groenewege/vim-less
" lessVariableDefinition | cssDefinition  | cssComment     | lessComment | https://github.com/lunaru/vim-less

call css_color#init('css', 'lessVariableValue,lessVariableDefinition,lessDefinition,lessCssAttribute,lessAttribute,cssDefinition,cssComment,lessCssComment,lessComment')
