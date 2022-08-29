" =============================================================
"vim配置"
"@author raydrawc@gmail.com"
"
"
" =============================================================


" =============================================================
" Initial Plugin 加载插件
" =============================================================
if !exists('g:plug_groups')
    " let g:plug_groups=['python', 'javascript', 'golang', 'php', 'ruby', 'shell', 'markdown', 'html', 'css', 'less', 'coffeescript', 'tmux', 'json', 'beta']
    let g:plug_groups=['erlang', 'markdown', 'html', 'css', 'tmux', 'beta', 'golang']
endif

" =============================================================
" 使用 vim-plug 管理插件
" =============================================================

call plug#begin('~/.vim/plugged')

" 移动光标到插件名上, 使用'#'快速跳转到每个插件的配置处

" syntastic
if v:version < 800
    Plug 'scrooloose/syntastic'         " 通用语法检查
else
    Plug 'w0rp/ale'                     " 异步语法检查
" Plug 'sheerun/vim-polyglot'             " 语法高亮/缩进语言包集合
endif

" Group dependencies, vim-snippets depends on ultisnips
" 代码片段快速插入 (snippets中,是代码片段资源,需要学习)
" Snippets are separated from the engine. Add this if you want them:
" Plug 'honza/vim-snippets'               " 代码片段集合
Plug 'Raimondi/delimitMate'             " 自动补全括号等

Plug 'junegunn/fzf', {'do' : { -> fzf#install()}}
Plug 'junegunn/fzf.vim'                 " 异步模糊搜索插件  必须先装fzf插件

" Plug 'vim-scripts/L9'
Plug 'vim-airline/vim-airline'          " 美化导航栏
Plug 'vim-airline/vim-airline-themes'   " 导航栏主题
"更高效的移动 [,, + w/fx/h/j/k/l]
" Plug 'easymotion/vim-easymotion'        " 快速跳转工具
" Plug 'rking/ag.vim'                     " 高速文件内容搜索，需要先安装'ag(the_silver_searcher)'命令
Plug 'maralla/completor.vim'            " 智能提醒
Plug 'Yggdroot/indentLine'              " 显示缩进 “线”
Plug 'scrooloose/nerdcommenter'         " 快速注释
Plug 'scrooloose/nerdtree',{ 'on':  'NERDTreeToggle' } " 文件管理树 r 刷新
Plug 'Xuyuanp/nerdtree-git-plugin'      " nerdtree 显示 git 最新修改标志
Plug 'joshdick/onedark.vim'             " 配色方案 onedrak
Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'           " 显示git差异  [c ]c 跳转 差异位置
Plug 'tpope/vim-fugitive'               " vim 操作 git 并显示分支

Plug 'luochen1990/rainbow'              " 括号颜色
Plug 'mhinz/vim-startify'               " 初始化界面
Plug 'kana/vim-fakeclip'                " vim 复制文本
" Plug 'Valloric/YouCompleteMe'           " 代码自动完成
"
"
if count(g:plug_groups, 'markdown')

    "
    " Requirements
    " * MichaelMure/mdr or specified markdown parser
    " *Vim 8.1.1401 ~
    " 按需加载 markdown
    Plug 'skanehira/preview-markdown.vim', {'for' : 'markdown'} 
    " 需要先安装ctag
endif

" go 语言加载项
if count(g:plug_groups, 'golang')
    " 1. vim a.go
    " 2. :GoInstallBinaries
    " vimgo  https://github.com/fatih/vim-go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' } " GO语言辅助包
    Plug 'majutsushi/tagbar'
    " Plug 'govim/govim'
    " Plug 'volgar1x/vim-gocode'

    " nmap <silent> <buffer> <Leader>h : <C-u>call GOVIMHover()<CR>
    set timeoutlen=1000 ttimeoutlen=0

endif

" erlang 语言加载项
if count(g:plug_groups, 'erlang')
    Plug 'vim-erlang/vim-erlang-omnicomplete' " 语法提示
    Plug 'vim-erlang/vim-erlang-tags'
    Plug 'ten0s/syntaxerl'                  " erlang语法检查工具
" Plug 'vim-erlang/vim-erlang-compiler' " erlang 同步语法检查工具（保存触发
endif


call plug#end()


" =============================================================
" General Setting 基础配置
" =============================================================
" 重置leader键 空格键
let mapleader =  "\<space>"
let g:mapleader = "\<space>"

set nocompatible                    " 关闭vi兼容模式
set number                          " 显示行号
set history=500                     " 设置操作历史容量
" 设置 =a 会使得mintty复制功能失效
set mouse-=a                         " 支持鼠标点击
set ttymouse=sgr

"set autoread                        " 文件修改后自动载入 :e 手动载入
"colorscheme desert                  " 设置配色方案
colorscheme onedark                  " 设置配色方案

syntax enable                       " 语法识别
syntax on                           " 语法高亮

filetype on                         " 识别文件类型
filetype plugin on                  " 根据文件类型匹配插件
filetype indent on                  " 根据文件类型匹配缩进规则


" 转移备份路径
"set backup
"set backupdir=~/.vim/.backup//
"set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//          " 转移撤销文件路径
" 关闭备份
set nobackup                        " 不创建备份文件
set noswapfile                      " 不创建减缓文件
set undofile                        " 保留撤销历史

" set cursorline                      " 设置当前行高亮
"set cursorcolumn                    " 设置当前列高亮

" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
set selection=inclusive
set selectmode=mouse,key

set backspace=2                     " 修复退格键失效
" set relativenumber
" set textwidth=80                    " 设置超过行数自动换行 (添加换行符)
"搜索
set showmatch                       " 光标自动标亮另一个括号
"设置文件保存路径
set vb t_vb=                        " 关闭声音
set guioptions=                     " 关闭菜单栏
set shellslash                      " 使用'/'作目录分隔符
" set autochdir                       " 设当前编辑文件为当前工作路径
set noautochdir                       " 不随意更改工作路径

if has("autocmd")
    " 记录上次修改文件的位置
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " 关闭换行自动补全注释符
    "autocmd FileType * setlocal formatoptions==c fo==r fo==o
    " 设置loclist 和 quickfix在跨越底部栏显示
    autocmd FileType qf wincmd J
    " 当NerdTree 为剩下唯一窗口是自动关闭
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif

set updatetime=500
set balloondelay=250


"==========================================
" Display Settings 展示/排版等界面格式设置
"==========================================

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" set winwidth=79

" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line - use 2 lines for the status bar
set laststatus=2

" 显示行号
set number
" 取消换行
set wrap                            " 设置自动折行

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2


" 设置文内智能搜索提示
" 高亮search命中的文本
set hlsearch
" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 有一个或以上大写字母时仍大小写敏感
set smartcase

" 代码折叠
" set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
"set foldmethod=indent
"set foldlevel=99
"" 代码折叠自定义快捷键 <leader>zz
"let g:FoldMethod = 0
"map <leader>zz :call ToggleFold()<cr>
"fun! ToggleFold()
"    if g:FoldMethod == 0
"        exe "normal! zM"
"        let g:FoldMethod = 1
"    else
"        exe "normal! zR"
"        let g:FoldMethod = 0
"    endif
"endfun

" 缩进配置
" Smart indent 智能缩进
set smartindent
" 打开自动缩进
" never add copyindent, case error   " copy the previous indentation on autoindenting
set autoindent

" tab相关变更
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest
set ttyfast

" 00x增减数字时使用十进制
set nrformats=

" 防止tmux下vim的背景色显示异常
" Refer: http://sunaku.github.io/vim-256color-bce.html
"if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
""  set t_ut=
"endif

"==========================================
" FileEncode Settings 文件编码,格式
"==========================================
":let $LANG = 'en_US'
" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn
set langmenu=en_US.UTF=8            " 菜单编码
"set enc=2byte-gb18030
" 下面这句只影响普通模式 (非图形界面) 下的 Vim
set termencoding=utf=8              " 终端编码格式

" Use Unix as the standard file type
set fileformats=unix,dos,mac        " 文件格式选择顺序

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B


" =============================================================
" Other Setting 其他设置
" =============================================================
" vimrc文件修改之后自动加载, windows
autocmd! bufwritepost _vimrc source %
" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

" 自动补全配置
" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu


" 增强模式中的命令行自动完成操作
set wildmenu
set wildmode=longest:full,list:full      " 设置命令行模式 显示列表并快速补全
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class
set wildignore+=*/tmp/*,            " MacOSX/Linux
set wildignore+=*\\tmp\\*,          " Windows
set wildignore+=.hg,.git.,svn        " 版本控制
set wildignore+=*.so,*.swp,*.zip,*.beam,*.meta,*.dll,*.dll.mdb,*.exe,*.pyc
set wildignore+=*.png,*.bmp,*.jpg,*.jpeg,*.FBX,*.tga
set wildignore+=*.unity3d,*.prefab,*.unity,*.asset,*.mat,*.meta

" 离开插入模式后自动关闭预览窗口
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

if has("patch-8.1.1904")
  set completeopt+=popup
  set completepopup=align:menu,border:off,highlight:Pmenu
endif
" =============================================================
" HostKey 键位设置
" =============================================================
map <leader>= <esc>gg=G<cr>        " 快速格式化代码

nnoremap <leader># :<C=u>let @/=expand('<cword>')<cr>:set hlsearch<cr>  " 高亮当前单词

" 快速导航
" imap <m=k> <Up>           " Alt + K 插入模式下光标向上移动
" imap <m=j> <Down>         " Alt + J 插入模式下光标向下移动
" imap <m=h> <Left>         " Alt + H 插入模式下光标向左移动
" imap <m=l> <Right>        " Alt + L 插入模式下光标向右移动
imap <C=a> <esc>I
imap <C=e> <esc>A

" buff
noremap <leader>bd :bd<cr>
noremap <leader>bn :bn<cr>
noremap <leader>bp :bp<cr>

" 调整窗口
" nmap <M=k> :resize =3<CR>
" nmap <M=j> :resize +3<CR>
" nmap <M=h> :vertical resize +3<CR>
" nmap <M=l> :vertical resize =3<CR>
nmap <leader>wk <esc>:resize =3<CR>
nmap <leader>wj <esc>:resize +3<CR>
nmap <leader>wl <esc>:vertical resize +3<CR>
nmap <leader>wh <esc>:vertical resize =3<CR>

" tab
" map <c=tab> :tabnext<cr>        " gt
" map <c=s=tab> :tabprevious<cr>  " gT
map <leader>tn :tabnew ./<cr>
map <leader>tc :tabclose<cr>
map <leader>te :tabe<cr>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

func! GetSelectedText()
    normal gv"xy
    let result = getreg("x")
    return result
endfunc

" copy in wsl
if has("clipboard") && executable("clip.exe")
    noremap <leader>y :call system('clip.exe', GetSelectedText())<CR>
else
    vnoremap <leader>y "+y
endif


" 改写 alt 键为双leader键  wsl不识别alt键
" for i in range(97,122)
"   let c = nr2char(i)
"   exec "map <leader><leader>".c." <M=".c.">"
"   " exec "map! \e".c." <M=".c.">"
" endfor


fun Filename()
    let filename = expand('%:t:r')
    if filename == '' | return a:0 == 2 ? a:2 : '' | endif
    return !a:0 || a:1 == '' ? filename : substitute(a:1, '$1', filename, 'g')
endfunc

" loclist
map <leader>lo :lopen<cr>
map <leader>ll :lopen<cr>
map <leader>lw :lopen<cr>
" map <leader>lw :lwindow<cr>       " 不会自动force到loclist
map <leader>lc :lclose<cr>
map <leader>ln :lnext<cr>
map <leader>lp :lprevious<cr>

" quickfix
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <F4> :call ToggleQuickFix()<cr>

map <leader>qq :copen<cr>
map <leader>qo :copen<cr>
map <leader>qw :copen<cr>
" map <leader>qw :cwindow<cr>       " 不会自动 force 到quickfix
map <leader>qc :cclose<cr>
map <leader>qn :cnext<cr>
map <leader>qp :cprevious<cr>

" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
nnoremap <F1> <Esc>

" 打开vimrc快捷键
nnoremap <leader>ev  :split $MYVIMRC<cr>
" 运行当前vimrc脚本
nnoremap <leader>sv  :source $MYVIMRC<cr>


"==========================================
" FileType Settings  文件类型设置
"==========================================

" 具体编辑文件类型的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby,javascript,html,css,xml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
autocmd BufRead,BufNewFile *.part set filetype=html
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai

" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif

"==========================================
" Theme Settings  主题设置
"==========================================
set t_Co=256                        " 强制开启256色  mintty:option=>termain=>type=>xterm=256color

"==========================================
" Theme Settings  插件配置
"==========================================

" ==== [ 插件: vim=indent=guides ] ======================================
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" ==== [ 插件 scrooloose/nerdcommenter ] ================================
" <leader>cc   加注释
" <leader>cu   解开注释
" <leader>ca 切换注释的样式:/*....*/和//..的切换
" <leader>c<space>  加上/解开注释, 智能判断
let g:NERDSpaceDelims = 1        " 在注释后加空格
let g:NERDToggleCheckAllLines = 1   " 检查选中行是否已注释
" 自定义注释
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' }, 'erlang': {'left' : '%%' } }
let g:NERDDefaultAlign = 'left'         " 设置注释对齐方式 (左对齐) 方便删除
" ctrl + / 快速注释 （ctrl + / 映射为 ctrl + _）
map <C-/> <Plug>NERDCommenterToggle
map <leader>/ <Plug>NERDCommenterToggle

" 插件 scroloose/nerdtree =====================================
nmap <C-t> :NERDTreeToggle<CR>
imap <C-t> <esc>:NERDTreeToggle<CR>
nmap <leader>r :NERDTreeToggle<CR>


let NERDTreeShowHidden=1            " 设置显示隐藏文件
let NERDTreeIgnore=[ '\.(swp|svn|pyc)$' ,'\.(png|dll|so|exe)$' , '\.(git|svn)' , '\.(beam)']
let g:NERDTreeNodeDelimiter = "\u00a0"

" ==== [ 插件 junegunn/fzf ] =======================================
let g:fzf_layout = {'down': '~20%'}
" set rtp+=~/.fzf
noremap <leader>ff :FZF<cr>
" 快速启动Ag rg搜索
noremap <leader>fa :Ag<cr>
noremap <leader>fr :Rg<cr>
noremap <leader>fb :Buffers<cr>
noremap <leader>ft :tags<cr>

" 快速搜索工作区

" ==== [ 插件 w0rp/ale ] =====================================
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_delay=500                " 延时编译
" let g:ale_maximun_file_size=1048576     " 设置检查文件最大
let g:ale_lint_on_enter=0               " 打开文件不制动编译
" let g:ale_sign_column_always=1
" let g:ale_open_list=1
" 设置使用不同的编译工具检查代码
let g:ale_linters = { 'erlang': ['syntaxerl'], }

" ==== [插件 airline ] =========================================
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
" ==== [ 插件 completor ] ====================================
let g:completor_erlang_omni_trigger = '[\w=]+:$'
let g:completor_complete_options = 'menuone,noselect'

" ==== [ luochen1990/rainbow] ================================
let g:rainbow_active=1

" ==== [ mhinz/vim=signify ] ================================
let g:signify_update_on_bufenter    = 0     " 缓冲区被修改时更新符号
let g:signify_update_on_focusgained = 1     " vim获取焦点时更新符号
nnoremap <leader>gr :SignifyRefresh<CR>
nmap <leader>gj <plug>(signify=next=hunk)
nmap <leader>gk <plug>(signify=prev=hunk)

" ==== [ easymotion/vim=easymotion ] ================================
" map <Leader><leader>h <Plug>(easymotion=linebackward)
" map <Leader><leader>l <Plug>(easymotion=lineforward)



" go代码提示
imap <C-i> <C-x><C-o>
