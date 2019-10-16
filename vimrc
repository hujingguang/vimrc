" 1. 行间快速移动 num+j,k,l,h
" 2. 格式化: gg+G "
"
set nocompatible
syntax on
filetype plugin indent on
set ic
set hlsearch
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,GB2312,big5
set cursorline
set autoindent
set smartindent
set scrolloff=4
set showmatch
set nu
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
let python_highlight_all=1
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99

map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!clear"
		exec "!time python3 %"
	elseif &filetype == 'html'
		exec "!firefox % &"
	elseif &filetype == 'go'
		" exec "!go build %<"
		exec "!time go run %"
	elseif &filetype == 'mkd'
		exec "!~/.vim/markdown.pl % > %.html &"
		exec "!firefox %.html &"
	endif
endfunc

"安装vundle包管理器 执行命令： git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" 安装自动化格式化工具 ,需要安装 pip install autopep8
Plugin 'Chiel92/vim-autoformat'
nnoremap <F6> :Autoformat<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" 安装文件树插件,快捷键 F1
Plugin 'https://github.com/scrooloose/nerdtree'
nnoremap <F1> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



" 多括号不用颜色区分插件
Plugin 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
			\ ['brown',       'RoyalBlue3'],
			\ ['Darkblue',    'SeaGreen3'],
			\ ['darkgray',    'DarkOrchid3'],
			\ ['darkgreen',   'firebrick3'],
			\ ['darkcyan',    'RoyalBlue3'],
			\ ['darkred',     'SeaGreen3'],
			\ ['darkmagenta', 'DarkOrchid3'],
			\ ['brown',       'firebrick3'],
			\ ['gray',        'RoyalBlue3'],
			\ ['darkmagenta', 'DarkOrchid3'],
			\ ['Darkblue',    'firebrick3'],
			\ ['darkgreen',   'RoyalBlue3'],
			\ ['darkcyan',    'SeaGreen3'],
			\ ['darkred',     'DarkOrchid3'],
			\ ['red',         'firebrick3'],
			\ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" 状态栏插件
Plugin 'https://github.com/bling/vim-airline'


"语法检查插件，需要安装 pip install flake8
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let python_highlight_all=1
syntax on


"屏幕分割设置,快捷键：ctrl+j,k,l,h,分屏：sv or vs , 打开新文件，vs file_name
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"代码折叠设置，快捷键： za 或者 空格键
"Plugin 'LucHermitte/VimFold4C'
Plugin 'tmhedberg/SimpylFold'
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
vnoremap <space> zf
let g:SimpylFold_docstring_preview=1

"配色插件,按F8切换
Plugin 'altercation/vim-colors-solarized'
call togglebg#map("<F8>")
"set background=dark
"colorscheme solarized

"隐藏.pyc文件
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree


"关闭方向键盘
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>


" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

"代码自动补全,需要安装: pip install jedi
Plugin 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'

let g:jedi#completions_command = "<Tab>"
let g:SuperTabDefaultCompletionType = "context"
let g:jedi#popup_on_dot = 0
let g:jedi#auto_initialization = 1
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "1"
let g:jedi#popup_select_first = 0                                                                             


"自动缩进插件
Plugin 'vim-scripts/indentpython.vim'

"缩进线显示插件
Plugin 'Yggdroot/indentLine'
"自动补全括号 
Plugin 'jiangmiao/auto-pairs'
"Git集成插件
Plugin 'tpope/vim-fugitive'

"Python Virtual Env检测
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF

"超级搜索： ctrl+P
Plugin 'kien/ctrlp.vim'

"类显示
Plugin 'https://github.com/vim-scripts/taglist.vim.git'
let Tlist_Use_Right_Window = 1 "右窗口显示
let Tlist_Use_Right_Window = 1

"美化插件和窗口插件
Plugin 'vim-airline/vim-airline-themes'
Bundle 'https://github.com/maksimr/vim-jsbeautify.git'
Bundle 'Molokai'
Bundle 'WinManager'

let g:winManagerWindowLayout = "TagList|FileExplorer"
let g:winManagerWidth = 30
nmap <silent> <F2> :WMToggle<cr>
let g:AutoOpenWinManager = 1
syntax enable
syntax on
set t_Co=256
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1 
let Tlist_Exit_OnlyWindow = 1
"let Tlist_Use_Right_Window = 1
let Tlist_Use_Left_Window = 1
set mouse=a 
let Tlist_Use_SingleClick=1  
colorscheme molokai


"目录树增强插件
Bundle 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup=1
 map <Leader>n <plug>NERDTreeTabsToggle<CR>

Bundle "jaromero/vim-monokai-refined"
Bundle "vim-scripts/desert256.vim"
set t_Co=256
"colorscheme Monokai-Refined
colorscheme  desert256

"按住Shift键启用鼠标右键粘贴复制
