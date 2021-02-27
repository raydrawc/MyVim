" =============================================================
"vim配置"
"@author raydrawc@gmail.com"
"
"
" =============================================================


" =============================================================
" Initial Plugin 加载插件
" =============================================================
if filereadable(expand("~/.vimrc.plugin"))
    source ~/.vimrc.plug.vim
endif

" =============================================================
" General Setting 基础配置
" =============================================================
" 重置leader键 空格键
let mapleader =  "\<space>"
let g:mapleader = "\<space>"

set nocompatible                    " 关闭vi兼容模式
set number                          " 显示行号
set history=500                     " 设置操作历史容量
set mouse=a                         " 支持鼠标点击
"set autoread                        " 文件修改后自动载入 :e 手动载入
colorscheme desert                  " 设置配色方案
" colorscheme onedark                  " 设置配色方案

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

set cursorline                      " 设置当前行高亮
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
    autocmd FileType * setlocal formatoptions==c fo==r fo==o
    " 设置loclist 和 quickfix在跨越底部栏显示
    autocmd FileType qf wincmd J
    " 当NerdTree 为剩下唯一窗口是自动关闭
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif

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
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"


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
map <leader>qq :copen<cr>
map <leader>qo :copen<cr>
map <leader>qw :copen<cr>
" map <leader>qw :cwindow<cr>       " 不会自动 force 到quickfix
map <leader>qc :cclose<cr>
map <leader>qn :cnext<cr>
map <leader>qp :cprevious<cr>

" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>"

" 打开vimrc快捷键
nnoremap <leader>ev  :split $MYVIMRC<cr>
nnoremap <leader>ev  :split ~/.zshrc<cr>
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
