set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" Turn off syntax highlighting for large YAML files.
if line('$') > 500
  setlocal syntax=OFF
endif
