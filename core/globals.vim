let g:is_win = (has('win32') || has('win64')) ? v:true : v:false
let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false

let g:logging_level = 'info'
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0

let g:did_install_default_menus = 1  " do not load menu

if executable('python3')
  let g:python3_host_prog=exepath('python3')
else
  echoerr 'Python 3 executable not found! You must install Python 3 and set its PATH correctly!'
endif

let g:mapleader = ','
language en_US.utf-8
