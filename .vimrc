let mapleader = "\<Space>"  "设置leader键
filetype on 				"侦测文件类型
set number 					"展示行号
set ts=4 					"缩进大小
set shiftwidth=4 			"缩进大小
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 	"为了解决从windows传过来的文件的中文乱码问题
set clipboard+=unnamed 		"支持系统剪贴板
set ignorecase 				"搜索不区分大小写
set noshowmode 				"不在底部展示mode信息（因为lightline已经展示了）
set autoread                " 当文件在外部被修改时自动更新该文件
set nowrapscan              " 搜索到文件两端时不重新搜索
set nocompatible            " 关闭兼容模式
set showmatch 				"光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
"光标移动配置
inoremap <silent> <C-a> <Esc>I
inoremap <C-e> <End>
inoremap <C-k> <Esc><Right>C
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
nnoremap <leader>v V$%
nnoremap <leader>ca viw~e
nnoremap <leader>p viwp
nnoremap <leader>e :<C-u>Files<CR>

"macVim特殊设置开始
if has("gui_running")
	"设置macvim的字体
	set guifont=Monaco:h14
	:colorscheme adventurous "设置主题
endif
"插件配置
call plug#begin('~/.vim/plugged')
Plug 'easymotion/vim-easymotion'
Plug '/usr/local/opt/fzf' 
Plug 'junegunn/fzf.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
call plug#end()

"实时搜索预览插件配置
set laststatus=2
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"Omni menu colors,设置terminal中下拉菜单的配色
hi Pmenu guibg=#444444
hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff

"设置文件语法格式
nnoremap <leader>o :Filetypes<CR>

"下面是coc配置
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

"设置移步任务轮询时间
set updatetime=300

"lightline配置
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status'
\ },
\ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Do default action for next item.
nnoremap <silent> <D-]>  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <D-[>  :<C-u>CocPrev<CR>
"cocList
nnoremap <silent> <C-l>  :<C-u>CocList<CR>
