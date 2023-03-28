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

""""""""""""""""""""""""""""vim-xkbswitch settings"""""""""""""""""""""""""
let g:XkbSwitchEnabled = 1

""""""""""""""""""""""""""""vim-startify settings""""""""""""""""""""""""""""
" Do not change working directory when opening files.
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1

""""""""""""""""""""""""""""""wilder.nvim settings""""""""""""""""""""""""""""""
augroup wilder_init
  autocmd!
  " CursorHold is suggested here: https://github.com/gelguy/wilder.nvim/issues/89#issuecomment-934465957.
  autocmd CursorHold * ++once call s:wilder_init()
augroup END

function! s:wilder_init() abort
  try
    call wilder#setup({
          \ 'modes': [':', '/', '?'],
          \ })

    call wilder#set_option('pipeline', [
          \   wilder#branch(
          \     wilder#cmdline_pipeline({
          \       'language': 'python',
          \       'fuzzy': 1,
          \       'sorter': wilder#python_difflib_sorter(),
          \       'debounce': 30,
          \     }),
          \     wilder#python_search_pipeline({
          \       'pattern': wilder#python_fuzzy_pattern(),
          \       'sorter': wilder#python_difflib_sorter(),
          \       'engine': 're',
          \       'debounce': 30,
          \     }),
          \   ),
          \ ])

    let l:hl = wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}])
    call wilder#set_option('renderer', wilder#popupmenu_renderer({
          \ 'highlighter': wilder#basic_highlighter(),
          \ 'max_height': 15,
          \ 'highlights': {
          \   'accent': l:hl,
          \ },
          \ 'left': [' ', wilder#popupmenu_devicons(),],
          \ 'right': [' ', wilder#popupmenu_scrollbar(),],
          \ 'apply_incsearch_fix': 0,
          \ }))
  catch /^Vim\%((\a\+)\)\=:E117/
    echohl Error |echomsg "Wilder.nvim missing: run :PackerSync to fix."|echohl None
  endtry
endfunction
""""""""""""""""""""""""""""""bufferline settings"""""""""""""""""""""""""
nnoremap <space>b :BufferLinePick<CR>
nnoremap <space>B :BufferLinePickClose<CR>

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

