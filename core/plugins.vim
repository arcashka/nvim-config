scriptencoding utf-8

" Plugin specification and lua stuff
lua require('lua-init')

"""""""""""""""""""""""""""""Telescope settings"""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep_args<cr>
nnoremap <leader>fG <cmd>Telescope grep_string<cr>
nnoremap <leader>fl <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

""""""""""""""""""""""""""""""bufferline settings"""""""""""""""""""""""""
nnoremap <space>b :BufferLinePick<CR>
nnoremap <space>B :BufferLinePickClose<CR>
nnoremap <silent> <Tab> :BufferLineCycleNext <CR>
nnoremap <silent> <S-Tab> :BufferLineCyclePrev <CR>

""""""""""""""""""""""""""""""CMake settings""""""""""""""""""""""""""""""
nnoremap <C-b>b :Task start cmake_kits build -j 10<CR>
nnoremap <C-b>B :Task start cmake_kits build_all -j 10<CR>
nnoremap <C-b>c :Task start cmake_kits configure<CR>
nnoremap <C-b>t :Task set_module_param cmake_kits target<CR>
nnoremap <C-b>r :Task start cmake_kits run<CR>
""""""""""""""""""""""""""""""NERDTree settings""""""""""""""""""""""""""""""
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>r :NERDTreeFind<CR>
""""""""""""""""""""""""""""""Trouble settings""""""""""""""""""""""""""""""
nnoremap <leader>t :TroubleToggle<CR>

"""""""""""""""""""""""""""""""""dap settings""""""""""""""""""""""""""""""
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F9> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

"""""""""""""""""""""""""""""""dapui settings""""""""""""""""""""""""""""""
nnoremap <silent> <F2> :lua require'dapui'.toggle()<CR>

"""""""""""""""""""""""""""""""clangd settings"""""""""""""""""""""""""""""
if g:is_mac
  nnoremap <silent> ø :ClangdSwitchSourceHeader<CR>
else
  nnoremap <silent> <A-o> :ClangdSwitchSourceHeader<CR>
endif

