" Save key strokes (now we do not need to press shift to enter command mode).
" Vim-sneak has also mapped `;`, so using the below mapping will break the map
" used by vim-sneak
nnoremap ; :
xnoremap ; :

" Quicker way to open command window
nnoremap q; q:

" Turn the word under cursor to upper case
inoremap <c-u> <Esc>viwUea

" Turn the current word into title case
inoremap <c-t> <Esc>b~lea

" Paste non-linewise text above or below current cursor,
" see https://stackoverflow.com/a/1346777/6064933
nnoremap <leader>p m`o<ESC>p``
nnoremap <leader>P m`O<ESC>p``

" Shortcut for faster save and quit
nnoremap <leader>w :<C-U>update<CR>
" Saves the file if modified and quit
nnoremap <silent> <leader>q :<C-U>x<CR>
" Quit all opened buffers
nnoremap <silent> <leader>Q :<C-U>qa!<CR>

" Navigation in the location and quickfix list
nnoremap <silent> [l :<C-U>lprevious<CR>zv
nnoremap <silent> ]l :<C-U>lnext<CR>zv
nnoremap <silent> [L :<C-U>lfirst<CR>zv
nnoremap <silent> ]L :<C-U>llast<CR>zv
nnoremap <silent> [q :<C-U>cprevious<CR>zv
nnoremap <silent> ]q :<C-U>cnext<CR>zv
nnoremap <silent> [Q :<C-U>cfirst<CR>zv
nnoremap <silent> ]Q :<C-U>clast<CR>zv

function! BSkipQuickFix(command)
  let start_buffer = bufnr('%')
  execute a:command
  while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
    execute a:command
  endwhile
endfunction

nnoremap<silent> <Tab> :call BSkipQuickFix("bn")<CR>
nnoremap<silent> <S-Tab> :call BSkipQuickFix("bp")<CR>

" Close all buffers except current one
nnoremap \D : %bd<CR><C-O>:bd#<CR>

" Close location list or quickfix list if they are present,
" see https://superuser.com/q/355325/736190
nnoremap<silent> \x :<C-U>windo lclose <bar> cclose<CR>

" Close a buffer and switching to another buffer, do not close the
" window, see https://stackoverflow.com/q/4465095/6064933
nnoremap <silent> \d :<C-U>call BSkipQuickFix("bprevious") <bar> bdelete #<CR>

" Insert a blank line below or above current line (do not move the cursor),
" see https://stackoverflow.com/a/16136133/6064933
nnoremap <expr> <Space>o printf('m`%so<ESC>``', v:count1)
nnoremap <expr> <Space>O printf('m`%sO<ESC>``', v:count1)

" Insert a space after current character
nnoremap <Space><Space> a<Space><ESC>h

" Move the cursor based on physical lines, not the actual lines.
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

" Do not include white space characters when using $ in visual mode,
" see https://vi.stackexchange.com/q/12607/15292
xnoremap $ g_

" Go to start or end of line easier
nnoremap H ^
xnoremap H ^
nnoremap L g_
xnoremap L g_

" Continuous visual shifting (does not exit Visual mode), `gv` means
" to reselect previous visual area, see https://superuser.com/q/310417/736190
xnoremap < <gv
xnoremap > >gv

" When completion menu is shown, use <cr> to select an item and do not add an
" annoying newline. Otherwise, <enter> is what it is. For more info , see
" https://superuser.com/a/941082/736190 and
" https://unix.stackexchange.com/q/162528/221410
" inoremap <expr> <cr> ((pumvisible())?("\<C-Y>"):("\<cr>"))
" Use <esc> to close auto-completion menu
" inoremap <expr> <esc> ((pumvisible())?("\<C-e>"):("\<esc>"))

" Tab-complete, see https://vi.stackexchange.com/q/19675/15292.
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Edit and reload init.vim quickly
nnoremap <silent> <leader>ev :<C-U>tabnew $MYVIMRC <bar> tcd %:h<cr>
nnoremap <silent> <leader>sv :<C-U>silent update $MYVIMRC <bar> source $MYVIMRC <bar>
      \ call v:lua.vim.notify("Nvim config successfully reloaded!", 'info', {'title': 'nvim-config'})<cr>

" Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
nnoremap <expr> <leader>v printf('`[%s`]', getregtype()[0])

" Search in selected region
xnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

" Find and replace (like Sublime Text 3)
nnoremap <C-H> :%s/
xnoremap <C-H> :s/

" Change current working directory locally and print cwd after that,
" see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
nnoremap <silent> <leader>cd :<C-U>lcd %:p:h<CR>:pwd<CR>

" Use Esc to quit builtin terminal
tnoremap <ESC>   <C-\><C-n>

" Toggle spell checking (autosave does not play well with z=, so we disable it
" when we are doing spell checking)
nnoremap <silent> <F11> :<C-U>set spell!<cr>
inoremap <silent> <F11> <C-O>:<C-U>set spell!<cr>

" Change text without putting it into the vim register,
" see https://stackoverflow.com/q/54255/6064933
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc
xnoremap c "_c

" Remove trailing whitespace characters
nnoremap <silent> <leader><Space> :<C-U>StripTrailingWhitespace<CR>

" check the syntax group of current cursor position
nnoremap <silent> <leader>st :<C-U>call utils#SynGroup()<CR>

" Clear highlighting
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Copy entire buffer.
nnoremap <silent> <leader>y :<C-U>%y<CR>

" Toggle cursor column
nnoremap <silent> <leader>cl :<C-U>call utils#ToggleCursorCol()<CR>

" Move current line up and down
if g:is_mac
  nnoremap <silent> ˚ <Cmd>call utils#SwitchLine(line('.'), 'up')<CR>
  nnoremap <silent> ∆ <Cmd>call utils#SwitchLine(line('.'), 'down')<CR>
else
  nnoremap <silent> <A-k> <Cmd>call utils#SwitchLine(line('.'), 'up')<CR>
  nnoremap <silent> <A-j> <Cmd>call utils#SwitchLine(line('.'), 'down')<CR>
endif

" Move current visual-line selection up and down
if g:is_mac
  xnoremap <silent> ˚ :<C-U>call utils#MoveSelection('up')<CR>
  xnoremap <silent> ∆ :<C-U>call utils#MoveSelection('down')<CR>
else
  xnoremap <silent> <A-k> :<C-U>call utils#MoveSelection('up')<CR>
  xnoremap <silent> <A-j> :<C-U>call utils#MoveSelection('down')<CR>
endif

" Replace visual selection with text in register, but not contaminate the
" register, see also https://stackoverflow.com/q/10723700/6064933.
xnoremap p "_c<ESC>p

nnoremap <Left> <C-W>h
nnoremap <Right> <C-W>l
nnoremap <Up> <C-W>k
nnoremap <Down> <C-W>j

" Text objects for URL
xnoremap <silent> iu :<C-U>call text_obj#URL()<CR>
onoremap <silent> iu :<C-U>call text_obj#URL()<CR>

" Text objects for entire buffer
xnoremap <silent> iB :<C-U>call text_obj#Buffer()<CR>
onoremap <silent> iB :<C-U>call text_obj#Buffer()<CR>

" Do not move my cursor when joining lines.
nnoremap J mzJ`z

" Break inserted text into smaller undo units.
for ch in [',', '.', '!', '?', ';', ':']
  execute printf('inoremap %s %s<C-g>u', ch, ch)
endfor

" insert semicolon in the end
if g:is_mac
  inoremap … <ESC>miA;<ESC>`ii
else
  inoremap <A-;> <ESC>miA;<ESC>`ii
endif

if g:is_mac
  nnoremap Ï :py3f /Users/nikita/.conan/data/clang/13.0/movavi/stable/package/cc471ed355602ffa7007968c83aa4e7e648a38b5/clang-13.0/share/clang/clang-format.py<CR>
  xnoremap Ï :py3f /Users/nikita/.conan/data/clang/13.0/movavi/stable/package/cc471ed355602ffa7007968c83aa4e7e648a38b5/clang-13.0/share/clang/clang-format.py<CR>
  nnoremap ƒ :%py3f /Users/nikita/.conan/data/clang/13.0/movavi/stable/package/cc471ed355602ffa7007968c83aa4e7e648a38b5/clang-13.0/share/clang/clang-format.py<CR>
  xnoremap ƒ :%py3f /Users/nikita/.conan/data/clang/13.0/movavi/stable/package/cc471ed355602ffa7007968c83aa4e7e648a38b5/clang-13.0/share/clang/clang-format.py<CR>
elseif g:is_linux
  nnoremap <A-F> :py3f /usr/share/clang/clang-format.py<CR>
  xnoremap <A-F> :py3f /usr/share/clang/clang-format.py<CR>
  nnoremap <A-f> :%py3f /usr/share/clang/clang-format.py<CR>
  xnoremap <A-f> :%py3f /usr/share/clang/clang-format.py<CR>
elseif g:is_win
  let g:clang_format_path = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\Llvm\\x64\\bin\\clang-format.exe"
  nnoremap <A-F> :py3f C:\\Users\\arcashka\\.conan\\data\\clang\\12.0.0\\movavi\\stable\\package\\3475bd55b91ae904ac96fde0f106a136ab951a5e\\share\\clang\\clang-format.py<CR>
  xnoremap <A-F> :py3f C:\\Users\\arcashka\\.conan\\data\\clang\\12.0.0\\movavi\\stable\\package\\3475bd55b91ae904ac96fde0f106a136ab951a5e\\share\\clang\\clang-format.py<CR>
  nnoremap <A-f> :%py3f C:\\Users\\arcashka\\.conan\\data\\clang\\12.0.0\\movavi\\stable\\package\\3475bd55b91ae904ac96fde0f106a136ab951a5e\\share\\clang\\clang-format.py<CR>
  xnoremap <A-f> :%py3f C:\\Users\\arcashka\\.conan\\data\\clang\\12.0.0\\movavi\\stable\\package\\3475bd55b91ae904ac96fde0f106a136ab951a5e\\share\\clang\\clang-format.py<CR>
endif

" Keep cursor position after yanking
nnoremap y myy
xnoremap y myy

augroup restore_after_yank
  autocmd!
  autocmd TextYankPost *  call s:restore_cursor()
augroup END

function! s:restore_cursor() abort
  silent! normal `y
  silent! delmarks y
endfunction
