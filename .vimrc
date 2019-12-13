filetype plugin on
"设置leader键
let mapleader = "\<Space>"
"展示行号
set number
"缩进大小
set ts=4
set shiftwidth=4
"为了解决从windows传过来的文件的中文乱码问题
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"支持系统剪贴板
set clipboard+=unnamed
set ignorecase 				"搜索不区分大小写
set autoread                " 当文件在外部被修改时自动更新该文件
set nobackup                " 不生成备份文件
set noswapfile              " 不生成交换文件
set nowrapscan              " 搜索到文件两端时不重新搜索
set nocompatible            " 关闭兼容模式
set hidden                  " 允许在有未保存的修改时切换缓冲区
filetype indent on          " 针对不同的文件类型采用不同的缩进格式
"光标移动配置
inoremap <silent> <C-a> <Esc>I
inoremap <C-e> <End>
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
"设置macvim的字体
set guifont=Monaco:h16
if has("gui_running")
	"设置主题
	:colorscheme adventurous
endif
"插件配置
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'skywind3000/asyncrun.vim'
Plug '/usr/local/opt/fzf' 
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'haya14busa/incsearch.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
"实时搜索预览插件配置
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
"当打开单文件时关闭nerdTrdd窗口，打开文件夹时打开nerdTree窗口
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <leader>l :<C-u>Filetypes<CR>
autocmd FileType * call CocAction('format')
"使用vim异步插件和im-select实现在从insert模式下面退出的时候，自动切换到英文输入法
inoremap <silent> <C-c> <ESC>:<C-u>AsyncRun im-select com.apple.keylayout.ABC<CR>
inoremap <silent> <ESC> <ESC>:<C-u>AsyncRun im-select com.apple.keylayout.ABC<CR>

"coc配置
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

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
"打开光标所在位置的链接。
nnoremap <silent> <leader>open <Plug>(coc-openlink)

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
