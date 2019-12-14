let mapleader = "\<Space>"  "设置leader键
filetype on 				"侦测文件类型
filetype plugin on 			"载入文件类型插件
filetype indent on 			"开启文件类型检查，并且载入与该类型对应的缩进规则。比如，如果编辑的是.py文件，Vim 就是会找 Python 的缩进规则~/.vim/indent/python.vim
set number 					"展示行号
set ts=4 					"缩进大小
set shiftwidth=4 			"缩进大小
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 	"为了解决从windows传过来的文件的中文乱码问题
set clipboard+=unnamed 		"支持系统剪贴板
set ignorecase 				"搜索不区分大小写
set noshowmode 				"不在底部展示mode信息（因为lightline已经展示了）
"set foldcolumn=4 			"设置foldcolum的宽度，越宽，展示的foldColumn的层级越多
set autoread                " 当文件在外部被修改时自动更新该文件
set nobackup                " 不生成备份文件
set noswapfile              " 不生成交换文件
set nowrapscan              " 搜索到文件两端时不重新搜索
set nocompatible            " 关闭兼容模式
set hidden                  " 允许在有未保存的修改时切换缓冲区
set showmatch 				"光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set undofile 				"Vim 会在编辑时保存操作历史，用来供用户撤消更改。默认情况下，操作记录只在本次编辑时有效，一旦编辑结束、文件关闭，操作历史就消失了，而这个配置会将其保留
set autoread 				"打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示
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
Plug 'scrooloose/nerdtree'
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

"nerdtree配置
"当打开单文件时关闭nerdTrdd窗口，打开文件夹时打开nerdTree窗口
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"格式化
nnoremap <silent><leader>l :call CocAction('format')<CR>

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

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <C-i> <Plug>(coc-diagnostic-prev)
nnoremap <silent> <C-o> <Plug>(coc-diagnostic-next)
" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

"!指的是强制覆盖同名的命令,-nargs指的是参数的个数，默认不写的话代表没有参数，ex模式下要同时执行多条命令需要使用管道符隔开
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Do default action for next item.
nnoremap <silent> <D-]>  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <D-[>  :<C-u>CocPrev<CR>
"cocList
nnoremap <silent> <C-l>  :<C-u>CocList<CR>
