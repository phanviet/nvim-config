lua << EOF
require 'boot'
EOF

call plug#begin('~/.local/share/nvim/plugged')

lua << EOF
require('modules').install()
EOF

call plug#end()

" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" if exists('$TMUX')
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
" else
"   let &t_SI = "\e[5 q"
"   let &t_EI = "\e[2 q"
" endif

" Change cursor shape on different mode
if empty($TMUX)
  " Vertical bar in insert mode
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  " Block in normal mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  " Underline in replace mode
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  " Vertical bar in insert mode
  let &t_SI = "\e[5 q"
  " Block in normal mode
  let &t_SR = "\e[4 q"
  " Underline in replace mode
  let &t_EI = "\e[1 q"
endif

function! SynStack()
  if !exists('*synstack')
    " return
  endif
  echo map(synstack(line('.'), col('.')), "synIDattr(v:val, 'name')")
endfunc

" Example mapping:
nmap <leader>x :call SynStack()<CR>

map <leader>sp :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" Js beautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

au BufRead,BufNewFile *.yml set ft=cloudformation.yaml
au BufNewFile,BufRead *.vtl set ft=velocity

lua << EOF
require('modules').init()
EOF

