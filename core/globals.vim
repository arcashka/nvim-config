let g:is_win = (has('win32') || has('win64')) ? v:true : v:false
let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false

let g:logging_level = 'info'
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0

let g:did_install_default_menus = 1  " do not load menu

if executable('python')
  let g:python3_host_prog=exepath('python')
else
  echoerr 'Python 3 executable not found! You must install Python 3 and set its PATH correctly!'
endif

let g:mapleader = ','
let g:vimsyn_embed = 'l'
language en_US.utf-8
let g:netrw_liststyle = 3
let g:loaded_2html_plugin = 1
let g:loaded_zipPlugin = 1
let loaded_gzip = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1  " do not load the tutor plugin
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
